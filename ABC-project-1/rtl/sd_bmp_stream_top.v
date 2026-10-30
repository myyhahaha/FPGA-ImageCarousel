// Integration top for Member B. This top exposes a ready/valid RGB stream.
// To use with the existing board pins, connect the FIFO signals in the A/C top.
// Do not make this the standalone board top before adding constraints for outputs.
module sd_bmp_stream_top #(parameter EXTERNAL_SD=0)(
 input wire clk, input wire rst_n,
 input wire [3:0] file_idx,          // 1..7, 切换 IMAGE1..IMAGE7
 input wire restart,                 // 高有效: 重启 reader 重扫 + stream 回 IDLE
 output wire busy,                  // 1=B 侧仍在读(未完成), 供顶层门控按键
 output wire SD_nCS, SD_DCLK, SD_MOSI, input wire SD_MISO,
 input wire fifo_full, output wire [23:0] fifo_din,
 output wire fifo_wr_en,
 output wire [9:0] pixel_x, output wire [8:0] pixel_y_bottom,
 output wire frame_done, output wire [7:0] status,
 input wire ext_init_done,input wire[7:0]ext_data,input wire ext_valid,ext_end,
 output wire ext_req,output wire[31:0]ext_lba,
 output wire fs_ready,output wire[31:0]fs_fat_lba,fs_data_lba,fs_root_cluster,output wire[7:0]fs_spc
);
 wire init_done, sd_valid, sd_end;
 wire [7:0] sd_data;
 wire [31:0] sd_lba;
 wire sd_req;
 wire hdr_req, stream_req, hdr_done, hdr_err;
 wire [31:0] hdr_lba, stream_lba;
 wire [7:0] hdr_code, stream_code;
 wire [31:0] file_size, file_cluster, width, height, pixel_offset;
 wire [31:0] compression, first_lba, fat_lba, data_lba;
 wire [7:0] spc;
 wire [15:0] bpp;
 wire [23:0] pixel_rgb;
 wire pixel_valid, pixel_ready, stream_error;
 reg stream_start, started;
 assign ext_req=sd_req;assign ext_lba=sd_lba;
 assign fs_ready=hdr_done;assign fs_fat_lba=fat_lba;assign fs_data_lba=data_lba;assign fs_spc=spc;
 assign sd_req=hdr_done ? stream_req : hdr_req;
 assign sd_lba=hdr_done ? stream_lba : hdr_lba;
 assign busy=~frame_done;
 assign status=hdr_err ? hdr_code : stream_error ? stream_code :
               frame_done ? 8'hA5 : hdr_done ? 8'h22 :
               init_done ? 8'h11 : 8'h00;
 always @(posedge clk or negedge rst_n) begin
  if(!rst_n) begin stream_start<=0;started<=0;end
  else begin
   stream_start<=0;
   if(restart) started<=0;
   else if(hdr_done && !started) begin stream_start<=1;started<=1;end
  end
 end
 // ★ 联调修改: SD 卡 SPI 高速档从 12.5MHz(div=0) 降到 3.1MHz(div=6)。
 //   原因: 12.5MHz+8mA 驱动的快速跳变会干扰 HDMI 的 200MHz TMDS 和
 //   150MHz SDRAM(实测插卡即花屏/黑屏)。降速后读 640x480 图约 2~3 秒。
 //   注意配合 sd_card_sec_read_write.v 里的分频 bug 修复一起使用。
 generate if(!EXTERNAL_SD)begin:g_internal
 sd_card_top #(.SPI_LOW_SPEED_DIV(248), .SPI_HIGH_SPEED_DIV(6)) sd(
  .clk(clk),.rst(~rst_n),.SD_nCS(SD_nCS),
  .SD_DCLK(SD_DCLK),.SD_MOSI(SD_MOSI),.SD_MISO(SD_MISO),
  .sd_init_done(init_done),.sd_sec_read(sd_req),.sd_sec_read_addr(sd_lba),
  .sd_sec_read_data(sd_data),.sd_sec_read_data_valid(sd_valid),
  .sd_sec_read_end(sd_end),.sd_sec_write(1'b0),
  .sd_sec_write_addr(32'd0),.sd_sec_write_data(8'd0),
  .sd_sec_write_data_req(),.sd_sec_write_end());
 end else begin:g_external
  assign init_done=ext_init_done;assign sd_data=ext_data;assign sd_valid=ext_valid;assign sd_end=ext_end;
  assign SD_nCS=1'b1;assign SD_DCLK=1'b0;assign SD_MOSI=1'b1;
 end endgenerate
 // ★ 文件名由顶层 img_idx 动态决定, TARGET_NAME 参数仅保留兼容旧例化, 不参与匹配。
 fat32_bmp_reader #(.TARGET_NAME("IMAGE7  BMP")) reader(
  .clk(clk),.rst(~rst_n),.init_done(init_done),
  .file_idx(file_idx),.restart(restart),
  .read_req(hdr_req),.read_lba(hdr_lba),.read_data(sd_data),
  .byte_valid(sd_valid),.read_end(sd_end),.done(hdr_done),
  .error(hdr_err),.error_code(hdr_code),.file_size(file_size),
  .file_cluster(file_cluster),.width(width),.height(height),
  .pixel_offset(pixel_offset),.bits_per_pixel(bpp),
  .compression(compression),.first_data_lba(first_lba),
  .fat_base_lba(fat_lba),.data_base_lba(data_lba),
  .sectors_per_cluster(spc),.root_cluster_out(fs_root_cluster));
 bmp_pixel_stream stream(
  .clk(clk),.rst(~rst_n),.start(stream_start),.restart(restart),
  .file_cluster(file_cluster),.file_size(file_size),
  .pixel_offset(pixel_offset),.fat_lba(fat_lba),
  .data_lba(data_lba),.sectors_per_cluster(spc),
  .read_req(stream_req),.read_lba(stream_lba),
  .read_data(sd_data),.byte_valid(sd_valid),.read_end(sd_end),
  .pixel_rgb(pixel_rgb),.pixel_valid(pixel_valid),
  .pixel_ready(pixel_ready),.pixel_x(pixel_x),
  .pixel_y_bottom(pixel_y_bottom),.frame_done(frame_done),
  .error(stream_error),.error_code(stream_code));
 pixel_fifo_bridge bridge(.pixel_rgb(pixel_rgb),
  .pixel_valid(pixel_valid),.pixel_ready(pixel_ready),
  .fifo_full(fifo_full),.fifo_din(fifo_din),.fifo_wr_en(fifo_wr_en));
endmodule

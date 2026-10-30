// Stage 2: 512-byte sector buffering, FAT32 cluster chaining, BMP24 BGR->RGB.
// One pixel per valid/ready handshake. y_bottom=0 is BMP's bottom row.
// SDHC/SDXC LBA addressing, 512-byte sectors, uncompressed 640x480 BMP.
module bmp_pixel_stream(
 input wire clk, input wire rst, input wire start,
 input wire restart,
 input wire [31:0] file_cluster, file_size, pixel_offset,
 input wire [31:0] fat_lba, data_lba,
 input wire [7:0] sectors_per_cluster,
 output reg read_req, output reg [31:0] read_lba,
 input wire [7:0] read_data, input wire byte_valid, input wire read_end,
 output reg [23:0] pixel_rgb, output reg pixel_valid,
 input wire pixel_ready,
 output reg [9:0] pixel_x, output reg [8:0] pixel_y_bottom,
 output reg frame_done, output reg error,
 output reg [7:0] error_code
);
 localparam IDLE=0, REQ=1, CAP=2, DRAIN=3, NEXT=4, FAT_REQ=5,
            FAT_CAP=6, FAT_CHECK=7, FINISH=8, FAIL=9;
 reg [3:0] state;
 reg [7:0] mem[0:511];
 reg [9:0] count, rd_ptr;
 reg [31:0] cluster, cluster_index, file_pos, fat_entry;
 reg [7:0] sec_in_cluster;
 reg [1:0] component;
 reg [7:0] blue,green;
 reg [31:0] pixels_emitted;
 reg [31:0] hops;
 wire [31:0] cluster_lba = data_lba + (cluster-32'd2)*sectors_per_cluster;
 wire [31:0] total_pixels = 32'd307200;
 wire [31:0] needed_end = pixel_offset + 32'd921600;
 wire [31:0] fat_index = cluster & 32'd127;
 // All valid pixels are consumed only after full sector buffering.
 // pixel_valid remains asserted under backpressure; read_ptr only advances when ready.
 always @(posedge clk or posedge rst) begin
  if(rst) begin
   state<=IDLE; read_req<=0; read_lba<=0; count<=0; rd_ptr<=0;
   cluster<=0; cluster_index<=0; file_pos<=0; fat_entry<=0;
   sec_in_cluster<=0; component<=0; blue<=0;green<=0;
   pixel_rgb<=0;pixel_valid<=0;pixel_x<=0;pixel_y_bottom<=0;
   frame_done<=0;error<=0;error_code<=0;pixels_emitted<=0;hops<=0;
  end else if(restart) begin
   // ★ 手动切图: 解锁上一轮 FINISH/FAIL, 回 IDLE 等 reader 重新 done 后发 start
   state<=IDLE; read_req<=0; read_lba<=0; count<=0; rd_ptr<=0;
   cluster<=0; cluster_index<=0; file_pos<=0; fat_entry<=0;
   sec_in_cluster<=0; component<=0; blue<=0;green<=0;
   pixel_rgb<=0;pixel_valid<=0;pixel_x<=0;pixel_y_bottom<=0;
   frame_done<=0;error<=0;error_code<=0;pixels_emitted<=0;hops<=0;
  end else begin
   read_req<=0;
   case(state)
    IDLE: if(start) begin
      frame_done<=0;error<=0;error_code<=0;pixel_valid<=0;
      if(file_cluster<2 || sectors_per_cluster==0 ||
         (sectors_per_cluster & (sectors_per_cluster-8'd1))!=0 ||
         pixel_offset>32'hffff0000 || needed_end>file_size) begin
       error<=1;error_code<=8'hD1;state<=FAIL;
      end else begin
       cluster<=file_cluster;sec_in_cluster<=0;file_pos<=0;
       component<=0;pixel_x<=0;pixel_y_bottom<=0;
       pixels_emitted<=0;hops<=0;
       read_lba<=data_lba+(file_cluster-32'd2)*sectors_per_cluster;
       state<=REQ;
      end
    end
    REQ: begin count<=0;read_req<=1;state<=CAP;end
    CAP: begin
      if(byte_valid) begin
       if(count<512) begin mem[count[8:0]]<=read_data;count<=count+1'b1;end
       else begin error<=1;error_code<=8'hD2;state<=FAIL;end
      end
      if(read_end) begin
       if(count!=512) begin error<=1;error_code<=8'hD2;state<=FAIL;end
       else begin rd_ptr<=0;state<=DRAIN;end
      end
    end
    DRAIN: begin
      if(pixel_valid) begin
       if(pixel_ready) begin
        pixel_valid<=0;
        pixels_emitted<=pixels_emitted+1'b1;
        if(pixel_x==639) begin pixel_x<=0;pixel_y_bottom<=pixel_y_bottom+1'b1;end
        else pixel_x<=pixel_x+1'b1;
       end
      end else if(pixels_emitted==total_pixels) begin
       frame_done<=1;state<=FINISH;
      end else if(rd_ptr==512) begin
       state<=NEXT;
      end else if(file_pos < pixel_offset) begin
       file_pos<=file_pos+1'b1;rd_ptr<=rd_ptr+1'b1;
      end else begin
       case(component)
        0: begin blue<=mem[rd_ptr[8:0]];component<=1;end
        1: begin green<=mem[rd_ptr[8:0]];component<=2;end
        2: begin
         pixel_rgb<={mem[rd_ptr[8:0]],green,blue};
         pixel_valid<=1;component<=0;
        end
       endcase
       file_pos<=file_pos+1'b1;rd_ptr<=rd_ptr+1'b1;
      end
    end
    NEXT: begin
     if(sec_in_cluster+1'b1<sectors_per_cluster) begin
      sec_in_cluster<=sec_in_cluster+1'b1;
      read_lba<=read_lba+1'b1;state<=REQ;
     end else begin
      read_lba<=fat_lba+(cluster>>7);state<=FAT_REQ;
     end
    end
    FAT_REQ: begin count<=0;fat_entry<=0;read_req<=1;state<=FAT_CAP;end
    FAT_CAP: begin
     if(byte_valid) begin
      if(count<512) begin
       if(count[8:2]==cluster[6:0]) begin
        case(count[1:0])
         0:fat_entry[7:0]<=read_data;
         1:fat_entry[15:8]<=read_data;
         2:fat_entry[23:16]<=read_data;
         3:fat_entry[31:24]<=read_data;
        endcase
       end
       count<=count+1'b1;
      end else begin error<=1;error_code<=8'hD2;state<=FAIL;end
     end
     if(read_end) begin
      if(count!=512) begin error<=1;error_code<=8'hD2;state<=FAIL;end
      else state<=FAT_CHECK;
     end
    end
    FAT_CHECK: begin
     if((fat_entry & 32'h0fffffff)<2 ||
        (fat_entry & 32'h0fffffff)>=32'h0ffffff8 || hops>32'd100000) begin
      error<=1;error_code<=8'hD3;state<=FAIL;
     end else begin
      cluster<=fat_entry & 32'h0fffffff;
      read_lba<=data_lba+((fat_entry & 32'h0fffffff)-32'd2)*sectors_per_cluster;
      sec_in_cluster<=0;hops<=hops+1'b1;state<=REQ;
     end
    end
    FINISH: state<=FINISH;
    FAIL: begin pixel_valid<=0;state<=FAIL;end
    default: state<=FAIL;
   endcase
  end
 end
endmodule

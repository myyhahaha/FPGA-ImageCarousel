// One physical TF interface, image sector client and priority-buffered music.
module abc_sd_media(
 input clk,rst_n,input[3:0]file_idx,input restart,output busy,
 output SD_nCS,SD_DCLK,SD_MOSI,input SD_MISO,input fifo_full,output[23:0]fifo_din,output fifo_wr_en,
 output[9:0]pixel_x,output[8:0]pixel_y_bottom,output frame_done,output[7:0]status,
 input audio_clk,audio_read,output[15:0]audio_data,output audio_empty,output[12:0]audio_level,
 output[7:0]audio_status
);
 wire init_done,card_req,card_valid,card_end;wire[31:0]card_lba;wire[7:0]card_data;
 wire ireq,ival,iend,areq,aval,aend;wire[31:0]ilba,alba;
 wire mounted;wire[31:0]fat_lba,data_lba,root_cluster;wire[7:0]spc;
 wire find_req,stream_req,found,find_error,stream_error;wire[31:0]find_lba,stream_lba,file_cluster,file_size,loops;
 wire[7:0]find_code,stream_code;wire[15:0]pcm;wire pcm_valid,pcm_full;wire[12:0]write_level;
 assign areq=found ? stream_req:find_req;
 assign alba=found ? stream_lba:find_lba;
 assign audio_status=find_error ? find_code:stream_error ? stream_code:found ? 8'ha5:8'h00;
 sd_card_top #(.SPI_LOW_SPEED_DIV(248),.SPI_HIGH_SPEED_DIV(6)) sd(
  .clk(clk),.rst(!rst_n),.SD_nCS(SD_nCS),.SD_DCLK(SD_DCLK),.SD_MOSI(SD_MOSI),.SD_MISO(SD_MISO),
  .sd_init_done(init_done),.sd_sec_read(card_req),.sd_sec_read_addr(card_lba),.sd_sec_read_data(card_data),
  .sd_sec_read_data_valid(card_valid),.sd_sec_read_end(card_end),.sd_sec_write(1'b0),.sd_sec_write_addr(32'd0),.sd_sec_write_data(8'd0),.sd_sec_write_data_req(),.sd_sec_write_end());
 abc_sd_sector_arbiter u_sectors(.clk(clk),.rst(!rst_n),.image_req(ireq),.image_lba(ilba),.audio_req(areq),.audio_lba(alba),
  .audio_urgent(write_level<2048),.card_req(card_req),.card_lba(card_lba),.card_valid(card_valid),.card_end(card_end),
  .image_valid(ival),.image_end(iend),.audio_valid(aval),.audio_end(aend));
 sd_bmp_stream_top #(.EXTERNAL_SD(1)) u_images(
  .clk(clk),.rst_n(rst_n),.file_idx(file_idx),.restart(restart),.busy(busy),.SD_nCS(),.SD_DCLK(),.SD_MOSI(),.SD_MISO(1'b1),
  .fifo_full(fifo_full),.fifo_din(fifo_din),.fifo_wr_en(fifo_wr_en),.pixel_x(pixel_x),.pixel_y_bottom(pixel_y_bottom),.frame_done(frame_done),.status(status),
  .ext_init_done(init_done),.ext_data(card_data),.ext_valid(ival),.ext_end(iend),.ext_req(ireq),.ext_lba(ilba),
  .fs_ready(mounted),.fs_fat_lba(fat_lba),.fs_data_lba(data_lba),.fs_root_cluster(root_cluster),.fs_spc(spc));
 abc_wav_find u_find(.clk(clk),.rst(!rst_n),.mounted(mounted),.fat_lba(fat_lba),.data_lba(data_lba),.root_cluster(root_cluster),.spc(spc),
  .read_req(find_req),.read_lba(find_lba),.read_data(card_data),.byte_valid(aval),.read_end(aend),
  .done(found),.error(find_error),.error_code(find_code),.file_cluster(file_cluster),.file_size(file_size));
 abc_wav_stream u_music(.clk(clk),.rst(!rst_n),.start(found),.need_data(write_level<3072),.file_cluster(file_cluster),.file_size(file_size),.fat_lba(fat_lba),.data_lba(data_lba),.spc(spc),
  .read_req(stream_req),.read_lba(stream_lba),.read_data(card_data),.byte_valid(aval),.read_end(aend),.pcm_data(pcm),.pcm_valid(pcm_valid),.pcm_ready(!pcm_full),.error(stream_error),.error_code(stream_code),.loop_count(loops));
 abc_pcm_fifo u_audio_fifo(.wr_clk(clk),.wr_rst(!rst_n),.wr_en(pcm_valid && !pcm_full),.din(pcm),.full(pcm_full),
  .rd_clk(audio_clk),.rd_rst(!rst_n),.rd_en(audio_read),.dout(audio_data),.empty(audio_empty),.wr_level(write_level),.rd_level(audio_level));
endmodule

`timescale 1ns/1ps
module abc_tb_media_bandwidth;
 reg clk=0,aclk=0,rstn=0,play=0;always #10 clk=~clk;always #12.5 aclk=~aclk;
 wire[15:0]pcm;wire empty,read;wire[12:0]level;wire[7:0]audio_status;wire pixels,done;
 wire valid,playing,underrun;wire[23:0]left,right;
 abc_sd_media dut(.clk(clk),.rst_n(rstn),.file_idx(4'd7),.restart(1'b0),.busy(),.SD_nCS(),.SD_DCLK(),.SD_MOSI(),.SD_MISO(1'b1),
 .fifo_full(1'b0),.fifo_din(),.fifo_wr_en(pixels),.pixel_x(),.pixel_y_bottom(),.frame_done(done),.status(),
 .audio_clk(aclk),.audio_read(read),.audio_data(pcm),.audio_empty(empty),.audio_level(level),.audio_status(audio_status));
 defparam dut.sd.BYTE_CYCLES=144; // Includes conservative command/response overhead at divider 6.
 abc_pcm_playback player(.clk(aclk),.rst(!rstn),.play_enable(play),.fifo_data(pcm),.fifo_empty(empty),.fifo_level(level),
 .fifo_read(read),.audio_valid(valid),.audio_left(left),.audio_right(right),.playing(playing),.underrun(underrun));
 reg[15:0]expected[0:65535];integer count=0,image_pixels=0,minimum=4096;
 initial $readmemh("ab_verify/results/music_first.hex",expected);
 always @(posedge clk)if(pixels)image_pixels=image_pixels+1;
 always @(posedge aclk)if(rstn && play)begin
  if(read)begin
   if(pcm!==expected[count])$fatal(1,"slow card music mismatch %0d",count);
   count=count+1;
  end
  if(level<minimum)minimum=level;
  if(underrun)$fatal(1,"slow card audio underrun at sample %0d",count);
 end
 initial begin
  #100;rstn=1;#100000000;play=1;#1000000000;
  if(count<47990 || image_pixels<80000 || audio_status!=8'ha5)$fatal(1,"media bandwidth coverage pcm%0d image%0d status%h",count,image_pixels,audio_status);
  $display("PASS shared TF bandwidth: 1 s of 48 kHz exact music, %0d PCM frames, %0d BMP pixels concurrently; conservative 144 sys clocks/byte, lowest FIFO %0d samples, zero underruns",count,image_pixels,minimum);$finish;
 end
endmodule

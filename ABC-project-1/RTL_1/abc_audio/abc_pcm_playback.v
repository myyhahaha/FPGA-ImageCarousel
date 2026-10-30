// Exact-average 48 kHz in the 40 MHz pixel domain. PCM16 mono is sent to both
// HDMI channels; the visualizer sees these same post-mute PCM samples.
module abc_pcm_playback #(parameter CLK_HZ=40000000,SAMPLE_HZ=48000,PREFILL=1024)(
 input clk,rst,play_enable,input[15:0]fifo_data,input fifo_empty,input[12:0]fifo_level,
 output fifo_read,output reg audio_valid,output reg[23:0]audio_left,audio_right,
 output reg playing,output reg underrun
);
 reg[25:0]phase;
 wire tick=phase>=CLK_HZ-SAMPLE_HZ;
 wire take=play_enable && (playing || fifo_level>=PREFILL) && !fifo_empty;
 assign fifo_read=tick && take;
 always @(posedge clk or posedge rst)begin
  if(rst)begin phase<=0;audio_valid<=0;audio_left<=0;audio_right<=0;playing<=0;underrun<=0;end
  else begin
   phase<=tick ? phase-(CLK_HZ-SAMPLE_HZ):phase+SAMPLE_HZ;
   audio_valid<=tick;
   if(!play_enable)playing<=0;
   if(tick)begin
    if(take)begin audio_left<={fifo_data,8'd0};audio_right<={fifo_data,8'd0};playing<=1;end
    else begin
     audio_left<=0;audio_right<=0;
     if(play_enable && playing && fifo_empty)begin underrun<=1;playing<=0;end
    end
   end
  end
 end
endmodule

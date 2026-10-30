`timescale 1ns/1ps
module abc_tb_pcm_playback;
 reg clk=0,rst=1,play=0,empty=0;always #5 clk=~clk;
 reg[12:0]level=4096;reg[15:0]data=16'h8000;wire pop,valid,playing,underrun;wire[23:0]left,right;
 wire acv;wire[19:0]cts,n;
 abc_pcm_playback dut(.clk(clk),.rst(rst),.play_enable(play),.fifo_data(data),.fifo_empty(empty),.fifo_level(level),.fifo_read(pop),.audio_valid(valid),.audio_left(left),.audio_right(right),.playing(playing),.underrun(underrun));
 abc_acr_calc acr(.I_clk(clk),.I_rst(rst),.I_audio_valid(valid),.O_acr_valid(acv),.O_acr_cts(cts),.O_acr_n(n));
 integer cycle=0,ticks=0,pops=0,acrs=0;reg ref_play=0,expected_tick,eligible;reg[23:0]expected_sample=0;
 always @(negedge clk)begin
  if(cycle==100000)play=1;
  if(cycle==2000000)begin empty=1;level=0;end
  if(cycle==2010000)begin empty=0;level=1;end
  if(cycle==2050000)level=2048;
 end
 always @(posedge clk)if(!rst)begin
  cycle=cycle+1;
  expected_tick=(cycle*3/2500)!=((cycle-1)*3/2500);
  eligible=play && (ref_play || level>=1024) && !empty;
  if(pop!==(expected_tick && eligible))$fatal(1,"PCM pop phase differs from 48kHz rational clock");
  if(expected_tick)begin
   ticks=ticks+1;expected_sample=eligible?{data,8'd0}:24'd0;
   if(eligible)begin pops=pops+1;data<=data+16'd137;ref_play=1;end
   else if(play && ref_play && empty)ref_play=0;
  end
  if(!play)ref_play=0;
  #1;
  if(valid!==expected_tick || left!==expected_sample || right!==expected_sample)$fatal(1,"PCM output/mute/order mismatch cycle=%0d",cycle);
  if(acv)begin
   if(n!=6144 || (acrs>0 && cts!=40000))$fatal(1,"ACR rate mismatch CTS=%0d N=%0d",cts,n);
   acrs=acrs+1;
  end
  if(cycle==40000000)begin
   if(ticks!=48000 || acrs<999 || !underrun || pops<47000)$fatal(1,"PCM rate/rebuffer coverage incomplete");
   $display("PASS PCM playback: 40000000 clocks -> 48000 sample strobes; %0d ordered stereo-duplicated PCM frames, startup mute, starvation/rebuffer, %0d ACR packets N=6144 CTS=40000",pops,acrs);$finish;
  end
 end
 initial begin repeat(6)@(negedge clk);rst=0;end
 initial begin #401000000;$fatal(1,"PCM playback timeout");end
endmodule

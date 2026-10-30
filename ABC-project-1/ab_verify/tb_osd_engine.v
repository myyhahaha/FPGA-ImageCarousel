`timescale 1ns/1ps
module tb_osd_engine;
 `include "ab_verify/osd_golden.svh"
 reg clk=0,reset_n=0;
 always #5 clk=~clk;
 reg visible=1;reg[23:0]rgb=0,expected_rgb=0;reg de=0,hs=0,vs=0;
 reg[10:0]x=0,y=0,scroll=0;reg[27:0]bcd=0;
 reg[9:0]wave_levels;always @(posedge clk)wave_levels<=gold_wave[x>=80 && x<720?x-80:0];
 wire[23:0]out_rgb;wire out_de,out_hs,out_vs;wire[10:0]out_x,out_y;
 ab_osd_engine dut(.clk(clk),.reset_n(reset_n),.visible(visible),.in_rgb(rgb),.in_de(de),.in_hs(hs),.in_vs(vs),.in_x(x),.in_y(y),
 .wave_levels(wave_levels),.scroll_q2(scroll),.frame_bcd(bcd),.out_rgb(out_rgb),.out_de(out_de),.out_hs(out_hs),.out_vs(out_vs),.out_x(out_x),.out_y(out_y));
 localparam N=1264336;
 reg[111:0]vectors[0:N-1];
 reg[48:0]history[0:3];
 reg valid[0:3];reg feeding=0;
 integer i,j,checked=0;
 initial begin
  $readmemh("ab_verify/results/osd_vectors.hex",vectors);
  for(i=0;i<4;i=i+1)begin history[i]=0;valid[i]=0;end
  repeat(3)@(negedge clk);reset_n=1;
  for(i=0;i<N;i=i+1)begin
   @(negedge clk);feeding=1;
   visible=vectors[i][109];scroll=vectors[i][108:98];bcd=vectors[i][97:70];x=vectors[i][69:59];y=vectors[i][58:48];rgb=vectors[i][47:24];expected_rgb=vectors[i][23:0];
   de=x<800 && y<600;hs=x>=840 && x<968;vs=y>=601 && y<605;
   if((visible?gold_osd(x,y,rgb,scroll,bcd,de):24'd0)!==expected_rgb)$fatal(1,"independent SV/Python scoreboard disagreement vector=%0d",i);
  end
  @(negedge clk);feeding=0;repeat(6)@(negedge clk);
  if(checked!=N)$fatal(1,"OSD vector count %0d expected %0d",checked,N);
  reset_n=0;#1;
  if({out_rgb,out_de,out_hs,out_vs,out_x,out_y}!==49'd0)$fatal(1,"asynchronous reset failed");
  $display("PASS OSD engine: %0d independent Python reference pixels; 3 alpha layers, all fractional phases, ticker wrap, all top/bottom pixels and real PCM envelope, RGB bypass, blanking, sync/coordinate latency, reset",checked);$finish;
 end
 always @(posedge clk)if(reset_n)begin
  for(j=3;j>0;j=j-1)begin history[j]=history[j-1];valid[j]=valid[j-1];end
  history[0]={expected_rgb,de,hs,vs,x,y};valid[0]=feeding;
  #1;
  if(valid[3])begin
   if({out_rgb,out_de,out_hs,out_vs,out_x,out_y}!==history[3])
    $fatal(1,"OSD pixel %0d xy=(%0d,%0d) got=%h expected=%h",checked,out_x,out_y,{out_rgb,out_de,out_hs,out_vs,out_x,out_y},history[3]);
   checked=checked+1;
  end
 end
 initial begin #15000000;$fatal(1,"OSD engine timeout");end
endmodule

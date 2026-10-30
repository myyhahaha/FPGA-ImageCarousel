`timescale 1ns/1ps
module tb_osd_clock;
 reg clk=0,reset_n=0,frame_blank=0,enable=0;
 always #5 clk=~clk;
 wire[10:0]scroll;wire[27:0]bcd;
 ab_osd_clock #(.CLK_HZ(4)) dut(.clk(clk),.reset_n(reset_n),.frame_blank(frame_blank),.enable(enable),.scroll_q2(scroll),.frame_bcd(bcd));
 integer ticks=0,seconds=0,ref_scroll=0,checks=0,frames=0;
 reg[27:0]ref_bcd=0;
 function[27:0]as_bcd;input integer t;integer hh,mm,ss;
 begin
  hh=t/3600;mm=t/60%60;ss=t%60;
  as_bcd=(hh/100<<24)|(hh/10%10<<20)|(hh%10<<16)|(mm/10<<12)|(mm%10<<8)|(ss/10<<4)|(ss%10);
 end endfunction
 always @(negedge clk)if(reset_n)frame_blank=(ticks%17==0);
 always @(posedge clk)if(reset_n && enable)begin
  if(frame_blank)begin ref_bcd=as_bcd(seconds);ref_scroll=(ref_scroll+2)%1168;frames=frames+1;end
  ticks=ticks+1;if(ticks%4==0 && seconds<3599999)seconds=seconds+1;
  #1;
  if(dut.elapsed_bcd!==as_bcd(seconds) || scroll!==ref_scroll || bcd!==ref_bcd)
   $fatal(1,"clock tick %0d seconds=%0d elapsed=%h expected=%h frame=%h expected=%h scroll=%0d expected=%0d",ticks,seconds,dut.elapsed_bcd,as_bcd(seconds),bcd,ref_bcd,scroll,ref_scroll);
  checks=checks+1;
 end
 initial begin
  repeat(3)@(negedge clk);#1;reset_n=1;
  repeat(1000)begin
   @(negedge clk);
   if({scroll,bcd,dut.elapsed_bcd,dut.subsecond}!==0)$fatal(1,"timer/scroll advanced before image start");
  end
  #1;enable=1;
  // 100 hours of accelerated operation checks every decimal/minute/hour carry.
  wait(checks>=1440010);
  @(negedge clk);#1;reset_n=0;#1;
  if({scroll,bcd,dut.elapsed_bcd,dut.subsecond}!==0)$fatal(1,"clock reset failed");
  ticks=0;seconds=3599998;ref_scroll=0;ref_bcd=0;
  dut.elapsed_bcd=28'h9995958;
  #1;reset_n=1;wait(checks>=1440050);
  $display("PASS OSD clock: %0d clock checks, %0d frame snapshots; 1000 waiting clocks, 100-hour continuous carry run, fractional ticker wrap, frame-atomic state, 999:59:59 saturation and reset",checks,frames);$finish;
 end
 initial begin #15000000;$fatal(1,"clock timeout");end
endmodule

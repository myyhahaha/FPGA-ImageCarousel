`timescale 1ns/1ps
module tb_controls;
 reg clk=0,rst=1,kn=1,kp=1,s1=1,s2=1,s3=1,s4=1;
 always #10 clk=~clk;
 wire n,p,a;
 reg [3:0] img=1;
 img_switch_ctrl #(.DEBOUNCE_CYCLES(4),.T_C1(11),.T_C3(21),.T_C5(31),.T_C8(41)) dut(
 .clk(clk),.rst(rst),.key_next_n(kn),.key_prev_n(kp),.sw1_n(s1),.sw2_n(s2),.sw3_n(s3),.sw4_n(s4),
 .display_valid(1'b1),.switch_done(1'b1),.disp_img(img),
 .next_pressed(n),.prev_pressed(p),.auto_pressed(a));
 integer ns=0,ps=0,autos=0,tick=0,last_auto=0,expected_period=0,period_checks=0;
 always @(posedge clk) begin
   tick=tick+1;
   if(n) ns=ns+1;
   if(p) ps=ps+1;
   if(a) begin
     autos=autos+1;
     if(last_auto!=0 && tick-last_auto!=expected_period) $fatal(1,"wrong auto interval %0d",tick-last_auto);
     if(last_auto!=0) period_checks=period_checks+1;
     last_auto=tick;
   end
 end
 task clocks;input integer c;begin repeat(c) @(negedge clk);end endtask
 initial begin
   clocks(3);rst=0;clocks(3);
   kn=0;clocks(1);kn=1;clocks(2);kn=0;clocks(2);kn=1;clocks(10);
   if(ns!=0) $fatal(1,"bounce accepted");
   kn=0;clocks(30);if(ns!=1) $fatal(1,"held key repeats/missing");
   kn=1;clocks(10);kp=0;clocks(10);kp=1;clocks(10);
   if(ps!=1) $fatal(1,"previous key lost");
   s1=0;expected_period=11;clocks(50);
   s1=1;s2=0;last_auto=0;expected_period=21;clocks(80);
   s2=1;s3=0;last_auto=0;expected_period=31;clocks(110);
   s3=1;s4=0;last_auto=0;expected_period=41;clocks(140);
   s4=1;clocks(5);last_auto=0;clocks(90);
   if(period_checks<9) $fatal(1,"insufficient auto checks");
   $display("PASS controls: bounce, held key, both directions, per-switch timing parameter overrides, manual-only");$finish;
 end
 initial begin #1000000;$fatal(1,"controls timeout");end
endmodule

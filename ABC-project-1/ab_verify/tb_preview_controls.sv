`timescale 1ns/1ps
module tb_preview_controls;
 reg clk=0,rst=1,ready=0,kn=1,kp=1,ku=1,kd=1,blank=0;
 always #10 clk=~clk;
 wire next_key,prev_key,auto_key;wire[3:0]level;
 img_switch_ctrl #(.DEBOUNCE_CYCLES(4),.T_C1(1000)) nav(.clk(clk),.rst(rst),
  .key_next_n(kn),.key_prev_n(kp),.sw1_n(1'b0),.sw2_n(1'b0),.sw3_n(1'b0),.sw4_n(1'b0),
  .display_valid(ready),.switch_done(1'b1),.disp_img(4'd8),.next_pressed(next_key),.prev_pressed(prev_key),.auto_pressed(auto_key));
 abc_brightness_ctrl #(.DEBOUNCE_CYCLES(4)) light(.clk(clk),.reset_n(!rst),.enable(ready),
  .frame_blank(blank),.key_brighter_n(ku),.key_dimmer_n(kd),.level(level));
 integer ns=0,ps=0;
 always @(posedge clk)begin
  if(next_key)ns=ns+1;if(prev_key)ps=ps+1;
  if(!ready && (next_key || prev_key || auto_key || nav.count!=0))$fatal(1,"preview accepted navigation/timer");
 end
 task ticks;input integer n;begin repeat(n)@(negedge clk);end endtask
 initial begin
  ticks(3);rst=0;kn=0;kp=0;ku=0;kd=0;ticks(30);
  ready=1;ticks(30);blank=1;ticks(1);blank=0;
  if(ns!=0 || ps!=0 || level!=4 || light.requested!=4)$fatal(1,"held preview keys leaked after unlock");
  kn=1;kp=1;ku=1;kd=1;ticks(12);
  kn=0;ku=0;ticks(12);kn=1;ku=1;ticks(12);blank=1;ticks(1);blank=0;
  if(ns!=1 || ps!=0 || level!=5)$fatal(1,"fresh K1/K3 did not work after release");
  kp=0;kd=0;ticks(12);kp=1;kd=1;ticks(12);blank=1;ticks(1);blank=0;
  if(ns!=1 || ps!=1 || level!=4)$fatal(1,"fresh K2/K4 did not work after release");
  $display("PASS preview control lock: all four held keys and enabled SW ignored during preview; release required after unlock; fresh K1/K2/K3/K4 work");
  $finish;
 end
 initial begin #100000;$fatal(1,"preview controls timeout");end
endmodule

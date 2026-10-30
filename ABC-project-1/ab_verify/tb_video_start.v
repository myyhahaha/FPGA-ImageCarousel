`timescale 1ns/1ps
module tb_video_start;
 reg clk=0,reset_n=0,ready=0,frame_begin=0;
 always #5 clk=~clk;
 wire presenting;
 ab_video_start dut(.clk(clk),.reset_n(reset_n),.image_ready_async(ready),.frame_begin(frame_begin),.presenting(presenting));
 integer cycle=0,ready_samples=0,checks=0,starts=0,phase;reg seen=0,expected;
 always @(negedge clk)begin
  if(!reset_n)begin cycle=0;frame_begin=0;end
  else begin frame_begin=cycle%19==0;cycle=cycle+1;end
 end
 always @(posedge clk)begin
  if(!reset_n)begin ready_samples=0;seen=0;end
  else begin
   expected=seen || (ready_samples>=2 && frame_begin);
   if(presenting!==expected)$fatal(1,"startup mismatch phase=%0d cycle=%0d ready_samples=%0d frame=%b got=%b expected=%b",phase,cycle,ready_samples,frame_begin,presenting,expected);
   if(!seen && presenting)starts=starts+1;
   seen=expected;
   if(ready)ready_samples=ready_samples+1;else ready_samples=0;
   checks=checks+1;
  end
 end
 initial begin
  for(phase=0;phase<19;phase=phase+1)begin
   reset_n=0;ready=0;repeat(3)@(negedge clk);#1;reset_n=1;
   repeat(57+phase)@(negedge clk);#2.3;ready=1;
   repeat(40)@(negedge clk);
   if(!presenting)$fatal(1,"ready image missed its next eligible frame");
   #1;ready=0;repeat(57)@(negedge clk);
   if(!presenting)$fatal(1,"later background loading restarted/hid the presentation");
  end
  if(starts!=19)$fatal(1,"missing startup phase coverage");
  reset_n=0;#1;if(presenting!==0)$fatal(1,"startup reset failed");
  $display("PASS video start: %0d checks, 19 async readiness phases; wait for synchronized complete image, frame-boundary release, sticky running across later loading, reset",checks);$finish;
 end
 initial begin #100000;$fatal(1,"startup controller timeout");end
endmodule

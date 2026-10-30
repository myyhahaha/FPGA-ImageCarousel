`timescale 1ns/1ps
module tb_fade_ctrl;
 reg clk=0,rst=1,blank=0,request=0;reg[20:0]target=0;always #10 clk=~clk;
 wire ack,active,blend;wire[20:0]oldb,newb;wire[5:0]alpha;
 ab_fade_ctrl dut(clk,rst,blank,request,target,ack,active,oldb,newb,blend,alpha);
 reg[20:0]old_before,new_before;reg[5:0]alpha_before;reg ack_before,blend_before;
 integer n;
 task frame;
 begin
   @(negedge clk);blank=1;@(negedge clk);blank=0;repeat(4) @(negedge clk);
 end
 endtask
 task expect_hold;
 begin
   old_before=oldb;new_before=newb;alpha_before=alpha;ack_before=ack;blend_before=blend;
   repeat(5) @(negedge clk);
   if({oldb,newb,alpha,ack,blend}!={old_before,new_before,alpha_before,ack_before,blend_before})
     $fatal(1,"fade state changed outside vertical blank");
 end
 endtask
 initial begin
   #53;rst=0;target=0;request=1;expect_hold;frame;
   if(!active || !ack || blend || oldb!=0) $fatal(1,"startup should be direct");
   target=240000;request=0;expect_hold;
   for(n=1;n<=31;n=n+1) begin
     frame;
     if(!blend || alpha!=n || oldb!=0 || newb!=240000 || !ack) $fatal(1,"fade weight/slot/ack %d",n);
     target=480000;expect_hold; // input bus changes cannot change the latched target
   end
   frame;
   if(blend || alpha!=0 || oldb!=240000 || ack) $fatal(1,"final new frame not committed");
   request=1;target=0;
   for(n=1;n<=31;n=n+1) frame;
   frame;if(blend || oldb!=0 || !ack) $fatal(1,"reverse fade failed");
   $display("PASS fade control: startup, 32-frame fade, reverse fade, frame-constant alpha, latched target, delayed cache release");$finish;
 end
endmodule

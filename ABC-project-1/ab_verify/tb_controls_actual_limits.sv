`timescale 1ns/1ps
module tb_controls_actual_limits;
 reg clk=0,rst=1,kn=1,kp=1,done=1,visible=1;
 reg [3:0] switches=4'b1111;
 reg [3:0] image=1;
 wire next_pressed,prev_pressed,auto_pressed;
 always #10 clk=~clk;
 img_switch_ctrl dut(.clk(clk),.rst(rst),.key_next_n(kn),.key_prev_n(kp),
   .sw1_n(switches[0]),.sw2_n(switches[1]),.sw3_n(switches[2]),.sw4_n(switches[3]),
   .display_valid(visible),.switch_done(done),.disp_img(image),
   .next_pressed(next_pressed),.prev_pressed(prev_pressed),.auto_pressed(auto_pressed));
 task check_limit;
   input [3:0] pins;
   input [28:0] expected;
   reg [28:0] preload;
   begin
     @(negedge clk);switches=pins;
     repeat(8) @(negedge clk);
     if(dut.limit!==expected) $fatal(1,"switch %b selects %0d, expected %0d",pins,dut.limit,expected);
     preload=expected-2;
     force dut.count=preload;
     @(negedge clk);release dut.count;
     @(posedge clk);#1;if(auto_pressed)$fatal(1,"timer expired early");
     @(posedge clk);#1;if(!auto_pressed)$fatal(1,"timer missed exact default boundary");
     @(posedge clk);#1;if(auto_pressed)$fatal(1,"timer pulse wider than one cycle");
     $display("PASS default timer switch=%b period=%0d clocks @50MHz",pins,expected);
   end
 endtask
 initial begin
   repeat(3) @(negedge clk);rst=0;
   check_limit(4'b1110,29'd50000000);
   check_limit(4'b1101,29'd150000000);
   check_limit(4'b1011,29'd250000000);
   check_limit(4'b0111,29'd400000000);
   check_limit(4'b0000,29'd50000000);
   check_limit(4'b0101,29'd150000000);
   check_limit(4'b0011,29'd250000000);
   @(negedge clk);switches=4'b1111;
   repeat(12) @(negedge clk);
   if(dut.limit!=0 || dut.count!=0 || auto_pressed)$fatal(1,"manual mode still times");
   switches=4'b1110;repeat(10) @(negedge clk);
   done=0;
   force dut.count=29'd49999998;@(negedge clk);release dut.count;
   repeat(6) @(negedge clk);
   if(dut.count!=0 || auto_pressed)$fatal(1,"fade consumed stable hold time");
   done=1;image=2;@(posedge clk);#1;if(dut.count!=0 || auto_pressed)$fatal(1,"new image did not restart full hold interval");
   @(posedge clk);#1;if(dut.count!=1)$fatal(1,"hold timer did not restart after commit");
   @(negedge clk);visible=0;repeat(3)@(negedge clk);
   if(dut.count!=0 || auto_pressed)$fatal(1,"timer ran during preload");
   $display("PASS actual default limits: SW1/2/3/4=1/3/5/8s, exact boundaries, priority, manual mode, all-preload wait; fade excluded from interval, full hold starts after commit");
   $finish;
 end
 initial begin #100000;$fatal(1,"timeout");end
endmodule

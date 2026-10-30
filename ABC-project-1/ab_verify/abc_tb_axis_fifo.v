`timescale 1ns/1ps
module abc_tb_axis_fifo;
 reg clk=0,rst=1,iv=0,ready=0;reg[25:0]din=0;wire ov,overflow;wire[25:0]dout;
 always #5 clk=~clk;
 abc_video_axis_fifo dut(clk,rst,iv,din,ov,dout,ready,overflow);
 integer produced=0,consumed=0,cycle=0;reg[25:0]queue[0:99999];integer used=0;
 always @(posedge clk)if(!rst)begin
  if(ov!== (used!=0))$fatal(1,"queue valid");
  if(ov && ready)begin if(dout!==queue[consumed])$fatal(1,"queue data %0d got%h exp%h",consumed,dout,queue[consumed]);consumed=consumed+1;used=used-1;end
  if(iv && (used<1024))begin queue[produced]=din;produced=produced+1;used=used+1;end
 end
 initial begin
  repeat(3)@(negedge clk);rst=0;
  for(cycle=0;cycle<60000;cycle=cycle+1)begin
   @(negedge clk);ready=(cycle>1100 && cycle%19!=0 && cycle%23<18);
   iv=(used<1024 && cycle%17<13);din=(produced*7919)^26'h3aa55a;
  end
  @(negedge clk);iv=0;ready=1;wait(used==0);@(negedge clk);
  if(overflow || consumed<40000)$fatal(1,"queue coverage");
  // Explicit overflow reporting when a non-backpressureable producer overruns.
  ready=0;iv=1;repeat(1025)@(negedge clk);iv=0;@(negedge clk);
  if(!overflow)$fatal(1,"missing overflow flag");
  $display("PASS AXIS queue: %0d ordered 26-bit pixels under ready stalls, wrap/full/empty, single-item bypass, overflow reporting",consumed);$finish;
 end
endmodule

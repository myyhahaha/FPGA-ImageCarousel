`timescale 1ns/1ps
module tb_fifo;
 reg wc=0,rc=0,rst=1;
 always #3.333 wc=~wc;
 always #12.5 rc=~rc;
 wire full,empty;
 wire [23:0] dout;
 wire [10:0] level;
 integer writes=0,reads=0,rtick=0,full_cycles=0;
 wire wen=!rst && writes<5000 && !full;
 wire ren=!rst && !empty && rtick%7<4;
 wire [23:0] din=writes ^ 24'h5A1234;
 afifo_24x1024 dut(wc,rst,wen,din,full,rc,rst,ren,dout,empty,level);
 always @(posedge wc) if(!rst) begin
   if(wen) writes<=writes+1;
   if(full) full_cycles<=full_cycles+1;
   if(level>1024) $fatal(1,"FIFO water level out of range");
 end
 always @(posedge rc) if(!rst) begin
   rtick<=rtick+1;
   if(ren) begin
     if(dout!==(reads ^ 24'h5A1234)) $fatal(1,"FWFT mismatch %0d got=%h",reads,dout);
     reads<=reads+1;
   end
 end
 initial begin
   #100;rst=0;wait(reads==5000);repeat(8) @(posedge rc);
   if(!empty || full_cycles==0) $fatal(1,"FIFO full/empty not exercised");
   $display("PASS fifo: asynchronous FWFT, 5000 words, repeated pointer wrap, full backpressure, exact order");$finish;
 end
 initial begin #2000000;$fatal(1,"FIFO timeout");end
endmodule

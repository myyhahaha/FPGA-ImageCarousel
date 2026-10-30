`timescale 1ns/1ps
module tb_blend_word;
 reg clk=0,rst=1,en=0;always #10 clk=~clk;
 reg [23:0] a=0,b=0;reg[5:0]alpha=0;
 wire valid;wire[23:0]d;
 ab_blend_word dut(clk,rst,en,a,b,alpha,valid,d);
 reg [23:0] expected[0:9999];integer put=0,get=0,x,y,w,k;
 function [23:0] reference;
 input [23:0] av,bv;input integer weight;
 integer c,total;
 begin
   for(c=0;c<6;c=c+1) begin
     total=av[c*4+:4]*(32-weight)+bv[c*4+:4]*weight;
     reference[c*4+:4]=(total+16)/32;
   end
 end
 endfunction
 always @(posedge clk) begin
   if(!rst && en) begin expected[put]=reference(a,b,alpha);put=put+1;end
   if(!rst && valid) begin
     if(d!==expected[get]) $fatal(1,"blend mismatch %0d: %h != %h",get,d,expected[get]);
     get=get+1;
   end
 end
 initial begin
   #53;rst=0;
   for(w=0;w<=32;w=w+1) for(x=0;x<16;x=x+1) for(y=0;y<16;y=y+1) begin
     @(negedge clk);en=1;alpha=w;
     // Offset the channels so the test also detects packing/lane swaps.
     for(k=0;k<6;k=k+1) begin a[k*4+:4]=(x+k*3)%16;b[k*4+:4]=(y+k*5)%16;end
   end
   @(negedge clk);en=0;repeat(5) @(negedge clk);
   if(get!=8448 || put!=8448) $fatal(1,"blend pipeline lost output %d/%d",get,put);
   $display("PASS blend: all 33 weights x 16 x 16 channel values, 8448 packed words, six lanes, rounding/endpoints/throughput");$finish;
 end
endmodule

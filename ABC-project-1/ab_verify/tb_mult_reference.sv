`timescale 1ns/1ps
module glbl;wire gsrn=1'b1,done_gwe=1'b1;endmodule
module tb_mult_reference;
 reg clk_reg=0,reset_reg=0;always #5 clk_reg=~clk_reg;
 reg[17:0]av=0,bv=0;
 wire clk=clk_reg,reset_n=reset_reg;wire[17:0]a=av,b=bv;
 wire[35:0]ours[0:7],vendor[0:7];
 genvar n;
 generate for(n=0;n<8;n=n+1)begin:g
  EG_PHY_MULT18 #(.INPUTREGB((n>=4)?"ENABLE":"DISABLE"),
   .SIGNEDAMUX((n%2)?"1":"0"),.SIGNEDBMUX(((n/2)%2)?"1":"0"))
   fast(.a(a),.b(b),.clk(clk),.rstbn(reset_n),.p(ours[n]));
  EG_PHY_MULT18_VENDOR #(.INPUTREGA("DISABLE"),.INPUTREGB((n>=4)?"ENABLE":"DISABLE"),
   .OUTPUTREG("DISABLE"),.MODE("MULT9X9C"),.CEBMUX("1"),
   .SIGNEDAMUX((n%2)?"1":"0"),.SIGNEDBMUX(((n/2)%2)?"1":"0"))
   reference(.a(a),.b(b),.clk(clk),.rstbn(reset_n),.p(vendor[n]));
 end endgenerate
 integer i,j,checks=0;
 task compare;begin
  for(j=0;j<8;j=j+1)begin
   if(ours[j]!==vendor[j])$fatal(1,"MULT model mismatch cfg=%0d a=%h b=%h ours=%h vendor=%h",j,a,b,ours[j],vendor[j]);
   checks=checks+1;
  end
 end endtask
 initial begin
  #22;reset_reg=1;
  for(i=0;i<10000;i=i+1)begin
   @(negedge clk_reg);av=$random;bv=$random;#2;compare;
   @(posedge clk_reg);#2;compare;
  end
  @(negedge clk_reg);reset_reg=0;#2;compare;
  $display("PASS multiplier reference: %0d comparisons against installed Anlogic library; all signed/unsigned lane combinations, combinational/registered B, async reset",checks);
  $finish;
 end
endmodule

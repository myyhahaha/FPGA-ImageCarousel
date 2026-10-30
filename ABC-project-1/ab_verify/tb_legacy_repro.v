`timescale 1ns/1ps
// Regression evidence: unmodified old TD-mapped logic versus the corrected
// encoder. Both receive exactly the same display-channel values (low nibble 0).
module tb_legacy_repro;
 reg clk=0,de=0,rst=0;reg[7:0]d=0;always #12.5 clk=~clk;
 wire[9:0]old_q,new_q;wire c0=0,c1=0;
 TMDSEncoder_legacy old_encoder(.CLK_I(clk),.RST_I(rst),.DE_I(de),.C0_I(c0),.C1_I(c1),.D_I(d),.D_O(old_q));
 TMDSEncoder new_encoder(.CLK_I(clk),.RST_I(rst),.DE_I(de),.C0_I(c0),.C1_I(c1),.D_I(d),.D_O(new_q));
 reg[2:0]de_history=0;
 integer i,j,n=0,errors=0,old_balance=0,new_balance=0,max_old=0,max_new=0,no,nn;
 always @(posedge clk)begin
  de_history={de_history[1:0],de};
  #1;
  if(n>10 && old_q!==new_q)errors=errors+1;
  if(de_history[2])begin
   no=0;nn=0;for(j=0;j<10;j=j+1)begin no=no+old_q[j];nn=nn+new_q[j];end
   old_balance=old_balance+2*no-10;new_balance=new_balance+2*nn-10;
   if(old_balance>max_old)max_old=old_balance;if(-old_balance>max_old)max_old=-old_balance;
   if(new_balance>max_new)max_new=new_balance;if(-new_balance>max_new)max_new=-new_balance;
  end else begin old_balance=0;new_balance=0;end
  n=n+1;
 end
 initial begin
  #100;rst=1;
  for(i=0;i<20000;i=i+1)begin
   @(negedge clk);de=i%1056<800;
   if(i<4000)d=0;else if(i<8000)d=8'hf0;else d=((i*73+(i/256)*17)%16)*16;
  end
  if(errors==0 || max_old<=8 || max_new>8)$fatal(1,"legacy regression did not reproduce correctly");
  $display("PASS legacy reproduction: same RGB444 input, old nonstandard code words=%0d; max accumulated disparity old=%0d corrected=%0d",errors,max_old,max_new);$finish;
 end
endmodule

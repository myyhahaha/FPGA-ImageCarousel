`timescale 1ns/1ps
// Independent DVI 1.0 figure 3-5 encoder, not a copy of the implementation.
module tb_tmds_standard;
 reg clk=0,de=0,rst=0,c0=0,c1=0;reg [7:0]d=0;
 always #12.5 clk=~clk;
 wire[9:0]q;TMDSEncoder dut(.CLK_I(clk),.RST_I(rst),.DE_I(de),.C0_I(c0),.C1_I(c1),.D_I(d),.D_O(q));
 integer i,j,n=0,ones,balance,disparity=0,errors=0,actual_balance=0,max_balance=0;
 integer first_byte,second_byte,rep,warmup=0;reg[31:0]random_bits=32'h13579bdf;
 reg[8:0]m;reg[9:0]e,h[0:4];reg hd[0:4];
 always @(posedge clk)begin
   ones=0;for(j=0;j<8;j=j+1)ones=ones+d[j];
   m[8]=!((ones>4)||(ones==4 && !d[0]));m[0]=d[0];
   for(j=1;j<8;j=j+1)m[j]=m[j-1]^d[j]^!m[8];
   ones=0;for(j=0;j<8;j=j+1)ones=ones+m[j];balance=2*ones-8;
   if(!de)begin
     disparity=0;case({c1,c0})0:e=10'b1101010100;1:e=10'b0010101011;2:e=10'b0101010100;3:e=10'b1010101011;endcase
   end else if(disparity==0 || balance==0)begin
     e={~m[8],m[8],m[8]?m[7:0]:~m[7:0]};
     disparity=disparity+(m[8]?balance:-balance);
   end else if((disparity>0 && balance>0)||(disparity<0 && balance<0))begin
     e={1'b1,m[8],~m[7:0]};disparity=disparity+2*m[8]-balance;
   end else begin
     e={1'b0,m[8],m[7:0]};disparity=disparity-2*!m[8]+balance;
   end
   for(j=4;j>0;j=j-1)begin h[j]=h[j-1];hd[j]=hd[j-1];end h[0]=e;hd[0]=de;
   if(!rst)begin disparity=0;warmup=0;actual_balance=0;end else warmup=warmup+1;
   #1;if(warmup>3 && q!==h[2])begin if(errors<20)$display("MISMATCH n=%0d input=%h actual=%h expected=%h",n,d,q,h[2]);errors=errors+1;end
   if(warmup>3 && hd[2])begin ones=0;for(j=0;j<10;j=j+1)ones=ones+q[j];actual_balance=actual_balance+2*ones-10;if(actual_balance>max_balance)max_balance=actual_balance;if(-actual_balance>max_balance)max_balance=-actual_balance;end else actual_balance=0;
   if(actual_balance>8 || actual_balance< -8)$fatal(1,"TMDS disparity bound exceeded: %0d",actual_balance);
   n=n+1;
 end
 task send;input[7:0]v;input enabled;input[1:0]control;
 begin @(negedge clk);d=v;de=enabled;{c1,c0}=control;end endtask
 initial begin
  #100;rst=1;repeat(8)send(0,0,0);
  for(first_byte=0;first_byte<256;first_byte=first_byte+1)begin
   for(rep=0;rep<128;rep=rep+1)send(first_byte,1,0);
   for(rep=0;rep<8;rep=rep+1)send(0,0,rep%4);
  end
  for(first_byte=0;first_byte<256;first_byte=first_byte+1)
   for(second_byte=0;second_byte<256;second_byte=second_byte+1)begin send(first_byte,1,0);send(second_byte,1,0);end
  for(i=0;i<32768;i=i+1)begin
   random_bits={random_bits[30:0],random_bits[31]^random_bits[21]^random_bits[1]^random_bits[0]};
   send(random_bits[7:0],i%1056<800,i%4);
   if(i%8192==4096)begin send(0,0,0);rst=0;repeat(4)@(negedge clk);rst=1;end
  end
  repeat(8)send(0,0,0);
  if(errors!=0)$fatal(1,"standard TMDS mismatch count=%0d",errors);
  $display("PASS standard TMDS: %0d sampled cycles; all 256 bytes, all 65536 ordered transitions, long constant runs, random data, four controls, reset recovery; max running disparity=%0d",n,max_balance);$finish;
 end
endmodule

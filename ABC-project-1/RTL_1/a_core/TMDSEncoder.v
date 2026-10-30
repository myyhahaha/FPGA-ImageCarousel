`timescale 1ns/1ps
// DVI 1.0 figure 3-5. Keep the existing three pixel-clock pipeline stages.
// RST_I follows this project's transmitter interface: low asserts reset.
module TMDSEncoder(
 input CLK_I,RST_I,DE_I,C0_I,C1_I,
 input [7:0] D_I,output reg [9:0] D_O
);
 reg [7:0] data_d;
 reg de_d,c0_d,c1_d,de_q,c0_q,c1_q;
 reg [8:0] qm,qm_next;
 reg signed [5:0] balance_q,disparity;
 reg [3:0] data_ones,qm_ones;
 reg signed [5:0] balance_next;
 integer k;
 always @* begin
   data_ones=0;
   for(k=0;k<8;k=k+1) data_ones=data_ones+data_d[k];
   qm_next[8]=!((data_ones>4) || (data_ones==4 && !data_d[0]));
   qm_next[0]=data_d[0];
   for(k=1;k<8;k=k+1) qm_next[k]=qm_next[k-1]^data_d[k]^!qm_next[8];
   qm_ones=0;
   for(k=0;k<8;k=k+1) qm_ones=qm_ones+qm_next[k];
   balance_next=$signed({1'b0,qm_ones,1'b0})-6'sd8;
 end
 always @(posedge CLK_I or negedge RST_I) begin
   if(!RST_I) begin
     data_d<=0;de_d<=0;c0_d<=0;c1_d<=0;
     qm<=0;balance_q<=0;de_q<=0;c0_q<=0;c1_q<=0;
     disparity<=0;D_O<=10'b1101010100;
   end else begin
     data_d<=D_I;de_d<=DE_I;c0_d<=C0_I;c1_d<=C1_I;
     qm<=qm_next;balance_q<=balance_next;
     de_q<=de_d;c0_q<=c0_d;c1_q<=c1_d;
     if(!de_q) begin
       disparity<=0;
       case({c1_q,c0_q})
         2'b00:D_O<=10'b1101010100;
         2'b01:D_O<=10'b0010101011;
         2'b10:D_O<=10'b0101010100;
         2'b11:D_O<=10'b1010101011;
       endcase
     end else if(disparity==0 || balance_q==0) begin
       D_O<={~qm[8],qm[8],qm[8]?qm[7:0]:~qm[7:0]};
       disparity<=qm[8] ? disparity+balance_q:disparity-balance_q;
     end else if((disparity>0 && balance_q>0) || (disparity<0 && balance_q<0)) begin
       D_O<={1'b1,qm[8],~qm[7:0]};
       disparity<=disparity+(qm[8]?6'sd2:6'sd0)-balance_q;
     end else begin
       D_O<={1'b0,qm[8],qm[7:0]};
       disparity<=disparity-(qm[8]?6'sd0:6'sd2)+balance_q;
     end
   end
 end
endmodule

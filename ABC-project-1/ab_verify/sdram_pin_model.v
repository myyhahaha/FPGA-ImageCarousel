`timescale 1ns/1ps
// Pin-level single-data-rate memory model. The controller is the actual TD
// exported gate netlist, not an App_* acceptance model. EM638325 geometry.
module EG_PHY_SDRAM_2M_32 #(
 parameter real T_AC=2.0
)(input clk,ras_n,cas_n,we_n,input [10:0] addr,input [1:0] ba,
 inout [31:0] dq,input cs_n,dm0,dm1,dm2,dm3,cke);
 reg [31:0] mem[0:2097151];
 reg [10:0] row[0:3];
 reg [3:0] opened=0;
 reg [31:0] out_data;
 reg out_en=0;
 reg [7:0] vpipe=0;
 reg [31:0] dpipe[0:7];
 integer cas_latency=3,burst_length=1,tick=0,i,idx;
 integer reads=0,writes=0,refreshes=0,unknown_writes=0;
 integer read_left=0,write_left=0,burst_idx=0,burst_col=0,start_col=0;
 reg single_write=0;
 wire [3:0] dm={dm3,dm2,dm1,dm0};
 assign dq=out_en ? out_data : 32'bz;
 always @(posedge clk) if(cke) begin
   tick=tick+1;
   out_en<=#(T_AC) vpipe[0];
   out_data<=#(T_AC) dpipe[0];
   for(i=0;i<7;i=i+1) begin vpipe[i]<=vpipe[i+1];dpipe[i]<=dpipe[i+1];end
   vpipe[7]<=0;
   if(read_left>0) begin
     dpipe[cas_latency-1]<=mem[burst_idx];vpipe[cas_latency-1]<=1;
     read_left=read_left-1;burst_col=(burst_col+1)%burst_length;
     burst_idx=(burst_idx & ~255) | ((start_col & ~(burst_length-1)) | burst_col);
   end
   if(write_left>0) begin
     if((^dq)===1'bx) unknown_writes=unknown_writes+1;
     for(i=0;i<4;i=i+1) if(!dm[i]) mem[burst_idx][i*8+:8]=dq[i*8+:8];
     write_left=write_left-1;burst_col=(burst_col+1)%burst_length;
     burst_idx=(burst_idx & ~255) | ((start_col & ~(burst_length-1)) | burst_col);
     writes=writes+1;
   end
   if(!cs_n) case({ras_n,cas_n,we_n})
     3'b011:begin row[ba]=addr;opened[ba]=1;end
     3'b010:begin if(addr[10]) opened=0;else opened[ba]=0;read_left=0;write_left=0;end
     3'b001:refreshes=refreshes+1;
     3'b000:begin
       cas_latency=addr[6:4];burst_length=1<<addr[2:0];single_write=addr[9];
       $display("SDRAM mode: CAS=%0d BL=%0d single_write=%b mode=%h at %t",cas_latency,burst_length,single_write,addr,$time);
     end
     3'b101:begin
       if(!opened[ba]) $fatal(1,"READ to closed bank at %t",$time);
       idx={row[ba],ba,addr[7:0]};
       dpipe[cas_latency-1]<=mem[idx];vpipe[cas_latency-1]<=1;
       read_left=burst_length-1;write_left=0;start_col=addr[7:0];burst_col=(start_col+1)%burst_length;
       burst_idx=(idx & ~255) | ((start_col & ~(burst_length-1)) | burst_col);
       reads=reads+1;
     end
     3'b100:begin
       if(!opened[ba]) $fatal(1,"WRITE to closed bank at %t",$time);
       idx={row[ba],ba,addr[7:0]};
       if((^dq)===1'bx) unknown_writes=unknown_writes+1;
       for(i=0;i<4;i=i+1) if(!dm[i]) mem[idx][i*8+:8]=dq[i*8+:8];
       writes=writes+1;
       write_left=single_write ? 0:burst_length-1;read_left=0;start_col=addr[7:0];burst_col=(start_col+1)%burst_length;
       burst_idx=(idx & ~255) | ((start_col & ~(burst_length-1)) | burst_col);
     end
   endcase
 end
endmodule

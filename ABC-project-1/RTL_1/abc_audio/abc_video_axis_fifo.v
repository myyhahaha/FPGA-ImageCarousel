// Buffer the fixed-rate scanout stream while the HDMI core deasserts ready.
// One clock domain; synchronous BRAM look-ahead gives stable FWFT output.
module abc_video_axis_fifo(
 input clk,rst,input in_valid,input[25:0]in_data,
 output out_valid,output reg[25:0]out_data,input out_ready,output reg overflow
);
 reg[25:0]mem[0:1023];reg[9:0]wp,rp;reg[10:0]count;
 wire pop=count!=0 && out_ready;
 wire push=in_valid && (count<1024 || pop);
 wire[9:0]next_rp=rp+pop;
 assign out_valid=count!=0;
 always @(posedge clk)begin
  if(push)mem[wp]<=in_data;
  // A simultaneous first push/read must bypass the old RAM value.
  if(push && ((count==0) || (count==1 && pop)))out_data<=in_data;
  else out_data<=mem[next_rp];
 end
 always @(posedge clk or posedge rst)begin
  if(rst)begin wp<=0;rp<=0;count<=0;overflow<=0;end
  else begin
   if(push)wp<=wp+1'b1;
   if(pop)rp<=rp+1'b1;
   if(push && !pop)count<=count+1'b1;else if(pop && !push)count<=count-1'b1;
   if(in_valid && !push)overflow<=1;
  end
 end
endmodule

`timescale 1ns/1ps
// RGB888 mailbox -> centred RGB444 framebuffer. The SDRAM IP is BL4:
// every aligned four-word transaction is indivisible, followed by a drain.
// Buffer four banks so every output beat is registered, without a 512:1 mux.
module ab_bmp_sdram_writer(
 input clk,rst,enable,busy,refresh,restart,input [20:0] wr_base,
 input pix_avail,input [23:0] pix_data,output wire pix_take,input src_done,
 output reg app_wr_en,output reg [20:0] app_wr_addr,
 output reg [31:0] app_wr_din,output [3:0] app_wr_dm,
 output reg [19:0] accepted,output reg fill_done,output reg [2:0] dbg_state
);
 localparam S_CLEAR=0,S_WAIT=1,S_PAIR=2,S_FETCH=3,S_READY=4,S_BURST=5,S_DRAIN=6,S_DONE=7;
 localparam [20:0] TOTAL_W=240000,ADDR_0=215640,ROW_JUMP=719;
 localparam [19:0] BMP_W=153600;
 reg [2:0] state;
 reg [20:0] base_q,clear_addr,img_addr;
 reg [8:0] col_cnt;
 reg [11:0] pix1;
 reg [9:0] wcnt,rcnt;
 reg clearing;
 reg [1:0] beat;
 reg [4:0] drain;
 reg sd1,sd2;
 reg [23:0] buf0[0:127],buf1[0:127],buf2[0:127],buf3[0:127];
 reg [20:0] abuf[0:127];
 reg [23:0] q0,q1,q2,q3;
 reg [20:0] addr_q;
 // Keep the asynchronous clear separate from the synchronous base reload.
 always @(posedge clk or posedge rst) begin
   if(rst) base_q<=0;
   else if(restart) base_q<=wr_base;
 end
 always @(posedge clk) begin
   q0<=buf0[rcnt[8:2]];q1<=buf1[rcnt[8:2]];
   q2<=buf2[rcnt[8:2]];q3<=buf3[rcnt[8:2]];addr_q<=abuf[rcnt[8:2]];
   if(pix_take && state==S_PAIR) begin
     case(wcnt[1:0])
       0:begin buf0[wcnt[8:2]]<={pix_data[23:20],pix_data[15:12],pix_data[7:4],pix1};abuf[wcnt[8:2]]<=img_addr;end
       1:buf1[wcnt[8:2]]<={pix_data[23:20],pix_data[15:12],pix_data[7:4],pix1};
       2:buf2[wcnt[8:2]]<={pix_data[23:20],pix_data[15:12],pix_data[7:4],pix1};
       3:buf3[wcnt[8:2]]<={pix_data[23:20],pix_data[15:12],pix_data[7:4],pix1};
     endcase
   end
 end
 assign app_wr_dm=0;
 assign pix_take=!rst && !restart && (state==S_WAIT || state==S_PAIR) && pix_avail;
 always @(posedge clk or posedge rst) begin
   if(rst || restart) begin sd1<=0;sd2<=0;end
   else begin sd1<=src_done;sd2<=sd1;end
 end
 always @(posedge clk or posedge rst) begin
   if(rst || restart) begin
     state<=S_CLEAR;clear_addr<=0;img_addr<=ADDR_0;col_cnt<=0;
     pix1<=0;wcnt<=0;rcnt<=0;clearing<=1;beat<=0;drain<=0;
     accepted<=0;fill_done<=0;dbg_state<=0;
     app_wr_en<=0;app_wr_addr<=0;app_wr_din<=0;
   end else begin
     dbg_state<=state;
     app_wr_en<=0;
     case(state)
       S_CLEAR: if(enable && !busy && !refresh) begin
         app_wr_en<=1;app_wr_addr<=base_q+clear_addr;app_wr_din<=0;
         beat<=1;state<=S_BURST;
       end
       S_WAIT: if(pix_avail) begin
         pix1<={pix_data[23:20],pix_data[15:12],pix_data[7:4]};state<=S_PAIR;
       end else if(sd2) begin
         if(wcnt!=0) begin rcnt<=0;state<=S_FETCH;end
         else state<=S_DONE;
       end
       S_PAIR: if(pix_avail) begin
         if(col_cnt==319) begin col_cnt<=0;img_addr<=img_addr-ROW_JUMP;end
         else begin col_cnt<=col_cnt+1'b1;img_addr<=img_addr+1'b1;end
         wcnt<=wcnt+1'b1;
         if(wcnt==511) begin rcnt<=0;state<=S_FETCH;end
         else state<=S_WAIT;
       end
       S_FETCH:state<=S_READY; // registered memory outputs settle
       S_READY:if(enable && !busy && !refresh) begin
         app_wr_en<=1;app_wr_addr<=base_q+addr_q;app_wr_din<={8'd0,q0};
         beat<=1;state<=S_BURST;
       end
       S_BURST:begin
         // Busy may rise during these beats. Do not truncate or replay them.
         app_wr_en<=1;app_wr_addr<=app_wr_addr+1'b1;
         if(clearing) app_wr_din<=0;
         else case(beat) 1:app_wr_din<={8'd0,q1};2:app_wr_din<={8'd0,q2};default:app_wr_din<={8'd0,q3};endcase
         beat<=beat+1'b1;
         if(beat==3) begin drain<=16;state<=S_DRAIN;end
       end
       S_DRAIN:begin
         if(drain!=0) drain<=drain-1'b1;
         else if(!busy && !refresh) begin
           if(clearing) begin
             if(clear_addr==TOTAL_W-4) begin clearing<=0;state<=S_WAIT;end
             else begin clear_addr<=clear_addr+4;state<=S_CLEAR;end
           end else begin
             accepted<=accepted+4;
             if(rcnt+4==wcnt) begin rcnt<=0;wcnt<=0;state<=S_WAIT;end
             else begin rcnt<=rcnt+4;state<=S_FETCH;end
           end
         end
       end
       S_DONE:fill_done<=(accepted==BMP_W);
       default:state<=S_DONE;
     endcase
   end
 end
endmodule

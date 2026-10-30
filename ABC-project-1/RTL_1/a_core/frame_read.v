`timescale 1ns/1ps
// Continuous BL4 packets aligned to complete scan lines. During a crossfade,
// read the same complete line from both slots, then blend its return stream.
// The old packet uses synchronous RAM; multiplication and sum are pipelined.
module frame_read #(
 parameter TOTAL=800*600/2,parameter FIFO_DEPTH=1024,parameter BURST=400
)(
 input Clk,Rst,Sdr_init_done,Sdr_init_ref_vld,Start,Frame_sync,
 input [20:0] rd_base,input Fifo_full,input [10:0] Fifo_level,input Sdr_busy,
 input [20:0] rd_base_next,input Blend_enable,input [5:0] Blend_alpha,
 output reg App_rd_en,output reg [20:0] App_rd_addr,
 input Sdr_rd_en,input [31:0] Sdr_rd_dout,
 output Fifo_wr_en,output [23:0] Fifo_wr_din,output Read_busy
);
 localparam HIWAT=FIFO_DEPTH/2,AW=$clog2(BURST),CW=$clog2(BURST+1);
 localparam P_DIRECT=0,P_OLD=1,P_NEW=2;
 reg running,blend_q,second_pending;
 reg [20:0] base_q,next_q,offset;
 reg [5:0] alpha_q;
 reg [4:0] drain;
 // A line is 400 packed words. Size counters from BURST instead of silently
 // truncating them to eight bits. FIFO headroom is 512 words at the watermark.
 reg [CW-1:0] offer_left,return_left;
 reg [1:0] phase;
 reg [AW-1:0] rx_index;
 reg [23:0] old_packet[0:BURST-1];
 reg [23:0] old_q,new_q,direct_q;
 reg pair_valid,direct_valid;
 wire mix_valid;
 wire [23:0] mix_data;
 assign Read_busy=App_rd_en || return_left!=0 || second_pending;
 assign Fifo_wr_en=direct_valid || mix_valid;
 assign Fifo_wr_din=mix_valid ? mix_data:direct_q;
 ab_blend_word u_blend(.clk(Clk),.rst(Rst || Frame_sync || !Sdr_init_done),
   .enable(pair_valid),.old_word(old_q),.new_word(new_q),.alpha(alpha_q),
   .valid(mix_valid),.word_out(mix_data));
 // This is a real synchronous memory read; paired new data waits alongside it.
 always @(posedge Clk) begin
   if(drain==0 && running && Sdr_rd_en && return_left!=0) begin
     if(phase==P_OLD) old_packet[rx_index]<=Sdr_rd_dout[23:0];
     if(phase==P_NEW) begin old_q<=old_packet[rx_index];new_q<=Sdr_rd_dout[23:0];end
   end
 end
 always @(posedge Clk) begin
   if(Rst || !Sdr_init_done) begin
     running<=0;blend_q<=0;second_pending<=0;base_q<=0;next_q<=0;offset<=0;
     alpha_q<=0;drain<=0;offer_left<=0;return_left<=0;phase<=P_DIRECT;rx_index<=0;
     App_rd_en<=0;App_rd_addr<=0;pair_valid<=0;direct_valid<=0;direct_q<=0;
   end else if(Frame_sync) begin
     running<=1;blend_q<=Blend_enable;second_pending<=0;
     base_q<=rd_base;next_q<=rd_base_next;alpha_q<=Blend_alpha;offset<=0;drain<=31;
     offer_left<=0;return_left<=0;phase<=P_DIRECT;rx_index<=0;
     App_rd_en<=0;App_rd_addr<=rd_base;pair_valid<=0;direct_valid<=0;
   end else begin
     pair_valid<=0;direct_valid<=0;
     if(drain!=0) begin drain<=drain-1'b1;App_rd_en<=0;end
     else begin
       if(running && Sdr_rd_en && return_left!=0) begin
         return_left<=return_left-1'b1;rx_index<=rx_index+1'b1;
         if(phase==P_NEW) pair_valid<=1;
         else if(phase==P_DIRECT) begin direct_valid<=1;direct_q<=Sdr_rd_dout[23:0];end
         if(return_left==1) begin
           if(phase==P_OLD) second_pending<=1;
           else begin
             second_pending<=0;offset<=offset+BURST;
             if(offset==TOTAL-BURST) running<=0;
           end
         end
       end
       if(App_rd_en) begin
         if(offer_left==1) begin App_rd_en<=0;offer_left<=0;end
         else begin App_rd_addr<=App_rd_addr+1'b1;offer_left<=offer_left-1'b1;end
       end else if(running && return_left==0 && !Sdr_init_ref_vld && !Sdr_busy &&
                   (second_pending || (!Fifo_full && Fifo_level<HIWAT))) begin
         App_rd_en<=1;offer_left<=BURST;return_left<=BURST;rx_index<=0;
         if(second_pending) begin App_rd_addr<=next_q+offset;phase<=P_NEW;end
         else begin App_rd_addr<=base_q+offset;phase<=blend_q ? P_OLD:P_DIRECT;end
       end
     end
   end
 end
endmodule

// Six RGB444 channels (two pixels) with a common frame weight 0..32.
// Rounded blend = ((32-alpha)*old + alpha*new + 16) >> 5.
module ab_blend_word(input clk,rst,enable,input [23:0] old_word,new_word,
 input [5:0] alpha,output reg valid,output reg [23:0] word_out);
 wire [5:0] old_weight=6'd32-alpha;
 reg [8:0] old_product[0:5],new_product[0:5];
 reg product_valid;
 integer k;
 always @(posedge clk) begin
   if(rst) begin product_valid<=0;valid<=0;word_out<=0;end
   else begin
     product_valid<=enable;valid<=product_valid;
     if(enable) for(k=0;k<6;k=k+1) begin
       old_product[k]<=old_word[k*4+:4]*old_weight;
       new_product[k]<=new_word[k*4+:4]*alpha;
     end
     if(product_valid) for(k=0;k<6;k=k+1)
       word_out[k*4+:4]<=(old_product[k]+new_product[k]+9'd16)>>5;
   end
 end
endmodule

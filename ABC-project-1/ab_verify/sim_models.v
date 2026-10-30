`timescale 1ns/1ps
// Simulation boundaries: PLLs, encrypted SDRAM IP, and TMDS serializer only.
// All cache, FAT32, BMP, mailbox, SDRAM writer, read FIFO and VGA RTL is real.
module clk_wize(input refclk,reset,output clk0_out,output reg clk1_out=0);
 assign clk0_out=refclk; // Serializer is a boundary stub; no 200 MHz logic here.
 always #12.5 clk1_out=~clk1_out;
endmodule
module clk_sdr(input refclk,reset,output extlock,output reg clk0_out=0,output clk1_out);
 reg locked=0;initial #100 locked=1;assign extlock=locked;assign clk1_out=~clk0_out;
 always #10 clk0_out=~clk0_out;
endmodule
module sdr_as_ram #(parameter self_refresh_open=1)(
 input Sdr_clk,Sdr_clk_sft,Rst,output reg Sdr_init_done=0,
 output Sdr_init_ref_vld,Sdr_busy,input App_ref_req,
 input App_wr_en,input [20:0] App_wr_addr,input [3:0] App_wr_dm,input [31:0] App_wr_din,
 input App_rd_en,input [20:0] App_rd_addr,output Sdr_rd_en,output [31:0] Sdr_rd_dout,
 output SDRAM_CLK,SDR_RAS,SDR_CAS,SDR_WE,output [1:0] SDR_BA,
 output [10:0] SDR_ADDR,output [3:0] SDR_DM,inout [31:0] SDR_DQ
);
 reg [31:0] mem[0:2097151];
 integer tick=0,i,ref_count=0;
 reg [14:0] op_pipe=0;
 reg [10:0] valid_pipe=0;
 reg [31:0] data_pipe[0:10];
 reg [6:0] wr_pipe=0;
 reg [31:0] wr_data[0:6];reg [20:0] wr_addr[0:6];
 reg old_wr=0,old_rd=0;integer nr=0,nw=0;
 assign Sdr_init_ref_vld=(ref_count!=0);
 assign Sdr_busy=|op_pipe[14:3];
 assign Sdr_rd_en=valid_pipe[10];assign Sdr_rd_dout=data_pipe[10];
 assign SDRAM_CLK=Sdr_clk_sft;
 assign {SDR_RAS,SDR_CAS,SDR_WE,SDR_BA,SDR_ADDR,SDR_DM}=0;
 assign SDR_DQ=32'bz;
 always @(posedge Sdr_clk) begin
   tick<=tick+1;Sdr_init_done<=tick>40;
   if(ref_count!=0) begin if(op_pipe==0 && !App_rd_en && !App_wr_en) ref_count<=ref_count-1;end
   else if(App_ref_req) ref_count<=20;
   op_pipe<={op_pipe[13:0],App_rd_en || App_wr_en};
   valid_pipe<={valid_pipe[9:0],App_rd_en && Sdr_init_done};
   wr_pipe<={wr_pipe[5:0],App_wr_en && Sdr_init_done};
   for(i=10;i>0;i=i-1) data_pipe[i]<=data_pipe[i-1];
   for(i=6;i>0;i=i-1) begin wr_data[i]<=wr_data[i-1];wr_addr[i]<=wr_addr[i-1];end
   if(App_rd_en && Sdr_init_done) begin
     if(App_rd_addr>=1920000) $fatal(1,"read out of cache range");
     if(wr_pipe!=0) $fatal(1,"read started with write pipeline pending");
     data_pipe[0]<=mem[App_rd_addr];nr=nr+1;
   end
   if(App_wr_en && Sdr_init_done) begin
     if(App_wr_addr>=1920000) $fatal(1,"write out of cache range");
     if(valid_pipe!=0) $fatal(1,"write started with read pipeline pending");
     wr_data[0]<=App_wr_din;wr_addr[0]<=App_wr_addr;nw=nw+1;
   end
   if(wr_pipe[6]) mem[wr_addr[6]]<=wr_data[6];
   if(old_rd && !App_rd_en) begin if(nr%4!=0) $fatal(1,"truncated read BL4 packet %d",nr);end
   if(old_wr && !App_wr_en) begin if(nw%4!=0) $fatal(1,"truncated write BL4 packet %d",nw);end
   old_wr<=App_wr_en;old_rd<=App_rd_en;
   if(App_rd_en && App_wr_en) $fatal(1,"simultaneous SDRAM requests");
 end
endmodule
module EG_PHY_SDRAM_2M_32(input clk,ras_n,cas_n,we_n,input [10:0] addr,
 input [1:0] ba,inout [31:0] dq,input cs_n,dm0,dm1,dm2,dm3,cke);
 assign dq=32'bz;
endmodule
module hdmi_tx #(parameter FAMILY="EG4")(
 input PXLCLK_I,PXLCLK_5X_I,RST_N,VGA_HS,VGA_VS,VGA_DE,input [23:0] VGA_RGB,
 output HDMI_CLK_P,HDMI_D2_P,HDMI_D1_P,HDMI_D0_P);
 assign HDMI_CLK_P=PXLCLK_I;assign {HDMI_D2_P,HDMI_D1_P,HDMI_D0_P}=0;
endmodule


// HDMI packet generation is tested separately against the exported TD netlist.
module abc_hdmi_audio_tx(input PXLCLK_I,PXLCLK_5X_I,RST_N,VGA_HS,VGA_VS,VGA_DE,input[23:0]VGA_RGB,
 input AUDIO_VALID,input[23:0]AUDIO_LEFT,AUDIO_RIGHT,output HDMI_DDC_SCL,inout HDMI_DDC_SDA,
 output HDMI_CLK_P,HDMI_D2_P,HDMI_D1_P,HDMI_D0_P);
 assign HDMI_CLK_P=PXLCLK_I;assign {HDMI_D2_P,HDMI_D1_P,HDMI_D0_P}=0;
 assign HDMI_DDC_SCL=1;assign HDMI_DDC_SDA=1'bz;
endmodule

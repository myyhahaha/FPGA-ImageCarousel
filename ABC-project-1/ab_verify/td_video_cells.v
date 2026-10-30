`timescale 1ns/1ps
// Functional models for the subset of published TD pad/macro parameters used
// by hdmi_map.v, including same-edge DDRX1 output capture. Delay taps,
// latches, analog channel behavior and hardware timing are not modelled.
// LUTs and adders use the unmodified vendor simulation library.
module AL_DFF_X #(parameter INIT=1'b0)(input clk,d,en,ar,as,sr,ss,output reg q=INIT);
 always @(posedge clk or posedge ar or posedge as)
   if(ar) q<=0;else if(as) q<=1;else if(sr) q<=0;else if(ss) q<=1;else if(en) q<=d;
endmodule
module EG_PHY_CONFIG;
 parameter DONE_PERSISTN="ENABLE",INIT_PERSISTN="ENABLE",JTAG_PERSISTN="DISABLE",PROGRAMN_PERSISTN="DISABLE";
endmodule
module EG_PHY_PAD(ipad,opad,bpad,rst,ce,isclk,ipclk,osclk,opclk,ts,do,di,diq);
 parameter GSR="ENABLE",DEDCLK="DISABLE",SRMODE="SYNC",TSMUX="1",
 INSCLKMUX="0",INPCLKMUX="CLK",INCEMUX="CE",INRSTMUX="0",IN_REGSET="RESET",IN_DFFMODE="NONE",IDDRMODE="OFF",IDDRPIPEMODE="NONE",INDELMUX="NODEL",INDEL=0,
 OUTSCLKMUX="0",OUTPCLKMUX="CLK",OUTCEMUX="CE",OUTRSTMUX="0",DO_REGSET="RESET",DO_DFFMODE="NONE",ODDRMODE="OFF",OUTDELMUX="NODEL",OUTDEL=0,
 TO_REGSET="RESET",TO_DFFMODE="NONE",MODE="IN",DRIVE="NONE",IOTYPE="LVCMOS25";
 input ipad,rst,ce,isclk,ipclk,osclk,opclk,ts;input [3:0] do;
 output opad,di;output [3:0]diq;inout bpad;tri1 ce;
 wire in_clk=INPCLKMUX=="INV" ? ~ipclk:ipclk;
 wire out_clk=OUTSCLKMUX=="INV" ? ~osclk:osclk;
 wire in_en=INCEMUX=="1" ? 1'b1:INCEMUX=="INV" ? ~ce:ce;
 wire out_en=OUTCEMUX=="1" ? 1'b1:OUTCEMUX=="INV" ? ~ce:ce;
 wire ir=INRSTMUX=="RST" ? rst:INRSTMUX=="INV" ? ~rst:1'b0;
 wire orst=OUTRSTMUX=="RST" ? rst:OUTRSTMUX=="INV" ? ~rst:1'b0;
 wire tristate=TSMUX=="1" ? 1'b1:TSMUX=="0" ? 1'b0:TSMUX=="INV" ? ~ts:ts;
 wire in_data=MODE=="BI" ? bpad:ipad;
 reg iq=(IN_REGSET=="SET"),oq=(DO_REGSET=="SET");
 generate if(SRMODE=="ASYNC") begin
   always @(posedge in_clk or posedge ir) if(ir) iq<=(IN_REGSET=="SET");else if(in_en) iq<=in_data;
   always @(posedge out_clk or posedge orst) if(orst) oq<=(DO_REGSET=="SET");else if(out_en) oq<=do[0];
 end else begin
   always @(posedge in_clk) if(ir) iq<=(IN_REGSET=="SET");else if(in_en) iq<=in_data;
   always @(posedge out_clk) if(orst) oq<=(DO_REGSET=="SET");else if(out_en) oq<=do[0];
 end endgenerate
 reg rise_data=0,fall_data=0,fall_hold=0;
 always @(posedge out_clk) begin rise_data<=do[0];fall_hold<=do[1];end
 always @(negedge out_clk) fall_data<=fall_hold;
 wire od=ODDRMODE=="DDRX1" ? (out_clk ? rise_data:fall_data):(DO_DFFMODE=="FF" ? oq:do[0]);
 assign di=in_data;
 assign diq={3'b0,IN_DFFMODE=="FF" ? iq:in_data};
 assign opad=tristate ? 1'bz:od;
 assign bpad=(MODE=="BI" && !tristate) ? od:1'bz;
 initial if(IDDRMODE!="OFF" || (ODDRMODE!="OFF" && ODDRMODE!="DDRX1") || TO_DFFMODE!="NONE" || (IN_DFFMODE!="FF" && IN_DFFMODE!="NONE") || (DO_DFFMODE!="FF" && DO_DFFMODE!="NONE")) begin $display("FAIL unmodelled TD pad mode");$finish;end
endmodule

module AL_MUX(input i0,i1,sel,output o);assign o=sel?i1:i0;endmodule


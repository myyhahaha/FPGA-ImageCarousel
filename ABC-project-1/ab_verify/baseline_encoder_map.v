// Verilog netlist created by Tang Dynasty v6.2.168116
// Wed Oct 28 19:17:53 2026

`timescale 1ns / 1ps
module TMDSEncoder_legacy
  (
  C0_I,
  C1_I,
  CLK_I,
  DE_I,
  D_I,
  RST_I,
  D_O
  );

  input C0_I;
  input C1_I;
  input CLK_I;
  input DE_I;
  input [7:0] D_I;
  input RST_I;
  output [9:0] D_O;

  wire [1:0] add0_syn_3;
  wire [1:0] add0_syn_6;
  wire [1:0] add10_syn_6;
  wire [4:0] cnt_t_1;
  wire [4:0] cnt_t_b3;
  wire [4:0] cnt_t_b4;
  wire [4:0] cnt_t_b5;
  wire [4:0] cnt_t_b7;
  wire [4:0] cnt_t_b8;
  wire [7:0] d_d;
  wire [4:0] dc_bias;
  wire [4:0] int_n1_q_m;
  wire [4:0] n0_q_m;
  wire [4:0] n0_q_m_b;
  wire [4:0] n1_d;
  wire [4:0] n1_d_b;
  wire [4:0] n1_q_m;
  wire [8:0] q_m;
  wire [8:0] q_m_d;
  wire [8:0] q_m_xnor;
  wire [8:0] q_m_xor;
  wire [9:0] q_out;
  wire add0_syn_50;
  wire add10_syn_36;
  wire add2_syn_21;
  wire add2_syn_22;
  wire add2_syn_23;
  wire add2_syn_24;
  wire add4_syn_20;
  wire add4_syn_21;
  wire add4_syn_22;
  wire add4_syn_23;
  wire eq1_syn_15;
  wire lt1_syn_20;
  wire lt1_syn_21;
  wire lt1_syn_22;
  wire lt1_syn_23;
  wire lt3_syn_4;
  wire lt3_syn_6;
  wire lt3_syn_8;
  wire lt3_syn_10;
  wire sub2_syn_23;
  wire sub2_syn_24;
  wire sub2_syn_25;
  wire sub2_syn_26;
  wire sub4_syn_21;
  wire sub4_syn_22;
  wire sub4_syn_23;
  wire sub4_syn_24;
  wire CLK_I_dup_1;
  wire \D_I[7]_dup_5 ;
  wire \D_I[6]_dup_5 ;
  wire \D_I[5]_dup_5 ;
  wire \D_I[4]_dup_5 ;
  wire \D_I[3]_dup_5 ;
  wire \D_I[2]_dup_5 ;
  wire \D_I[1]_dup_5 ;
  wire \D_I[0]_dup_5 ;
  wire c0_d;
  wire c0_dd;
  wire c1_d;
  wire c1_dd;
  wire cond_balanced_syn_2;
  wire cond_not_balanced_n4;
  wire cond_not_balanced_n6;
  wire de_d;
  wire de_dd;
  wire \int_n1_q_m[2]_syn_2 ;
  wire \n0_q_m_b[3]_syn_3 ;
  wire \n0_q_m_b[3]_syn_6 ;
  wire \n0_q_m_b[3]_syn_8 ;
  wire \n0_q_m_b[3]_syn_10 ;
  wire \n0_q_m_b[3]_syn_13 ;
  wire \n0_q_m_b[3]_syn_16 ;
  wire \n0_q_m_b[3]_syn_18 ;
  wire \n0_q_m_b[3]_syn_20 ;
  wire \n0_q_m_b[3]_syn_23 ;
  wire \n0_q_m_b[3]_syn_26 ;
  wire \q_out_b1[8]_syn_2 ;
  wire \n1_d_b[2]_syn_2 ;
  wire \n1_d_b[2]_syn_5 ;
  wire \n1_d_b[2]_syn_7 ;
  wire q_m_b_n;
  wire q_m_b_n_syn_2;
  wire \cnt_t_1_reg[1]_syn_2 ;
  wire \cnt_t_1_reg[2]_syn_2 ;
  wire \cnt_t_1_reg[2]_syn_5 ;
  wire \cnt_t_1_reg[2]_syn_7 ;
  wire \cnt_t_1_reg[2]_syn_10 ;
  wire \cnt_t_1_reg[2]_syn_12 ;
  wire \cnt_t_1_reg[2]_syn_14 ;
  wire \cnt_t_1_reg[3]_syn_2 ;
  wire \cnt_t_1_reg[3]_syn_5 ;
  wire \cnt_t_1_reg[4]_syn_2 ;
  wire \cnt_t_1_reg[4]_syn_4 ;
  wire \cnt_t_1_reg[4]_syn_6 ;

  EG_PHY_PAD #(
    //.HYSTERESIS("OFF"),
    //.PCICLAMP("OFF"),
    .IDDRMODE("OFF"),
    .IDDRPIPEMODE("NONE"),
    .INCEMUX("1"),
    .INPCLKMUX("CLK"),
    .INRSTMUX("0"),
    .IN_DFFMODE("FF"),
    .IN_REGSET("RESET"),
    .IOTYPE("LVCMOS25"),
    .MODE("IN"),
    .SRMODE("ASYNC"),
    .TSMUX("1"))
    C0_I_syn_6 (
    .ipad(C0_I),
    .ipclk(CLK_I_dup_1),
    .diq({open_n11,open_n12,open_n13,c0_d}));
  EG_PHY_PAD #(
    //.HYSTERESIS("OFF"),
    //.PCICLAMP("OFF"),
    .IDDRMODE("OFF"),
    .IDDRPIPEMODE("NONE"),
    .INCEMUX("1"),
    .INPCLKMUX("CLK"),
    .INRSTMUX("0"),
    .IN_DFFMODE("FF"),
    .IN_REGSET("RESET"),
    .IOTYPE("LVCMOS25"),
    .MODE("IN"),
    .SRMODE("ASYNC"),
    .TSMUX("1"))
    C1_I_syn_6 (
    .ipad(C1_I),
    .ipclk(CLK_I_dup_1),
    .diq({open_n27,open_n28,open_n29,c1_d}));
  EG_PHY_PAD #(
    //.HYSTERESIS("OFF"),
    //.PCICLAMP("OFF"),
    .IOTYPE("LVCMOS25"),
    .MODE("IN"),
    .TSMUX("1"))
    CLK_I_syn_2 (
    .ipad(CLK_I),
    .di(CLK_I_dup_1));
  EG_PHY_PAD #(
    //.HYSTERESIS("OFF"),
    //.PCICLAMP("OFF"),
    .IDDRMODE("OFF"),
    .IDDRPIPEMODE("NONE"),
    .INCEMUX("1"),
    .INPCLKMUX("CLK"),
    .INRSTMUX("0"),
    .IN_DFFMODE("FF"),
    .IN_REGSET("RESET"),
    .IOTYPE("LVCMOS25"),
    .MODE("IN"),
    .SRMODE("ASYNC"),
    .TSMUX("1"))
    DE_I_syn_6 (
    .ipad(DE_I),
    .ipclk(CLK_I_dup_1),
    .diq({open_n60,open_n61,open_n62,de_d}));
  EG_PHY_PAD #(
    //.HYSTERESIS("OFF"),
    //.PCICLAMP("OFF"),
    .IDDRMODE("OFF"),
    .IDDRPIPEMODE("NONE"),
    .INCEMUX("1"),
    .INPCLKMUX("CLK"),
    .INRSTMUX("0"),
    .IN_DFFMODE("FF"),
    .IN_REGSET("RESET"),
    .IOTYPE("LVCMOS25"),
    .MODE("IN"),
    .SRMODE("ASYNC"),
    .TSMUX("1"))
    \D_I[0]_syn_6  (
    .ipad(D_I[0]),
    .ipclk(CLK_I_dup_1),
    .di(\D_I[0]_dup_5 ),
    .diq({open_n75,open_n76,open_n77,q_m_xnor[0]}));
  EG_PHY_PAD #(
    //.HYSTERESIS("OFF"),
    //.PCICLAMP("OFF"),
    .IDDRMODE("OFF"),
    .IDDRPIPEMODE("NONE"),
    .INCEMUX("1"),
    .INPCLKMUX("CLK"),
    .INRSTMUX("0"),
    .IN_DFFMODE("FF"),
    .IN_REGSET("RESET"),
    .IOTYPE("LVCMOS25"),
    .MODE("IN"),
    .SRMODE("ASYNC"),
    .TSMUX("1"))
    \D_I[1]_syn_6  (
    .ipad(D_I[1]),
    .ipclk(CLK_I_dup_1),
    .di(\D_I[1]_dup_5 ),
    .diq({open_n90,open_n91,open_n92,d_d[1]}));
  EG_PHY_PAD #(
    //.HYSTERESIS("OFF"),
    //.PCICLAMP("OFF"),
    .IDDRMODE("OFF"),
    .IDDRPIPEMODE("NONE"),
    .INCEMUX("1"),
    .INPCLKMUX("CLK"),
    .INRSTMUX("0"),
    .IN_DFFMODE("FF"),
    .IN_REGSET("RESET"),
    .IOTYPE("LVCMOS25"),
    .MODE("IN"),
    .SRMODE("ASYNC"),
    .TSMUX("1"))
    \D_I[2]_syn_6  (
    .ipad(D_I[2]),
    .ipclk(CLK_I_dup_1),
    .di(\D_I[2]_dup_5 ),
    .diq({open_n105,open_n106,open_n107,d_d[2]}));
  EG_PHY_PAD #(
    //.HYSTERESIS("OFF"),
    //.PCICLAMP("OFF"),
    .IDDRMODE("OFF"),
    .IDDRPIPEMODE("NONE"),
    .INCEMUX("1"),
    .INPCLKMUX("CLK"),
    .INRSTMUX("0"),
    .IN_DFFMODE("FF"),
    .IN_REGSET("RESET"),
    .IOTYPE("LVCMOS25"),
    .MODE("IN"),
    .SRMODE("ASYNC"),
    .TSMUX("1"))
    \D_I[3]_syn_6  (
    .ipad(D_I[3]),
    .ipclk(CLK_I_dup_1),
    .di(\D_I[3]_dup_5 ),
    .diq({open_n120,open_n121,open_n122,d_d[3]}));
  EG_PHY_PAD #(
    //.HYSTERESIS("OFF"),
    //.PCICLAMP("OFF"),
    .IDDRMODE("OFF"),
    .IDDRPIPEMODE("NONE"),
    .INCEMUX("1"),
    .INPCLKMUX("CLK"),
    .INRSTMUX("0"),
    .IN_DFFMODE("FF"),
    .IN_REGSET("RESET"),
    .IOTYPE("LVCMOS25"),
    .MODE("IN"),
    .SRMODE("ASYNC"),
    .TSMUX("1"))
    \D_I[4]_syn_6  (
    .ipad(D_I[4]),
    .ipclk(CLK_I_dup_1),
    .di(\D_I[4]_dup_5 ),
    .diq({open_n135,open_n136,open_n137,d_d[4]}));
  EG_PHY_PAD #(
    //.HYSTERESIS("OFF"),
    //.PCICLAMP("OFF"),
    .IDDRMODE("OFF"),
    .IDDRPIPEMODE("NONE"),
    .INCEMUX("1"),
    .INPCLKMUX("CLK"),
    .INRSTMUX("0"),
    .IN_DFFMODE("FF"),
    .IN_REGSET("RESET"),
    .IOTYPE("LVCMOS25"),
    .MODE("IN"),
    .SRMODE("ASYNC"),
    .TSMUX("1"))
    \D_I[5]_syn_6  (
    .ipad(D_I[5]),
    .ipclk(CLK_I_dup_1),
    .di(\D_I[5]_dup_5 ),
    .diq({open_n150,open_n151,open_n152,d_d[5]}));
  EG_PHY_PAD #(
    //.HYSTERESIS("OFF"),
    //.PCICLAMP("OFF"),
    .IDDRMODE("OFF"),
    .IDDRPIPEMODE("NONE"),
    .INCEMUX("1"),
    .INPCLKMUX("CLK"),
    .INRSTMUX("0"),
    .IN_DFFMODE("FF"),
    .IN_REGSET("RESET"),
    .IOTYPE("LVCMOS25"),
    .MODE("IN"),
    .SRMODE("ASYNC"),
    .TSMUX("1"))
    \D_I[6]_syn_6  (
    .ipad(D_I[6]),
    .ipclk(CLK_I_dup_1),
    .di(\D_I[6]_dup_5 ),
    .diq({open_n165,open_n166,open_n167,d_d[6]}));
  EG_PHY_PAD #(
    //.HYSTERESIS("OFF"),
    //.PCICLAMP("OFF"),
    .IDDRMODE("OFF"),
    .IDDRPIPEMODE("NONE"),
    .INCEMUX("1"),
    .INPCLKMUX("CLK"),
    .INRSTMUX("0"),
    .IN_DFFMODE("FF"),
    .IN_REGSET("RESET"),
    .IOTYPE("LVCMOS25"),
    .MODE("IN"),
    .SRMODE("ASYNC"),
    .TSMUX("1"))
    \D_I[7]_syn_6  (
    .ipad(D_I[7]),
    .ipclk(CLK_I_dup_1),
    .di(\D_I[7]_dup_5 ),
    .diq({open_n180,open_n181,open_n182,d_d[7]}));
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DO_DFFMODE("FF"),
    .DO_REGSET("RESET"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .ODDRMODE("OFF"),
    .OUTCEMUX("1"),
    .OUTRSTMUX("0"),
    .OUTSCLKMUX("CLK"),
    .SRMODE("ASYNC"),
    .TSMUX("0"))
    \D_O[0]_syn_6  (
    .do({open_n186,open_n187,open_n188,q_out[0]}),
    .osclk(CLK_I_dup_1),
    .opad(D_O[0]));
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DO_DFFMODE("FF"),
    .DO_REGSET("RESET"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .ODDRMODE("OFF"),
    .OUTCEMUX("1"),
    .OUTRSTMUX("0"),
    .OUTSCLKMUX("CLK"),
    .SRMODE("ASYNC"),
    .TSMUX("0"))
    \D_O[1]_syn_6  (
    .do({open_n202,open_n203,open_n204,q_out[1]}),
    .osclk(CLK_I_dup_1),
    .opad(D_O[1]));
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DO_DFFMODE("FF"),
    .DO_REGSET("RESET"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .ODDRMODE("OFF"),
    .OUTCEMUX("1"),
    .OUTRSTMUX("0"),
    .OUTSCLKMUX("CLK"),
    .SRMODE("ASYNC"),
    .TSMUX("0"))
    \D_O[2]_syn_6  (
    .do({open_n218,open_n219,open_n220,q_out[2]}),
    .osclk(CLK_I_dup_1),
    .opad(D_O[2]));
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DO_DFFMODE("FF"),
    .DO_REGSET("RESET"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .ODDRMODE("OFF"),
    .OUTCEMUX("1"),
    .OUTRSTMUX("0"),
    .OUTSCLKMUX("CLK"),
    .SRMODE("ASYNC"),
    .TSMUX("0"))
    \D_O[3]_syn_6  (
    .do({open_n234,open_n235,open_n236,q_out[3]}),
    .osclk(CLK_I_dup_1),
    .opad(D_O[3]));
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DO_DFFMODE("FF"),
    .DO_REGSET("RESET"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .ODDRMODE("OFF"),
    .OUTCEMUX("1"),
    .OUTRSTMUX("0"),
    .OUTSCLKMUX("CLK"),
    .SRMODE("ASYNC"),
    .TSMUX("0"))
    \D_O[4]_syn_6  (
    .do({open_n250,open_n251,open_n252,q_out[4]}),
    .osclk(CLK_I_dup_1),
    .opad(D_O[4]));
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DO_DFFMODE("FF"),
    .DO_REGSET("RESET"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .ODDRMODE("OFF"),
    .OUTCEMUX("1"),
    .OUTRSTMUX("0"),
    .OUTSCLKMUX("CLK"),
    .SRMODE("ASYNC"),
    .TSMUX("0"))
    \D_O[5]_syn_6  (
    .do({open_n266,open_n267,open_n268,q_out[5]}),
    .osclk(CLK_I_dup_1),
    .opad(D_O[5]));
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DO_DFFMODE("FF"),
    .DO_REGSET("RESET"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .ODDRMODE("OFF"),
    .OUTCEMUX("1"),
    .OUTRSTMUX("0"),
    .OUTSCLKMUX("CLK"),
    .SRMODE("ASYNC"),
    .TSMUX("0"))
    \D_O[6]_syn_6  (
    .do({open_n282,open_n283,open_n284,q_out[6]}),
    .osclk(CLK_I_dup_1),
    .opad(D_O[6]));
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DO_DFFMODE("FF"),
    .DO_REGSET("RESET"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .ODDRMODE("OFF"),
    .OUTCEMUX("1"),
    .OUTRSTMUX("0"),
    .OUTSCLKMUX("CLK"),
    .SRMODE("ASYNC"),
    .TSMUX("0"))
    \D_O[7]_syn_6  (
    .do({open_n298,open_n299,open_n300,q_out[7]}),
    .osclk(CLK_I_dup_1),
    .opad(D_O[7]));
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DO_DFFMODE("FF"),
    .DO_REGSET("RESET"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .ODDRMODE("OFF"),
    .OUTCEMUX("1"),
    .OUTRSTMUX("0"),
    .OUTSCLKMUX("CLK"),
    .SRMODE("ASYNC"),
    .TSMUX("0"))
    \D_O[8]_syn_6  (
    .do({open_n314,open_n315,open_n316,q_out[8]}),
    .osclk(CLK_I_dup_1),
    .opad(D_O[8]));
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DO_DFFMODE("FF"),
    .DO_REGSET("RESET"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .ODDRMODE("OFF"),
    .OUTCEMUX("1"),
    .OUTRSTMUX("0"),
    .OUTSCLKMUX("CLK"),
    .SRMODE("ASYNC"),
    .TSMUX("0"))
    \D_O[9]_syn_6  (
    .do({open_n330,open_n331,open_n332,q_out[9]}),
    .osclk(CLK_I_dup_1),
    .opad(D_O[9]));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    add2_syn_3 (
    .a(q_m_b_n_syn_2),
    .o({add2_syn_21,open_n347}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    add2_syn_4 (
    .a(eq1_syn_15),
    .b(cnt_t_1[1]),
    .c(add2_syn_21),
    .o({add2_syn_22,open_n348}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    add2_syn_5 (
    .a(dc_bias[2]),
    .b(cnt_t_1[2]),
    .c(add2_syn_22),
    .o({add2_syn_23,cnt_t_b8[2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    add2_syn_6 (
    .a(dc_bias[3]),
    .b(cnt_t_1[3]),
    .c(add2_syn_23),
    .o({add2_syn_24,cnt_t_b8[3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    add2_syn_7 (
    .a(cond_not_balanced_n4),
    .b(cnt_t_1[4]),
    .c(add2_syn_24),
    .o({open_n349,cnt_t_b8[4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    add4_syn_2 (
    .a(1'b0),
    .o({add4_syn_20,open_n352}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    add4_syn_3 (
    .a(cnt_t_1[1]),
    .b(eq1_syn_15),
    .c(add4_syn_20),
    .o({add4_syn_21,open_n353}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    add4_syn_4 (
    .a(cnt_t_1[2]),
    .b(dc_bias[2]),
    .c(add4_syn_21),
    .o({add4_syn_22,cnt_t_b3[2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    add4_syn_5 (
    .a(cnt_t_1[3]),
    .b(dc_bias[3]),
    .c(add4_syn_22),
    .o({add4_syn_23,cnt_t_b3[3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    add4_syn_6 (
    .a(cnt_t_1[4]),
    .b(cond_not_balanced_n4),
    .c(add4_syn_23),
    .o({open_n354,cnt_t_b3[4]}));
  AL_DFF_X #(
    .INIT(1'b0))
    c0_dd_reg (
    .ar(1'b0),
    .as(1'b0),
    .clk(CLK_I_dup_1),
    .d(c0_d),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(c0_dd));
  AL_DFF_X #(
    .INIT(1'b0))
    c1_dd_reg (
    .ar(1'b0),
    .as(1'b0),
    .clk(CLK_I_dup_1),
    .d(c1_d),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(c1_dd));
  AL_DFF_X #(
    .INIT(1'b0))
    \cnt_t_1_reg[1]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(CLK_I_dup_1),
    .d(\cnt_t_1_reg[1]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(cnt_t_1[1]));
  AL_MAP_LUT5 #(
    .EQN("(C*~(~E*~((D@B))*~(A)+~E*(D@B)*~(A)+~(~E)*(D@B)*A+~E*(D@B)*A))"),
    .INIT(32'hd0708020))
    \cnt_t_1_reg[1]_syn_3  (
    .a(cond_balanced_syn_2),
    .b(\cnt_t_1_reg[2]_syn_10 ),
    .c(de_dd),
    .d(cnt_t_b7[1]),
    .e(cnt_t_b5[1]),
    .o(\cnt_t_1_reg[1]_syn_2 ));
  AL_DFF_X #(
    .INIT(1'b0))
    \cnt_t_1_reg[2]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(CLK_I_dup_1),
    .d(\cnt_t_1_reg[2]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(cnt_t_1[2]));
  AL_MAP_LUT3 #(
    .EQN("~(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'h1b))
    \cnt_t_1_reg[2]_syn_11  (
    .a(\cnt_t_1_reg[2]_syn_10 ),
    .b(cnt_t_b8[2]),
    .c(cnt_t_b7[2]),
    .o(\cnt_t_1_reg[2]_syn_12 ));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    \cnt_t_1_reg[2]_syn_13  (
    .a(cnt_t_b3[2]),
    .b(cnt_t_b5[2]),
    .c(q_m_d[8]),
    .o(\cnt_t_1_reg[2]_syn_14 ));
  AL_MAP_LUT4 #(
    .EQN("(D*~(C*~(A)*~(B)+C*A*~(B)+~(C)*A*B+C*A*B))"),
    .INIT(16'h4700))
    \cnt_t_1_reg[2]_syn_15  (
    .a(\cnt_t_1_reg[2]_syn_12 ),
    .b(cond_balanced_syn_2),
    .c(\cnt_t_1_reg[2]_syn_14 ),
    .d(de_dd),
    .o(\cnt_t_1_reg[2]_syn_2 ));
  AL_MAP_LUT2 #(
    .EQN("(B@A)"),
    .INIT(4'h6))
    \cnt_t_1_reg[2]_syn_3  (
    .a(n0_q_m[1]),
    .b(n1_q_m[1]),
    .o(eq1_syn_15));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*~A)"),
    .INIT(8'h01))
    \cnt_t_1_reg[2]_syn_4  (
    .a(cnt_t_1[1]),
    .b(cnt_t_1[2]),
    .c(cnt_t_1[3]),
    .o(\cnt_t_1_reg[2]_syn_5 ));
  AL_MAP_LUT4 #(
    .EQN("(~(D@B)*~(C@A))"),
    .INIT(16'h8421))
    \cnt_t_1_reg[2]_syn_6  (
    .a(n0_q_m[2]),
    .b(n0_q_m[3]),
    .c(n1_q_m[2]),
    .d(n1_q_m[3]),
    .o(\cnt_t_1_reg[2]_syn_7 ));
  AL_MAP_LUT4 #(
    .EQN("(~(~D*B)*~(~C*A))"),
    .INIT(16'hf531))
    \cnt_t_1_reg[2]_syn_8  (
    .a(\cnt_t_1_reg[2]_syn_7 ),
    .b(\cnt_t_1_reg[2]_syn_5 ),
    .c(eq1_syn_15),
    .d(cnt_t_1[4]),
    .o(cond_balanced_syn_2));
  AL_MAP_LUT4 #(
    .EQN("~((B*~A)*~(C)*~(D)+(B*~A)*C*~(D)+~((B*~A))*C*D+(B*~A)*C*D)"),
    .INIT(16'h0fbb))
    \cnt_t_1_reg[2]_syn_9  (
    .a(\cnt_t_1_reg[2]_syn_5 ),
    .b(cond_not_balanced_n4),
    .c(cond_not_balanced_n6),
    .d(cnt_t_1[4]),
    .o(\cnt_t_1_reg[2]_syn_10 ));
  AL_DFF_X #(
    .INIT(1'b0))
    \cnt_t_1_reg[3]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(CLK_I_dup_1),
    .d(\cnt_t_1_reg[3]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(cnt_t_1[3]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    \cnt_t_1_reg[3]_syn_3  (
    .a(\cnt_t_1_reg[2]_syn_10 ),
    .b(cnt_t_b8[3]),
    .c(cnt_t_b7[3]),
    .o(cnt_t_b4[3]));
  AL_MAP_LUT4 #(
    .EQN("(~A*(B*~(C)*~(D)+B*C*~(D)+~(B)*C*D+B*C*D))"),
    .INIT(16'h5044))
    \cnt_t_1_reg[3]_syn_4  (
    .a(cond_balanced_syn_2),
    .b(cnt_t_b3[3]),
    .c(cnt_t_b5[3]),
    .d(q_m_d[8]),
    .o(\cnt_t_1_reg[3]_syn_5 ));
  AL_MAP_LUT4 #(
    .EQN("(D*~(~A*~(C*B)))"),
    .INIT(16'hea00))
    \cnt_t_1_reg[3]_syn_6  (
    .a(\cnt_t_1_reg[3]_syn_5 ),
    .b(cnt_t_b4[3]),
    .c(cond_balanced_syn_2),
    .d(de_dd),
    .o(\cnt_t_1_reg[3]_syn_2 ));
  AL_DFF_X #(
    .INIT(1'b0))
    \cnt_t_1_reg[4]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(CLK_I_dup_1),
    .d(\cnt_t_1_reg[4]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(cnt_t_1[4]));
  AL_MAP_LUT3 #(
    .EQN("~(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'h1b))
    \cnt_t_1_reg[4]_syn_3  (
    .a(\cnt_t_1_reg[2]_syn_10 ),
    .b(cnt_t_b8[4]),
    .c(cnt_t_b7[4]),
    .o(\cnt_t_1_reg[4]_syn_4 ));
  AL_MAP_LUT3 #(
    .EQN("~(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'h35))
    \cnt_t_1_reg[4]_syn_5  (
    .a(cnt_t_b3[4]),
    .b(cnt_t_b5[4]),
    .c(q_m_d[8]),
    .o(\cnt_t_1_reg[4]_syn_6 ));
  AL_MAP_LUT4 #(
    .EQN("(D*~(C*~(A)*~(B)+C*A*~(B)+~(C)*A*B+C*A*B))"),
    .INIT(16'h4700))
    \cnt_t_1_reg[4]_syn_7  (
    .a(\cnt_t_1_reg[4]_syn_4 ),
    .b(cond_balanced_syn_2),
    .c(\cnt_t_1_reg[4]_syn_6 ),
    .d(de_dd),
    .o(\cnt_t_1_reg[4]_syn_2 ));
  EG_PHY_CONFIG #(
    .DONE_PERSISTN("ENABLE"),
    .INIT_PERSISTN("ENABLE"),
    .JTAG_PERSISTN("DISABLE"),
    .PROGRAMN_PERSISTN("DISABLE"))
    config_inst ();
  AL_DFF_X #(
    .INIT(1'b0))
    de_dd_reg (
    .ar(1'b0),
    .as(1'b0),
    .clk(CLK_I_dup_1),
    .d(de_d),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(de_dd));
  AL_MAP_LUT4 #(
    .EQN("~(D@C@B@A)"),
    .INIT(16'h9669))
    \int_n1_q_m[1]_syn_1  (
    .a(add10_syn_6[1]),
    .b(add10_syn_36),
    .c(\int_n1_q_m[2]_syn_2 ),
    .d(\n0_q_m_b[3]_syn_23 ),
    .o(int_n1_q_m[1]));
  AL_MAP_LUT5 #(
    .EQN("(C*~(D)*~((E@B@A))+~(C)*D*~((E@B@A))+C*D*~((E@B@A))+~(C)*~(D)*(E@B@A)+C*~(D)*(E@B@A)+~(C)*D*(E@B@A))"),
    .INIT(32'h6ff99ff6))
    \int_n1_q_m[2]_syn_1  (
    .a(q_m_xnor[4]),
    .b(q_m_b_n_syn_2),
    .c(\n0_q_m_b[3]_syn_16 ),
    .d(\n0_q_m_b[3]_syn_20 ),
    .e(d_d[2]),
    .o(\int_n1_q_m[2]_syn_2 ));
  AL_MAP_LUT4 #(
    .EQN("(A*~(B)*~(C)*~(D)+~(A)*B*~(C)*~(D)+A*B*~(C)*~(D)+A*B*C*~(D)+~(A)*~(B)*~(C)*D+A*~(B)*~(C)*D+~(A)*B*~(C)*D+A*~(B)*C*D+~(A)*B*C*D+A*B*C*D)"),
    .INIT(16'he78e))
    \int_n1_q_m[2]_syn_3  (
    .a(add10_syn_6[1]),
    .b(add10_syn_36),
    .c(\int_n1_q_m[2]_syn_2 ),
    .d(\n0_q_m_b[3]_syn_23 ),
    .o(int_n1_q_m[2]));
  AL_MAP_LUT4 #(
    .EQN("(D*~C*B*A)"),
    .INIT(16'h0800))
    \int_n1_q_m[3]_syn_1  (
    .a(add10_syn_6[1]),
    .b(add10_syn_36),
    .c(\int_n1_q_m[2]_syn_2 ),
    .d(\n0_q_m_b[3]_syn_23 ),
    .o(int_n1_q_m[3]));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB_CARRY"))
    lt1_syn_4 (
    .a(1'b0),
    .o({lt1_syn_20,open_n404}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    lt1_syn_5 (
    .a(n0_q_m[1]),
    .b(n1_q_m[1]),
    .c(lt1_syn_20),
    .o({lt1_syn_21,open_n405}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    lt1_syn_6 (
    .a(n0_q_m[2]),
    .b(n1_q_m[2]),
    .c(lt1_syn_21),
    .o({lt1_syn_22,dc_bias[2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    lt1_syn_7 (
    .a(n0_q_m[3]),
    .b(n1_q_m[3]),
    .c(lt1_syn_22),
    .o({lt1_syn_23,dc_bias[3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    lt1_syn_8 (
    .c(lt1_syn_23),
    .o({open_n408,cond_not_balanced_n4}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B_CARRY"))
    lt3_syn_2 (
    .a(1'b0),
    .o({lt3_syn_4,open_n411}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    lt3_syn_3 (
    .a(n1_q_m[1]),
    .b(n0_q_m[1]),
    .c(lt3_syn_4),
    .o({lt3_syn_6,open_n412}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    lt3_syn_5 (
    .a(n1_q_m[2]),
    .b(n0_q_m[2]),
    .c(lt3_syn_6),
    .o({lt3_syn_8,open_n413}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    lt3_syn_7 (
    .a(n1_q_m[3]),
    .b(n0_q_m[3]),
    .c(lt3_syn_8),
    .o({lt3_syn_10,open_n414}));
  AL_MAP_ADDER #(
    .ALUTYPE("A_LE_B"))
    lt3_syn_9 (
    .a(1'b0),
    .b(1'b1),
    .c(lt3_syn_10),
    .o({open_n415,cond_not_balanced_n6}));
  AL_MAP_LUT4 #(
    .EQN("(D@C@B@A)"),
    .INIT(16'h6996))
    \n0_q_m_b[1]_syn_1  (
    .a(add10_syn_6[1]),
    .b(add10_syn_36),
    .c(\n0_q_m_b[3]_syn_23 ),
    .d(\n0_q_m_b[3]_syn_26 ),
    .o(n0_q_m_b[1]));
  AL_MAP_LUT4 #(
    .EQN("(A*~(B)*~(C)*~(D)+~(A)*B*~(C)*~(D)+A*B*~(C)*~(D)+~(A)*~(B)*C*~(D)+A*~(B)*C*~(D)+~(A)*B*C*~(D)+~(A)*~(B)*~(C)*D+A*~(B)*~(C)*D+~(A)*B*~(C)*D+~(A)*~(B)*C*D)"),
    .INIT(16'h177e))
    \n0_q_m_b[2]_syn_1  (
    .a(add10_syn_6[1]),
    .b(add10_syn_36),
    .c(\n0_q_m_b[3]_syn_23 ),
    .d(\n0_q_m_b[3]_syn_26 ),
    .o(n0_q_m_b[2]));
  AL_MAP_LUT3 #(
    .EQN("(C@B@A)"),
    .INIT(8'h96))
    \n0_q_m_b[3]_syn_1  (
    .a(d_d[2]),
    .b(d_d[1]),
    .c(q_m_xnor[0]),
    .o(q_m_xnor[2]));
  AL_MAP_LUT5 #(
    .EQN("(~E*~(D*~(~C*~B*A)))"),
    .INIT(32'h000002ff))
    \n0_q_m_b[3]_syn_11  (
    .a(q_m_xnor[0]),
    .b(n1_d[0]),
    .c(n1_d[1]),
    .d(n1_d[2]),
    .e(n1_d[3]),
    .o(q_m_b_n_syn_2));
  AL_MAP_LUT5 #(
    .EQN("(A*~((~C*~B))*~(D)*~(E)+A*(~C*~B)*~(D)*~(E)+~(A)*~((~C*~B))*D*~(E)+~(A)*(~C*~B)*D*~(E)+A*(~C*~B)*D*~(E)+~(A)*~((~C*~B))*~(D)*E+~(A)*(~C*~B)*~(D)*E+~(A)*~((~C*~B))*D*E+~(A)*(~C*~B)*D*E)"),
    .INIT(32'h555557aa))
    \n0_q_m_b[3]_syn_12  (
    .a(q_m_xnor[0]),
    .b(n1_d[0]),
    .c(n1_d[1]),
    .d(n1_d[2]),
    .e(n1_d[3]),
    .o(\n0_q_m_b[3]_syn_13 ));
  AL_MAP_LUT5 #(
    .EQN("~(C@A@(~E*~(D*~B)))"),
    .INIT(32'ha5a5695a))
    \n0_q_m_b[3]_syn_14  (
    .a(\n0_q_m_b[3]_syn_3 ),
    .b(\n0_q_m_b[3]_syn_10 ),
    .c(\n0_q_m_b[3]_syn_6 ),
    .d(n1_d[2]),
    .e(n1_d[3]),
    .o(q_m[5]));
  AL_MAP_LUT4 #(
    .EQN("(D@C@B@A)"),
    .INIT(16'h6996))
    \n0_q_m_b[3]_syn_15  (
    .a(d_d[7]),
    .b(d_d[6]),
    .c(d_d[5]),
    .d(d_d[1]),
    .o(\n0_q_m_b[3]_syn_16 ));
  AL_MAP_LUT5 #(
    .EQN("~(B@(~E*~(D*~(C*A))))"),
    .INIT(32'h333393cc))
    \n0_q_m_b[3]_syn_17  (
    .a(\n0_q_m_b[3]_syn_8 ),
    .b(d_d[2]),
    .c(q_m_xnor[0]),
    .d(n1_d[2]),
    .e(n1_d[3]),
    .o(\n0_q_m_b[3]_syn_18 ));
  AL_MAP_LUT2 #(
    .EQN("(B@A)"),
    .INIT(4'h6))
    \n0_q_m_b[3]_syn_19  (
    .a(d_d[6]),
    .b(d_d[3]),
    .o(\n0_q_m_b[3]_syn_20 ));
  AL_MAP_LUT4 #(
    .EQN("~(D@C@B@A)"),
    .INIT(16'h9669))
    \n0_q_m_b[3]_syn_2  (
    .a(d_d[3]),
    .b(d_d[2]),
    .c(d_d[1]),
    .d(q_m_xnor[0]),
    .o(\n0_q_m_b[3]_syn_3 ));
  AL_MAP_LUT5 #(
    .EQN("(B*(D@C@A)*~(E)+B*~((D@C@A))*E+~(B)*(D@C@A)*E+B*(D@C@A)*E)"),
    .INIT(32'hedde8448))
    \n0_q_m_b[3]_syn_21  (
    .a(q_m[5]),
    .b(q_m_xnor[2]),
    .c(d_d[7]),
    .d(d_d[6]),
    .e(q_m_xnor[0]),
    .o(add10_syn_6[1]));
  AL_MAP_LUT5 #(
    .EQN("((E@B)*~((C@A))*~(D)+(E@B)*(C@A)*~(D)+~((E@B))*(C@A)*D+(E@B)*(C@A)*D)"),
    .INIT(32'h5a335acc))
    \n0_q_m_b[3]_syn_22  (
    .a(q_m_b_n_syn_2),
    .b(\n0_q_m_b[3]_syn_13 ),
    .c(\n0_q_m_b[3]_syn_3 ),
    .d(\n0_q_m_b[3]_syn_6 ),
    .e(d_d[1]),
    .o(\n0_q_m_b[3]_syn_23 ));
  AL_MAP_LUT5 #(
    .EQN("(B@(~(C)*D*~((E@A))+C*~(D)*(E@A)))"),
    .INIT(32'hc69cc96c))
    \n0_q_m_b[3]_syn_24  (
    .a(\n0_q_m_b[3]_syn_18 ),
    .b(q_m_xnor[4]),
    .c(d_d[6]),
    .d(d_d[5]),
    .e(d_d[3]),
    .o(add10_syn_36));
  AL_MAP_LUT5 #(
    .EQN("(~(C)*~(D)*~((E@B@A))+C*~(D)*~((E@B@A))+~(C)*D*~((E@B@A))+C*~(D)*(E@B@A)+~(C)*D*(E@B@A)+C*D*(E@B@A))"),
    .INIT(32'h9ff66ff9))
    \n0_q_m_b[3]_syn_25  (
    .a(q_m_xnor[4]),
    .b(q_m_b_n_syn_2),
    .c(\n0_q_m_b[3]_syn_16 ),
    .d(\n0_q_m_b[3]_syn_20 ),
    .e(d_d[2]),
    .o(\n0_q_m_b[3]_syn_26 ));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*~A)"),
    .INIT(16'h0001))
    \n0_q_m_b[3]_syn_27  (
    .a(add10_syn_6[1]),
    .b(add10_syn_36),
    .c(\n0_q_m_b[3]_syn_23 ),
    .d(\n0_q_m_b[3]_syn_26 ),
    .o(n0_q_m_b[3]));
  AL_MAP_LUT5 #(
    .EQN("(E@D@C@B@A)"),
    .INIT(32'h96696996))
    \n0_q_m_b[3]_syn_4  (
    .a(d_d[4]),
    .b(d_d[3]),
    .c(d_d[2]),
    .d(d_d[1]),
    .e(q_m_xnor[0]),
    .o(q_m_xnor[4]));
  AL_MAP_LUT2 #(
    .EQN("~(B@A)"),
    .INIT(4'h9))
    \n0_q_m_b[3]_syn_5  (
    .a(d_d[5]),
    .b(d_d[4]),
    .o(\n0_q_m_b[3]_syn_6 ));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    \n0_q_m_b[3]_syn_7  (
    .a(n1_d[0]),
    .b(n1_d[1]),
    .o(\n0_q_m_b[3]_syn_8 ));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*A)"),
    .INIT(8'h02))
    \n0_q_m_b[3]_syn_9  (
    .a(q_m_xnor[0]),
    .b(n1_d[0]),
    .c(n1_d[1]),
    .o(\n0_q_m_b[3]_syn_10 ));
  AL_DFF_X #(
    .INIT(1'b0))
    \n0_q_m_reg[1]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(CLK_I_dup_1),
    .d(n0_q_m_b[1]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(n0_q_m[1]));
  AL_DFF_X #(
    .INIT(1'b0))
    \n0_q_m_reg[2]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(CLK_I_dup_1),
    .d(n0_q_m_b[2]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(n0_q_m[2]));
  AL_DFF_X #(
    .INIT(1'b0))
    \n0_q_m_reg[3]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(CLK_I_dup_1),
    .d(n0_q_m_b[3]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(n0_q_m[3]));
  AL_MAP_LUT4 #(
    .EQN("~(D@C@B@A)"),
    .INIT(16'h9669))
    \n1_d_b[0]_syn_1  (
    .a(\n1_d_b[2]_syn_7 ),
    .b(\D_I[7]_dup_5 ),
    .c(\D_I[6]_dup_5 ),
    .d(\D_I[5]_dup_5 ),
    .o(n1_d_b[0]));
  AL_MAP_LUT4 #(
    .EQN("~(D@C@B@A)"),
    .INIT(16'h9669))
    \n1_d_b[1]_syn_1  (
    .a(add0_syn_50),
    .b(\n1_d_b[2]_syn_5 ),
    .c(\n1_d_b[2]_syn_2 ),
    .d(add0_syn_6[1]),
    .o(n1_d_b[1]));
  AL_MAP_LUT3 #(
    .EQN("(A*B*~(C)+A*~(B)*C+~(A)*B*C+A*B*C)"),
    .INIT(8'he8))
    \n1_d_b[2]_syn_1  (
    .a(\D_I[4]_dup_5 ),
    .b(\D_I[3]_dup_5 ),
    .c(\D_I[2]_dup_5 ),
    .o(\n1_d_b[2]_syn_2 ));
  AL_MAP_LUT4 #(
    .EQN("(A*~(B)*~(C)*~(D)+~(A)*~(B)*C*~(D)+A*~(B)*C*~(D)+A*B*C*~(D)+~(A)*~(B)*~(C)*D+A*~(B)*~(C)*D+A*B*~(C)*D+~(A)*~(B)*C*D+~(A)*B*C*D+A*B*C*D)"),
    .INIT(16'hdbb2))
    \n1_d_b[2]_syn_10  (
    .a(add0_syn_50),
    .b(\n1_d_b[2]_syn_5 ),
    .c(\n1_d_b[2]_syn_2 ),
    .d(add0_syn_6[1]),
    .o(n1_d_b[2]));
  AL_MAP_LUT3 #(
    .EQN("(C@B@A)"),
    .INIT(8'h96))
    \n1_d_b[2]_syn_3  (
    .a(\D_I[4]_dup_5 ),
    .b(\D_I[3]_dup_5 ),
    .c(\D_I[2]_dup_5 ),
    .o(add0_syn_3[0]));
  AL_MAP_LUT3 #(
    .EQN("(~(A)*~(B)*~(C)+A*~(B)*~(C)+~(A)*B*~(C)+~(A)*~(B)*C)"),
    .INIT(8'h17))
    \n1_d_b[2]_syn_4  (
    .a(add0_syn_3[0]),
    .b(\D_I[1]_dup_5 ),
    .c(\D_I[0]_dup_5 ),
    .o(\n1_d_b[2]_syn_5 ));
  AL_MAP_LUT3 #(
    .EQN("~(C@B@A)"),
    .INIT(8'h69))
    \n1_d_b[2]_syn_6  (
    .a(add0_syn_3[0]),
    .b(\D_I[1]_dup_5 ),
    .c(\D_I[0]_dup_5 ),
    .o(\n1_d_b[2]_syn_7 ));
  AL_MAP_LUT3 #(
    .EQN("(A*B*~(C)+A*~(B)*C+~(A)*B*C+A*B*C)"),
    .INIT(8'he8))
    \n1_d_b[2]_syn_8  (
    .a(\D_I[7]_dup_5 ),
    .b(\D_I[6]_dup_5 ),
    .c(\D_I[5]_dup_5 ),
    .o(add0_syn_6[1]));
  AL_MAP_LUT4 #(
    .EQN("(~A*(D@C@B))"),
    .INIT(16'h4114))
    \n1_d_b[2]_syn_9  (
    .a(\n1_d_b[2]_syn_7 ),
    .b(\D_I[7]_dup_5 ),
    .c(\D_I[6]_dup_5 ),
    .d(\D_I[5]_dup_5 ),
    .o(add0_syn_50));
  AL_MAP_LUT4 #(
    .EQN("(D*C*~B*A)"),
    .INIT(16'h2000))
    \n1_d_b[3]_syn_1  (
    .a(add0_syn_50),
    .b(\n1_d_b[2]_syn_5 ),
    .c(\n1_d_b[2]_syn_2 ),
    .d(add0_syn_6[1]),
    .o(n1_d_b[3]));
  AL_DFF_X #(
    .INIT(1'b0))
    \n1_d_reg[0]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(CLK_I_dup_1),
    .d(n1_d_b[0]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(n1_d[0]));
  AL_DFF_X #(
    .INIT(1'b0))
    \n1_d_reg[1]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(CLK_I_dup_1),
    .d(n1_d_b[1]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(n1_d[1]));
  AL_DFF_X #(
    .INIT(1'b0))
    \n1_d_reg[2]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(CLK_I_dup_1),
    .d(n1_d_b[2]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(n1_d[2]));
  AL_DFF_X #(
    .INIT(1'b0))
    \n1_d_reg[3]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(CLK_I_dup_1),
    .d(n1_d_b[3]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(n1_d[3]));
  AL_DFF_X #(
    .INIT(1'b0))
    \n1_q_m_reg[1]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(CLK_I_dup_1),
    .d(int_n1_q_m[1]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(n1_q_m[1]));
  AL_DFF_X #(
    .INIT(1'b0))
    \n1_q_m_reg[2]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(CLK_I_dup_1),
    .d(int_n1_q_m[2]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(n1_q_m[2]));
  AL_DFF_X #(
    .INIT(1'b0))
    \n1_q_m_reg[3]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(CLK_I_dup_1),
    .d(int_n1_q_m[3]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(n1_q_m[3]));
  AL_MAP_LUT2 #(
    .EQN("(B@A)"),
    .INIT(4'h6))
    \q_m[1]_syn_1  (
    .a(\n0_q_m_b[3]_syn_13 ),
    .b(d_d[1]),
    .o(q_m[1]));
  AL_MAP_LUT2 #(
    .EQN("(B@A)"),
    .INIT(4'h6))
    \q_m[3]_syn_1  (
    .a(q_m_b_n_syn_2),
    .b(\n0_q_m_b[3]_syn_3 ),
    .o(q_m[3]));
  AL_MAP_LUT3 #(
    .EQN("(C@B@A)"),
    .INIT(8'h96))
    \q_m[7]_syn_1  (
    .a(q_m[5]),
    .b(d_d[7]),
    .c(d_d[6]),
    .o(q_m[7]));
  AL_MAP_LUT1 #(
    .EQN("(~A)"),
    .INIT(2'h1))
    q_m_b_n_syn_3 (
    .a(q_m_b_n_syn_2),
    .o(q_m_b_n));
  AL_DFF_X #(
    .INIT(1'b0))
    \q_m_d_reg[0]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(CLK_I_dup_1),
    .d(q_m_xnor[0]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(q_m_d[0]));
  AL_DFF_X #(
    .INIT(1'b0))
    \q_m_d_reg[1]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(CLK_I_dup_1),
    .d(q_m[1]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(q_m_d[1]));
  AL_DFF_X #(
    .INIT(1'b0))
    \q_m_d_reg[2]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(CLK_I_dup_1),
    .d(q_m_xnor[2]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(q_m_d[2]));
  AL_DFF_X #(
    .INIT(1'b0))
    \q_m_d_reg[3]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(CLK_I_dup_1),
    .d(q_m[3]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(q_m_d[3]));
  AL_DFF_X #(
    .INIT(1'b0))
    \q_m_d_reg[4]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(CLK_I_dup_1),
    .d(q_m_xnor[4]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(q_m_d[4]));
  AL_DFF_X #(
    .INIT(1'b0))
    \q_m_d_reg[5]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(CLK_I_dup_1),
    .d(q_m[5]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(q_m_d[5]));
  AL_DFF_X #(
    .INIT(1'b0))
    \q_m_d_reg[6]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(CLK_I_dup_1),
    .d(q_m_xnor[6]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(q_m_d[6]));
  AL_DFF_X #(
    .INIT(1'b0))
    \q_m_d_reg[7]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(CLK_I_dup_1),
    .d(q_m[7]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(q_m_d[7]));
  AL_DFF_X #(
    .INIT(1'b0))
    \q_m_d_reg[8]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(CLK_I_dup_1),
    .d(q_m_b_n_syn_2),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(q_m_d[8]));
  AL_MAP_LUT3 #(
    .EQN("(C@B@A)"),
    .INIT(8'h96))
    \q_m_xnor[6]_syn_1  (
    .a(\n0_q_m_b[3]_syn_3 ),
    .b(\n0_q_m_b[3]_syn_6 ),
    .c(d_d[6]),
    .o(q_m_xnor[6]));
  AL_MAP_LUT4 #(
    .EQN("~(~B*~((D@A))*~(C)+~B*(D@A)*~(C)+~(~B)*(D@A)*C+~B*(D@A)*C)"),
    .INIT(16'hac5c))
    \q_out[0]_syn_1  (
    .a(\q_out_b1[8]_syn_2 ),
    .b(c0_dd),
    .c(de_dd),
    .d(q_m_d[0]),
    .o(q_out[0]));
  AL_MAP_LUT4 #(
    .EQN("~(~B*~((D@A))*~(C)+~B*(D@A)*~(C)+~(~B)*(D@A)*C+~B*(D@A)*C)"),
    .INIT(16'hac5c))
    \q_out[1]_syn_1  (
    .a(\q_out_b1[8]_syn_2 ),
    .b(c0_dd),
    .c(de_dd),
    .d(q_m_d[1]),
    .o(q_out[1]));
  AL_MAP_LUT4 #(
    .EQN("~(B*~((D@A))*~(C)+B*(D@A)*~(C)+~(B)*(D@A)*C+B*(D@A)*C)"),
    .INIT(16'ha353))
    \q_out[2]_syn_1  (
    .a(\q_out_b1[8]_syn_2 ),
    .b(c0_dd),
    .c(de_dd),
    .d(q_m_d[2]),
    .o(q_out[2]));
  AL_MAP_LUT4 #(
    .EQN("~(~B*~((D@A))*~(C)+~B*(D@A)*~(C)+~(~B)*(D@A)*C+~B*(D@A)*C)"),
    .INIT(16'hac5c))
    \q_out[3]_syn_1  (
    .a(\q_out_b1[8]_syn_2 ),
    .b(c0_dd),
    .c(de_dd),
    .d(q_m_d[3]),
    .o(q_out[3]));
  AL_MAP_LUT4 #(
    .EQN("~(B*~((D@A))*~(C)+B*(D@A)*~(C)+~(B)*(D@A)*C+B*(D@A)*C)"),
    .INIT(16'ha353))
    \q_out[4]_syn_1  (
    .a(\q_out_b1[8]_syn_2 ),
    .b(c0_dd),
    .c(de_dd),
    .d(q_m_d[4]),
    .o(q_out[4]));
  AL_MAP_LUT4 #(
    .EQN("~(~B*~((D@A))*~(C)+~B*(D@A)*~(C)+~(~B)*(D@A)*C+~B*(D@A)*C)"),
    .INIT(16'hac5c))
    \q_out[5]_syn_1  (
    .a(\q_out_b1[8]_syn_2 ),
    .b(c0_dd),
    .c(de_dd),
    .d(q_m_d[5]),
    .o(q_out[5]));
  AL_MAP_LUT4 #(
    .EQN("~(B*~((D@A))*~(C)+B*(D@A)*~(C)+~(B)*(D@A)*C+B*(D@A)*C)"),
    .INIT(16'ha353))
    \q_out[6]_syn_1  (
    .a(\q_out_b1[8]_syn_2 ),
    .b(c0_dd),
    .c(de_dd),
    .d(q_m_d[6]),
    .o(q_out[6]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(~C*~A))"),
    .INIT(8'hc8))
    \q_out[7]_syn_1  (
    .a(cond_balanced_syn_2),
    .b(\cnt_t_1_reg[2]_syn_10 ),
    .c(q_m_d[8]),
    .o(\q_out_b1[8]_syn_2 ));
  AL_MAP_LUT4 #(
    .EQN("~(~B*~((D@A))*~(C)+~B*(D@A)*~(C)+~(~B)*(D@A)*C+~B*(D@A)*C)"),
    .INIT(16'hac5c))
    \q_out[7]_syn_2  (
    .a(\q_out_b1[8]_syn_2 ),
    .b(c0_dd),
    .c(de_dd),
    .d(q_m_d[7]),
    .o(q_out[7]));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C)*~(B)+~A*C*~(B)+~(~A)*C*B+~A*C*B)"),
    .INIT(8'hd1))
    \q_out[8]_syn_1  (
    .a(c0_dd),
    .b(de_dd),
    .c(q_m_d[8]),
    .o(q_out[8]));
  AL_MAP_LUT4 #(
    .EQN("~((C@B)*~(A)*~(D)+(C@B)*A*~(D)+~((C@B))*A*D+(C@B)*A*D)"),
    .INIT(16'h55c3))
    \q_out[9]_syn_1  (
    .a(\q_out_b1[8]_syn_2 ),
    .b(c0_dd),
    .c(c1_dd),
    .d(de_dd),
    .o(q_out[9]));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB_CARRY"))
    sub2_syn_5 (
    .a(q_m_b_n),
    .o({sub2_syn_23,open_n418}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    sub2_syn_6 (
    .a(cnt_t_1[1]),
    .b(eq1_syn_15),
    .c(sub2_syn_23),
    .o({sub2_syn_24,cnt_t_b7[1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    sub2_syn_7 (
    .a(cnt_t_1[2]),
    .b(dc_bias[2]),
    .c(sub2_syn_24),
    .o({sub2_syn_25,cnt_t_b7[2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    sub2_syn_8 (
    .a(cnt_t_1[3]),
    .b(dc_bias[3]),
    .c(sub2_syn_25),
    .o({sub2_syn_26,cnt_t_b7[3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    sub2_syn_9 (
    .a(cnt_t_1[4]),
    .b(cond_not_balanced_n4),
    .c(sub2_syn_26),
    .o({open_n419,cnt_t_b7[4]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB_CARRY"))
    sub4_syn_3 (
    .a(1'b0),
    .o({sub4_syn_21,open_n422}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    sub4_syn_4 (
    .a(cnt_t_1[1]),
    .b(eq1_syn_15),
    .c(sub4_syn_21),
    .o({sub4_syn_22,cnt_t_b5[1]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    sub4_syn_5 (
    .a(cnt_t_1[2]),
    .b(dc_bias[2]),
    .c(sub4_syn_22),
    .o({sub4_syn_23,cnt_t_b5[2]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    sub4_syn_6 (
    .a(cnt_t_1[3]),
    .b(dc_bias[3]),
    .c(sub4_syn_23),
    .o({sub4_syn_24,cnt_t_b5[3]}));
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    sub4_syn_7 (
    .a(cnt_t_1[4]),
    .b(cond_not_balanced_n4),
    .c(sub4_syn_24),
    .o({open_n423,cnt_t_b5[4]}));

endmodule 



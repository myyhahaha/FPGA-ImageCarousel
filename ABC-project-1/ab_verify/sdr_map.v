// Verilog netlist created by Tang Dynasty v6.2.168116
// Tue Oct 27 23:40:45 2026

`timescale 1ns / 1ps
module sdr_as_ram  // RTL_1/enc_file/sdr_as_ram.enc.v(12)
  (
  App_rd_addr,
  App_rd_en,
  App_ref_req,
  App_wr_addr,
  App_wr_din,
  App_wr_dm,
  App_wr_en,
  Rst,
  Sdr_clk,
  Sdr_clk_sft,
  SDRAM_CLK,
  SDR_ADDR,
  SDR_BA,
  SDR_CAS,
  SDR_DM,
  SDR_RAS,
  SDR_WE,
  Sdr_busy,
  Sdr_init_done,
  Sdr_init_ref_vld,
  Sdr_rd_dout,
  Sdr_rd_en,
  SDR_DQ
  );

  input [20:0] App_rd_addr;  // RTL_1/enc_file/sdr_as_ram.enc.v(30)
  input App_rd_en;  // RTL_1/enc_file/sdr_as_ram.enc.v(29)
  input App_ref_req;  // RTL_1/enc_file/sdr_as_ram.enc.v(22)
  input [20:0] App_wr_addr;  // RTL_1/enc_file/sdr_as_ram.enc.v(25)
  input [31:0] App_wr_din;  // RTL_1/enc_file/sdr_as_ram.enc.v(27)
  input [3:0] App_wr_dm;  // RTL_1/enc_file/sdr_as_ram.enc.v(26)
  input App_wr_en;  // RTL_1/enc_file/sdr_as_ram.enc.v(24)
  input Rst;  // RTL_1/enc_file/sdr_as_ram.enc.v(16)
  input Sdr_clk;  // RTL_1/enc_file/sdr_as_ram.enc.v(14)
  input Sdr_clk_sft;  // RTL_1/enc_file/sdr_as_ram.enc.v(15)
  output SDRAM_CLK /* synthesis keep=true */ ;  // RTL_1/enc_file/sdr_as_ram.enc.v(35)
  output [10:0] SDR_ADDR;  // RTL_1/enc_file/sdr_as_ram.enc.v(40)
  output [1:0] SDR_BA;  // RTL_1/enc_file/sdr_as_ram.enc.v(39)
  output SDR_CAS;  // RTL_1/enc_file/sdr_as_ram.enc.v(37)
  output [3:0] SDR_DM;  // RTL_1/enc_file/sdr_as_ram.enc.v(41)
  output SDR_RAS;  // RTL_1/enc_file/sdr_as_ram.enc.v(36)
  output SDR_WE;  // RTL_1/enc_file/sdr_as_ram.enc.v(38)
  output Sdr_busy;  // RTL_1/enc_file/sdr_as_ram.enc.v(20)
  output Sdr_init_done;  // RTL_1/enc_file/sdr_as_ram.enc.v(18)
  output Sdr_init_ref_vld;  // RTL_1/enc_file/sdr_as_ram.enc.v(19)
  output [31:0] Sdr_rd_dout /* synthesis keep=true */ ;  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  output Sdr_rd_en;  // RTL_1/enc_file/sdr_as_ram.enc.v(31)
  inout [31:0] SDR_DQ;  // RTL_1/enc_file/sdr_as_ram.enc.v(42)

  // parameter self_refresh_open = 1;
  wire [11:0] \u1_init_ref/Sdr_init_ref_addr ;  // RTL_1/enc_file/sdr_init_ref.enc.v(34)
  wire [17:0] \u1_init_ref/pwr_200ms_cnt ;  // RTL_1/enc_file/sdr_init_ref.enc.v(38)
  wire [17:0] \u1_init_ref/pwr_200ms_cnt_b1 ;
  wire [17:0] \u1_init_ref/pwr_200ms_cnt_b3 ;
  wire [31:0] \u1_init_ref/sdr_init_cnt ;  // RTL_1/enc_file/sdr_init_ref.enc.v(42)
  wire [19:0] \u1_init_ref/sdr_ref_ack_sft ;  // RTL_1/enc_file/sdr_init_ref.enc.v(45)
  wire [10:0] \u2_wrrd/SDR_ADDR_b ;
  wire [31:0] \u2_wrrd/Sdr_rd_dout  /* synthesis keep=true */ ;
  wire [1:0] \u2_wrrd/active_ba ;
  wire [1:0] \u2_wrrd/active_ba_b1 ;
  wire [7:0] \u2_wrrd/active_col ;
  wire [7:0] \u2_wrrd/active_col_b1 ;
  wire [10:0] \u2_wrrd/active_row ;
  wire [10:0] \u2_wrrd/active_row_b1 ;
  wire [10:0] \u2_wrrd/addr ;
  wire [10:0] \u2_wrrd/addr_b ;
  wire [20:0] \u2_wrrd/app_rd_addr_1d ;
  wire [20:0] \u2_wrrd/app_rd_addr_2d ;
  wire [20:0] \u2_wrrd/app_rd_addr_3d ;
  wire [20:0] \u2_wrrd/app_rd_addr_4d ;
  wire [10:0] \u2_wrrd/app_rd_en_sft ;
  wire [20:0] \u2_wrrd/app_wr_addr_1d ;
  wire [20:0] \u2_wrrd/app_wr_addr_2d ;
  wire [20:0] \u2_wrrd/app_wr_addr_3d ;
  wire [20:0] \u2_wrrd/app_wr_addr_4d ;
  wire [31:0] \u2_wrrd/app_wr_din_1d ;
  wire [31:0] \u2_wrrd/app_wr_din_2d ;
  wire [31:0] \u2_wrrd/app_wr_din_3d ;
  wire [31:0] \u2_wrrd/app_wr_din_4d ;
  wire [31:0] \u2_wrrd/app_wr_din_5d ;
  wire [31:0] \u2_wrrd/app_wr_din_6d ;
  wire [3:0] \u2_wrrd/app_wr_dm_1d ;
  wire [3:0] \u2_wrrd/app_wr_dm_2d ;
  wire [3:0] \u2_wrrd/app_wr_dm_3d ;
  wire [3:0] \u2_wrrd/app_wr_dm_4d ;
  wire [3:0] \u2_wrrd/app_wr_dm_5d ;
  wire [3:0] \u2_wrrd/app_wr_dm_6d ;
  wire [7:0] \u2_wrrd/app_wr_en_sft ;
  wire [1:0] \u2_wrrd/ba ;
  wire [1:0] \u2_wrrd/cnt4 ;
  wire [7:0] \u2_wrrd/mux1_syn_2 ;
  wire [1:0] \u2_wrrd/mux21_syn_2 ;
  wire [10:0] \u2_wrrd/mux4_syn_2 ;
  wire [2:0] \u2_wrrd/mux7_syn_2 ;
  wire [2:0] \u2_wrrd/mux9_syn_1 ;
  wire [2:0] \u2_wrrd/sel2_syn_1 ;
  wire [2:0] \u2_wrrd/state_reg_syn_1 ;
  wire App_rd_en_dup_5;  // RTL_1/enc_file/sdr_as_ram.enc.v(29)
  wire App_ref_req_dup_1;  // RTL_1/enc_file/sdr_as_ram.enc.v(22)
  wire App_wr_en_dup_5;  // RTL_1/enc_file/sdr_as_ram.enc.v(24)
  wire Rst_dup_175;  // RTL_1/enc_file/sdr_as_ram.enc.v(16)
  wire SDRAM_CLK_dup_3 /* synthesis keep=true */ ;  // RTL_1/enc_file/sdr_as_ram.enc.v(35)
  wire \SDR_DQ[31]_dup_1 ;  // RTL_1/enc_file/sdr_as_ram.enc.v(42)
  wire \SDR_DQ[30]_dup_1 ;  // RTL_1/enc_file/sdr_as_ram.enc.v(42)
  wire \SDR_DQ[29]_dup_1 ;  // RTL_1/enc_file/sdr_as_ram.enc.v(42)
  wire \SDR_DQ[28]_dup_1 ;  // RTL_1/enc_file/sdr_as_ram.enc.v(42)
  wire \SDR_DQ[27]_dup_1 ;  // RTL_1/enc_file/sdr_as_ram.enc.v(42)
  wire \SDR_DQ[26]_dup_1 ;  // RTL_1/enc_file/sdr_as_ram.enc.v(42)
  wire \SDR_DQ[25]_dup_1 ;  // RTL_1/enc_file/sdr_as_ram.enc.v(42)
  wire \SDR_DQ[24]_dup_1 ;  // RTL_1/enc_file/sdr_as_ram.enc.v(42)
  wire \SDR_DQ[23]_dup_1 ;  // RTL_1/enc_file/sdr_as_ram.enc.v(42)
  wire \SDR_DQ[22]_dup_1 ;  // RTL_1/enc_file/sdr_as_ram.enc.v(42)
  wire \SDR_DQ[21]_dup_1 ;  // RTL_1/enc_file/sdr_as_ram.enc.v(42)
  wire \SDR_DQ[20]_dup_1 ;  // RTL_1/enc_file/sdr_as_ram.enc.v(42)
  wire \SDR_DQ[19]_dup_1 ;  // RTL_1/enc_file/sdr_as_ram.enc.v(42)
  wire \SDR_DQ[18]_dup_1 ;  // RTL_1/enc_file/sdr_as_ram.enc.v(42)
  wire \SDR_DQ[17]_dup_1 ;  // RTL_1/enc_file/sdr_as_ram.enc.v(42)
  wire \SDR_DQ[16]_dup_1 ;  // RTL_1/enc_file/sdr_as_ram.enc.v(42)
  wire \SDR_DQ[15]_dup_1 ;  // RTL_1/enc_file/sdr_as_ram.enc.v(42)
  wire \SDR_DQ[14]_dup_1 ;  // RTL_1/enc_file/sdr_as_ram.enc.v(42)
  wire \SDR_DQ[13]_dup_1 ;  // RTL_1/enc_file/sdr_as_ram.enc.v(42)
  wire \SDR_DQ[12]_dup_1 ;  // RTL_1/enc_file/sdr_as_ram.enc.v(42)
  wire \SDR_DQ[11]_dup_1 ;  // RTL_1/enc_file/sdr_as_ram.enc.v(42)
  wire \SDR_DQ[10]_dup_1 ;  // RTL_1/enc_file/sdr_as_ram.enc.v(42)
  wire \SDR_DQ[9]_dup_1 ;  // RTL_1/enc_file/sdr_as_ram.enc.v(42)
  wire \SDR_DQ[8]_dup_1 ;  // RTL_1/enc_file/sdr_as_ram.enc.v(42)
  wire \SDR_DQ[7]_dup_1 ;  // RTL_1/enc_file/sdr_as_ram.enc.v(42)
  wire \SDR_DQ[6]_dup_1 ;  // RTL_1/enc_file/sdr_as_ram.enc.v(42)
  wire \SDR_DQ[5]_dup_1 ;  // RTL_1/enc_file/sdr_as_ram.enc.v(42)
  wire \SDR_DQ[4]_dup_1 ;  // RTL_1/enc_file/sdr_as_ram.enc.v(42)
  wire \SDR_DQ[3]_dup_1 ;  // RTL_1/enc_file/sdr_as_ram.enc.v(42)
  wire \SDR_DQ[2]_dup_1 ;  // RTL_1/enc_file/sdr_as_ram.enc.v(42)
  wire \SDR_DQ[1]_dup_1 ;  // RTL_1/enc_file/sdr_as_ram.enc.v(42)
  wire \SDR_DQ[0]_dup_1 ;  // RTL_1/enc_file/sdr_as_ram.enc.v(42)
  wire Sdr_clk_dup_1;  // RTL_1/enc_file/sdr_as_ram.enc.v(14)
  wire Sdr_clk_sft_dup_1;  // RTL_1/enc_file/sdr_as_ram.enc.v(15)
  wire Sdr_init_ref_vld_dup_1;  // RTL_1/enc_file/sdr_as_ram.enc.v(19)
  wire \Sdr_rd_dout[31]_dup_3  /* synthesis keep=true */ ;  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  wire \Sdr_rd_dout[30]_dup_3  /* synthesis keep=true */ ;  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  wire \Sdr_rd_dout[29]_dup_3  /* synthesis keep=true */ ;  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  wire \Sdr_rd_dout[28]_dup_3  /* synthesis keep=true */ ;  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  wire \Sdr_rd_dout[27]_dup_3  /* synthesis keep=true */ ;  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  wire \Sdr_rd_dout[26]_dup_3  /* synthesis keep=true */ ;  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  wire \Sdr_rd_dout[25]_dup_3  /* synthesis keep=true */ ;  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  wire \Sdr_rd_dout[24]_dup_3  /* synthesis keep=true */ ;  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  wire \Sdr_rd_dout[23]_dup_3  /* synthesis keep=true */ ;  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  wire \Sdr_rd_dout[22]_dup_3  /* synthesis keep=true */ ;  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  wire \Sdr_rd_dout[21]_dup_3  /* synthesis keep=true */ ;  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  wire \Sdr_rd_dout[20]_dup_3  /* synthesis keep=true */ ;  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  wire \Sdr_rd_dout[19]_dup_3  /* synthesis keep=true */ ;  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  wire \Sdr_rd_dout[18]_dup_3  /* synthesis keep=true */ ;  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  wire \Sdr_rd_dout[17]_dup_3  /* synthesis keep=true */ ;  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  wire \Sdr_rd_dout[16]_dup_3  /* synthesis keep=true */ ;  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  wire \Sdr_rd_dout[15]_dup_3  /* synthesis keep=true */ ;  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  wire \Sdr_rd_dout[14]_dup_3  /* synthesis keep=true */ ;  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  wire \Sdr_rd_dout[13]_dup_3  /* synthesis keep=true */ ;  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  wire \Sdr_rd_dout[12]_dup_3  /* synthesis keep=true */ ;  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  wire \Sdr_rd_dout[11]_dup_3  /* synthesis keep=true */ ;  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  wire \Sdr_rd_dout[10]_dup_3  /* synthesis keep=true */ ;  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  wire \Sdr_rd_dout[9]_dup_3  /* synthesis keep=true */ ;  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  wire \Sdr_rd_dout[8]_dup_3  /* synthesis keep=true */ ;  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  wire \Sdr_rd_dout[7]_dup_3  /* synthesis keep=true */ ;  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  wire \Sdr_rd_dout[6]_dup_3  /* synthesis keep=true */ ;  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  wire \Sdr_rd_dout[5]_dup_3  /* synthesis keep=true */ ;  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  wire \Sdr_rd_dout[4]_dup_3  /* synthesis keep=true */ ;  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  wire \Sdr_rd_dout[3]_dup_3  /* synthesis keep=true */ ;  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  wire \Sdr_rd_dout[2]_dup_3  /* synthesis keep=true */ ;  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  wire \Sdr_rd_dout[1]_dup_3  /* synthesis keep=true */ ;  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  wire \Sdr_rd_dout[0]_dup_3  /* synthesis keep=true */ ;  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  wire \u1_init_ref/add1_syn_91 ;  // RTL_1/enc_file/sdr_init_ref.enc.v(61)
  wire \u1_init_ref/add1_syn_92 ;  // RTL_1/enc_file/sdr_init_ref.enc.v(61)
  wire \u1_init_ref/add1_syn_93 ;  // RTL_1/enc_file/sdr_init_ref.enc.v(61)
  wire \u1_init_ref/add1_syn_94 ;  // RTL_1/enc_file/sdr_init_ref.enc.v(61)
  wire \u1_init_ref/add1_syn_95 ;  // RTL_1/enc_file/sdr_init_ref.enc.v(61)
  wire \u1_init_ref/add1_syn_96 ;  // RTL_1/enc_file/sdr_init_ref.enc.v(61)
  wire \u1_init_ref/add1_syn_97 ;  // RTL_1/enc_file/sdr_init_ref.enc.v(61)
  wire \u1_init_ref/add1_syn_98 ;  // RTL_1/enc_file/sdr_init_ref.enc.v(61)
  wire \u1_init_ref/add1_syn_99 ;  // RTL_1/enc_file/sdr_init_ref.enc.v(61)
  wire \u1_init_ref/add1_syn_100 ;  // RTL_1/enc_file/sdr_init_ref.enc.v(61)
  wire \u1_init_ref/add1_syn_101 ;  // RTL_1/enc_file/sdr_init_ref.enc.v(61)
  wire \u1_init_ref/add1_syn_102 ;  // RTL_1/enc_file/sdr_init_ref.enc.v(61)
  wire \u1_init_ref/add1_syn_103 ;  // RTL_1/enc_file/sdr_init_ref.enc.v(61)
  wire \u1_init_ref/add1_syn_104 ;  // RTL_1/enc_file/sdr_init_ref.enc.v(61)
  wire \u1_init_ref/add1_syn_105 ;  // RTL_1/enc_file/sdr_init_ref.enc.v(61)
  wire \u1_init_ref/add1_syn_106 ;  // RTL_1/enc_file/sdr_init_ref.enc.v(61)
  wire \u1_init_ref/add1_syn_107 ;  // RTL_1/enc_file/sdr_init_ref.enc.v(61)
  wire \u1_init_ref/add1_syn_108 ;  // RTL_1/enc_file/sdr_init_ref.enc.v(61)
  wire \u1_init_ref/cas_reg_syn_3 ;
  wire \u1_init_ref/cas_reg_syn_5 ;
  wire \u1_init_ref/init_vld_reg_syn_5 ;  // RTL_1/enc_file/sdr_init_ref.enc.v(77)
  wire \u1_init_ref/ras_reg_syn_3 ;
  wire \u1_init_ref/ras_reg_syn_5 ;
  wire \u1_init_ref/ras_reg_syn_7 ;
  wire \u1_init_ref/ras_reg_syn_9 ;
  wire \u1_init_ref/ref_vld_reg_syn_5 ;  // RTL_1/enc_file/sdr_init_ref.enc.v(121)
  wire \u1_init_ref/ref_vld_reg_syn_7 ;  // RTL_1/enc_file/sdr_init_ref.enc.v(121)
  wire \u1_init_ref/we_reg_syn_3 ;
  wire \u1_init_ref/pwr_200ms_cnt[0]_syn_2 ;  // RTL_1/enc_file/sdr_init_ref.enc.v(38)
  wire \u1_init_ref/Sdr_init_ref_cas ;  // RTL_1/enc_file/sdr_init_ref.enc.v(31)
  wire \u1_init_ref/Sdr_init_ref_ras ;  // RTL_1/enc_file/sdr_init_ref.enc.v(30)
  wire \u1_init_ref/Sdr_init_ref_we ;  // RTL_1/enc_file/sdr_init_ref.enc.v(32)
  wire \u1_init_ref/Sdr_ref_ack ;  // RTL_1/enc_file/sdr_init_ref.enc.v(26)
  wire \u1_init_ref/init_done_n2 ;
  wire \u1_init_ref/init_vld ;  // RTL_1/enc_file/sdr_init_ref.enc.v(43)
  wire \u1_init_ref/power_up_200ms_1d ;  // RTL_1/enc_file/sdr_init_ref.enc.v(39)
  wire \u1_init_ref/power_up_200ms_2d ;  // RTL_1/enc_file/sdr_init_ref.enc.v(39)
  wire \u1_init_ref/power_up_en ;  // RTL_1/enc_file/sdr_init_ref.enc.v(39)
  wire \u1_init_ref/power_up_en_n ;
  wire \u1_init_ref/ref_vld ;  // RTL_1/enc_file/sdr_init_ref.enc.v(46)
  wire \u1_init_ref/sdr_init_en ;  // RTL_1/enc_file/sdr_init_ref.enc.v(41)
  wire \u2_wrrd/active_en_reg_syn_3 ;
  wire \u2_wrrd/cas_reg_syn_3 ;
  wire \u2_wrrd/col_en_reg_syn_3 ;
  wire \u2_wrrd/mux1_syn_72 ;
  wire \u2_wrrd/ref_ack_reg_syn_3 ;
  wire \u2_wrrd/ref_vld_reg_syn_5 ;
  wire \u2_wrrd/rw_vld_reg_syn_5 ;
  wire \u2_wrrd/sdr_t_reg_syn_5 ;
  wire \u2_wrrd/sdr_t_reg_syn_7 ;
  wire \u2_wrrd/sel2_syn_93 ;
  wire \u2_wrrd/sel2_syn_96 ;
  wire \u2_wrrd/sel2_syn_98 ;
  wire \u2_wrrd/we_reg_syn_3 ;
  wire \u2_wrrd/Sdr_rd_dout[31]_syn_3 ;
  wire \u2_wrrd/Sdr_rd_dout[31]_syn_4 ;
  wire \u2_wrrd/Sdr_rd_dout[30]_syn_3 ;
  wire \u2_wrrd/Sdr_rd_dout[30]_syn_4 ;
  wire \u2_wrrd/Sdr_rd_dout[29]_syn_3 ;
  wire \u2_wrrd/Sdr_rd_dout[29]_syn_4 ;
  wire \u2_wrrd/Sdr_rd_dout[28]_syn_3 ;
  wire \u2_wrrd/Sdr_rd_dout[28]_syn_4 ;
  wire \u2_wrrd/Sdr_rd_dout[27]_syn_3 ;
  wire \u2_wrrd/Sdr_rd_dout[27]_syn_4 ;
  wire \u2_wrrd/Sdr_rd_dout[26]_syn_3 ;
  wire \u2_wrrd/Sdr_rd_dout[26]_syn_4 ;
  wire \u2_wrrd/Sdr_rd_dout[25]_syn_3 ;
  wire \u2_wrrd/Sdr_rd_dout[25]_syn_4 ;
  wire \u2_wrrd/Sdr_rd_dout[24]_syn_3 ;
  wire \u2_wrrd/Sdr_rd_dout[24]_syn_4 ;
  wire \u2_wrrd/Sdr_rd_dout[23]_syn_3 ;
  wire \u2_wrrd/Sdr_rd_dout[23]_syn_4 ;
  wire \u2_wrrd/Sdr_rd_dout[22]_syn_3 ;
  wire \u2_wrrd/Sdr_rd_dout[22]_syn_4 ;
  wire \u2_wrrd/Sdr_rd_dout[21]_syn_3 ;
  wire \u2_wrrd/Sdr_rd_dout[21]_syn_4 ;
  wire \u2_wrrd/Sdr_rd_dout[20]_syn_3 ;
  wire \u2_wrrd/Sdr_rd_dout[20]_syn_4 ;
  wire \u2_wrrd/Sdr_rd_dout[19]_syn_3 ;
  wire \u2_wrrd/Sdr_rd_dout[19]_syn_4 ;
  wire \u2_wrrd/Sdr_rd_dout[18]_syn_3 ;
  wire \u2_wrrd/Sdr_rd_dout[18]_syn_4 ;
  wire \u2_wrrd/Sdr_rd_dout[17]_syn_3 ;
  wire \u2_wrrd/Sdr_rd_dout[17]_syn_4 ;
  wire \u2_wrrd/Sdr_rd_dout[16]_syn_3 ;
  wire \u2_wrrd/Sdr_rd_dout[16]_syn_4 ;
  wire \u2_wrrd/Sdr_rd_dout[15]_syn_3 ;
  wire \u2_wrrd/Sdr_rd_dout[15]_syn_4 ;
  wire \u2_wrrd/Sdr_rd_dout[14]_syn_3 ;
  wire \u2_wrrd/Sdr_rd_dout[14]_syn_4 ;
  wire \u2_wrrd/Sdr_rd_dout[13]_syn_3 ;
  wire \u2_wrrd/Sdr_rd_dout[13]_syn_4 ;
  wire \u2_wrrd/Sdr_rd_dout[12]_syn_3 ;
  wire \u2_wrrd/Sdr_rd_dout[12]_syn_4 ;
  wire \u2_wrrd/Sdr_rd_dout[11]_syn_3 ;
  wire \u2_wrrd/Sdr_rd_dout[11]_syn_4 ;
  wire \u2_wrrd/Sdr_rd_dout[10]_syn_3 ;
  wire \u2_wrrd/Sdr_rd_dout[10]_syn_4 ;
  wire \u2_wrrd/Sdr_rd_dout[9]_syn_3 ;
  wire \u2_wrrd/Sdr_rd_dout[9]_syn_4 ;
  wire \u2_wrrd/Sdr_rd_dout[8]_syn_3 ;
  wire \u2_wrrd/Sdr_rd_dout[8]_syn_4 ;
  wire \u2_wrrd/Sdr_rd_dout[7]_syn_3 ;
  wire \u2_wrrd/Sdr_rd_dout[7]_syn_4 ;
  wire \u2_wrrd/Sdr_rd_dout[6]_syn_3 ;
  wire \u2_wrrd/Sdr_rd_dout[6]_syn_4 ;
  wire \u2_wrrd/Sdr_rd_dout[5]_syn_3 ;
  wire \u2_wrrd/Sdr_rd_dout[5]_syn_4 ;
  wire \u2_wrrd/Sdr_rd_dout[4]_syn_3 ;
  wire \u2_wrrd/Sdr_rd_dout[4]_syn_4 ;
  wire \u2_wrrd/Sdr_rd_dout[3]_syn_3 ;
  wire \u2_wrrd/Sdr_rd_dout[3]_syn_4 ;
  wire \u2_wrrd/Sdr_rd_dout[2]_syn_3 ;
  wire \u2_wrrd/Sdr_rd_dout[2]_syn_4 ;
  wire \u2_wrrd/Sdr_rd_dout[1]_syn_3 ;
  wire \u2_wrrd/Sdr_rd_dout[1]_syn_4 ;
  wire \u2_wrrd/Sdr_rd_dout[0]_syn_3 ;
  wire \u2_wrrd/Sdr_rd_dout[0]_syn_4 ;
  wire \u2_wrrd/Sdr_ref_req  /* synthesis keep=true */ ;
  wire \u2_wrrd/Sdr_ref_req_syn_4 ;
  wire \u2_wrrd/active_col_b1[6]_syn_2 ;
  wire \u2_wrrd/active_row_b1[9]_syn_2 ;
  wire \u2_wrrd/SDR_CAS_n ;
  wire \u2_wrrd/SDR_RAS_n ;
  wire \u2_wrrd/SDR_WE_n ;
  wire \u2_wrrd/Sdr_busy_n4 ;
  wire \u2_wrrd/Sdr_ref_ack_n ;
  wire \u2_wrrd/active_en ;
  wire \u2_wrrd/active_en_syn_2 ;
  wire \u2_wrrd/cas ;
  wire \u2_wrrd/col_en ;
  wire \u2_wrrd/init_ref_vld_1d ;
  wire \u2_wrrd/ras ;
  wire \u2_wrrd/ref_ack ;
  wire \u2_wrrd/ref_over ;
  wire \u2_wrrd/ref_over_n ;
  wire \u2_wrrd/ref_vld ;
  wire \u2_wrrd/rw_vld ;
  wire \u2_wrrd/rw_vld_1d ;
  wire \u2_wrrd/sdr_op_over ;
  wire \u2_wrrd/sdr_op_over_n ;
  wire \u2_wrrd/sdr_t ;
  wire \u2_wrrd/we ;
  wire \u2_wrrd/wrrd_ref_ack ;
  wire \u1_init_ref/ad_reg[1]_syn_4 ;
  wire \u1_init_ref/ad_reg[10]_syn_4 ;
  wire \u2_wrrd/addr_reg[8]_syn_2 ;
  wire \u2_wrrd/addr_reg[9]_syn_2 ;
  wire \u2_wrrd/ba_reg[0]_syn_2 ;
  wire \u2_wrrd/ba_reg[1]_syn_2 ;
  wire \u2_wrrd/cnt4_reg[0]_syn_2 ;
  wire \u2_wrrd/cnt4_reg[1]_syn_2 ;

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
    \App_rd_addr[0]_syn_6  (
    .ipad(App_rd_addr[0]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n11,open_n12,open_n13,\u2_wrrd/app_rd_addr_1d [0]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(30)
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
    \App_rd_addr[10]_syn_6  (
    .ipad(App_rd_addr[10]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n27,open_n28,open_n29,\u2_wrrd/app_rd_addr_1d [10]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(30)
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
    \App_rd_addr[11]_syn_6  (
    .ipad(App_rd_addr[11]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n43,open_n44,open_n45,\u2_wrrd/app_rd_addr_1d [11]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(30)
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
    \App_rd_addr[12]_syn_6  (
    .ipad(App_rd_addr[12]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n59,open_n60,open_n61,\u2_wrrd/app_rd_addr_1d [12]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(30)
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
    \App_rd_addr[13]_syn_6  (
    .ipad(App_rd_addr[13]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n75,open_n76,open_n77,\u2_wrrd/app_rd_addr_1d [13]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(30)
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
    \App_rd_addr[14]_syn_6  (
    .ipad(App_rd_addr[14]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n91,open_n92,open_n93,\u2_wrrd/app_rd_addr_1d [14]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(30)
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
    \App_rd_addr[15]_syn_6  (
    .ipad(App_rd_addr[15]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n107,open_n108,open_n109,\u2_wrrd/app_rd_addr_1d [15]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(30)
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
    \App_rd_addr[16]_syn_6  (
    .ipad(App_rd_addr[16]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n123,open_n124,open_n125,\u2_wrrd/app_rd_addr_1d [16]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(30)
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
    \App_rd_addr[17]_syn_6  (
    .ipad(App_rd_addr[17]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n139,open_n140,open_n141,\u2_wrrd/app_rd_addr_1d [17]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(30)
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
    \App_rd_addr[18]_syn_6  (
    .ipad(App_rd_addr[18]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n155,open_n156,open_n157,\u2_wrrd/app_rd_addr_1d [18]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(30)
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
    \App_rd_addr[19]_syn_6  (
    .ipad(App_rd_addr[19]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n171,open_n172,open_n173,\u2_wrrd/app_rd_addr_1d [19]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(30)
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
    \App_rd_addr[1]_syn_6  (
    .ipad(App_rd_addr[1]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n187,open_n188,open_n189,\u2_wrrd/app_rd_addr_1d [1]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(30)
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
    \App_rd_addr[20]_syn_6  (
    .ipad(App_rd_addr[20]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n203,open_n204,open_n205,\u2_wrrd/app_rd_addr_1d [20]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(30)
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
    \App_rd_addr[2]_syn_6  (
    .ipad(App_rd_addr[2]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n219,open_n220,open_n221,\u2_wrrd/app_rd_addr_1d [2]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(30)
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
    \App_rd_addr[3]_syn_6  (
    .ipad(App_rd_addr[3]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n235,open_n236,open_n237,\u2_wrrd/app_rd_addr_1d [3]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(30)
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
    \App_rd_addr[4]_syn_6  (
    .ipad(App_rd_addr[4]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n251,open_n252,open_n253,\u2_wrrd/app_rd_addr_1d [4]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(30)
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
    \App_rd_addr[5]_syn_6  (
    .ipad(App_rd_addr[5]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n267,open_n268,open_n269,\u2_wrrd/app_rd_addr_1d [5]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(30)
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
    \App_rd_addr[6]_syn_6  (
    .ipad(App_rd_addr[6]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n283,open_n284,open_n285,\u2_wrrd/app_rd_addr_1d [6]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(30)
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
    \App_rd_addr[7]_syn_6  (
    .ipad(App_rd_addr[7]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n299,open_n300,open_n301,\u2_wrrd/app_rd_addr_1d [7]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(30)
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
    \App_rd_addr[8]_syn_6  (
    .ipad(App_rd_addr[8]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n315,open_n316,open_n317,\u2_wrrd/app_rd_addr_1d [8]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(30)
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
    \App_rd_addr[9]_syn_6  (
    .ipad(App_rd_addr[9]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n331,open_n332,open_n333,\u2_wrrd/app_rd_addr_1d [9]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(30)
  EG_PHY_PAD #(
    //.HYSTERESIS("OFF"),
    //.PCICLAMP("OFF"),
    .IDDRMODE("OFF"),
    .IDDRPIPEMODE("NONE"),
    .INCEMUX("1"),
    .INPCLKMUX("CLK"),
    .INRSTMUX("RST"),
    .IN_DFFMODE("FF"),
    .IN_REGSET("RESET"),
    .IOTYPE("LVCMOS25"),
    .MODE("IN"),
    .SRMODE("SYNC"),
    .TSMUX("1"))
    App_rd_en_syn_6 (
    .ipad(App_rd_en),
    .ipclk(Sdr_clk_dup_1),
    .rst(Rst_dup_175),
    .di(App_rd_en_dup_5),
    .diq({open_n345,open_n346,open_n347,\u2_wrrd/app_rd_en_sft [0]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(29)
  EG_PHY_PAD #(
    //.HYSTERESIS("OFF"),
    //.PCICLAMP("OFF"),
    .IOTYPE("LVCMOS25"),
    .MODE("IN"),
    .TSMUX("1"))
    App_ref_req_syn_2 (
    .ipad(App_ref_req),
    .di(App_ref_req_dup_1));  // RTL_1/enc_file/sdr_as_ram.enc.v(22)
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
    \App_wr_addr[0]_syn_6  (
    .ipad(App_wr_addr[0]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n378,open_n379,open_n380,\u2_wrrd/app_wr_addr_1d [0]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(25)
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
    \App_wr_addr[10]_syn_6  (
    .ipad(App_wr_addr[10]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n394,open_n395,open_n396,\u2_wrrd/app_wr_addr_1d [10]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(25)
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
    \App_wr_addr[11]_syn_6  (
    .ipad(App_wr_addr[11]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n410,open_n411,open_n412,\u2_wrrd/app_wr_addr_1d [11]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(25)
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
    \App_wr_addr[12]_syn_6  (
    .ipad(App_wr_addr[12]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n426,open_n427,open_n428,\u2_wrrd/app_wr_addr_1d [12]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(25)
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
    \App_wr_addr[13]_syn_6  (
    .ipad(App_wr_addr[13]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n442,open_n443,open_n444,\u2_wrrd/app_wr_addr_1d [13]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(25)
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
    \App_wr_addr[14]_syn_6  (
    .ipad(App_wr_addr[14]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n458,open_n459,open_n460,\u2_wrrd/app_wr_addr_1d [14]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(25)
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
    \App_wr_addr[15]_syn_6  (
    .ipad(App_wr_addr[15]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n474,open_n475,open_n476,\u2_wrrd/app_wr_addr_1d [15]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(25)
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
    \App_wr_addr[16]_syn_6  (
    .ipad(App_wr_addr[16]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n490,open_n491,open_n492,\u2_wrrd/app_wr_addr_1d [16]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(25)
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
    \App_wr_addr[17]_syn_6  (
    .ipad(App_wr_addr[17]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n506,open_n507,open_n508,\u2_wrrd/app_wr_addr_1d [17]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(25)
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
    \App_wr_addr[18]_syn_6  (
    .ipad(App_wr_addr[18]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n522,open_n523,open_n524,\u2_wrrd/app_wr_addr_1d [18]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(25)
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
    \App_wr_addr[19]_syn_6  (
    .ipad(App_wr_addr[19]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n538,open_n539,open_n540,\u2_wrrd/app_wr_addr_1d [19]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(25)
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
    \App_wr_addr[1]_syn_6  (
    .ipad(App_wr_addr[1]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n554,open_n555,open_n556,\u2_wrrd/app_wr_addr_1d [1]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(25)
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
    \App_wr_addr[20]_syn_6  (
    .ipad(App_wr_addr[20]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n570,open_n571,open_n572,\u2_wrrd/app_wr_addr_1d [20]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(25)
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
    \App_wr_addr[2]_syn_6  (
    .ipad(App_wr_addr[2]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n586,open_n587,open_n588,\u2_wrrd/app_wr_addr_1d [2]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(25)
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
    \App_wr_addr[3]_syn_6  (
    .ipad(App_wr_addr[3]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n602,open_n603,open_n604,\u2_wrrd/app_wr_addr_1d [3]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(25)
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
    \App_wr_addr[4]_syn_6  (
    .ipad(App_wr_addr[4]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n618,open_n619,open_n620,\u2_wrrd/app_wr_addr_1d [4]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(25)
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
    \App_wr_addr[5]_syn_6  (
    .ipad(App_wr_addr[5]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n634,open_n635,open_n636,\u2_wrrd/app_wr_addr_1d [5]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(25)
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
    \App_wr_addr[6]_syn_6  (
    .ipad(App_wr_addr[6]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n650,open_n651,open_n652,\u2_wrrd/app_wr_addr_1d [6]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(25)
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
    \App_wr_addr[7]_syn_6  (
    .ipad(App_wr_addr[7]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n666,open_n667,open_n668,\u2_wrrd/app_wr_addr_1d [7]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(25)
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
    \App_wr_addr[8]_syn_6  (
    .ipad(App_wr_addr[8]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n682,open_n683,open_n684,\u2_wrrd/app_wr_addr_1d [8]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(25)
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
    \App_wr_addr[9]_syn_6  (
    .ipad(App_wr_addr[9]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n698,open_n699,open_n700,\u2_wrrd/app_wr_addr_1d [9]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(25)
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
    \App_wr_din[0]_syn_6  (
    .ipad(App_wr_din[0]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n714,open_n715,open_n716,\u2_wrrd/app_wr_din_1d [0]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(27)
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
    \App_wr_din[10]_syn_6  (
    .ipad(App_wr_din[10]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n730,open_n731,open_n732,\u2_wrrd/app_wr_din_1d [10]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(27)
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
    \App_wr_din[11]_syn_6  (
    .ipad(App_wr_din[11]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n746,open_n747,open_n748,\u2_wrrd/app_wr_din_1d [11]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(27)
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
    \App_wr_din[12]_syn_6  (
    .ipad(App_wr_din[12]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n762,open_n763,open_n764,\u2_wrrd/app_wr_din_1d [12]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(27)
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
    \App_wr_din[13]_syn_6  (
    .ipad(App_wr_din[13]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n778,open_n779,open_n780,\u2_wrrd/app_wr_din_1d [13]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(27)
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
    \App_wr_din[14]_syn_6  (
    .ipad(App_wr_din[14]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n794,open_n795,open_n796,\u2_wrrd/app_wr_din_1d [14]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(27)
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
    \App_wr_din[15]_syn_6  (
    .ipad(App_wr_din[15]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n810,open_n811,open_n812,\u2_wrrd/app_wr_din_1d [15]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(27)
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
    \App_wr_din[16]_syn_6  (
    .ipad(App_wr_din[16]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n826,open_n827,open_n828,\u2_wrrd/app_wr_din_1d [16]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(27)
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
    \App_wr_din[17]_syn_6  (
    .ipad(App_wr_din[17]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n842,open_n843,open_n844,\u2_wrrd/app_wr_din_1d [17]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(27)
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
    \App_wr_din[18]_syn_6  (
    .ipad(App_wr_din[18]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n858,open_n859,open_n860,\u2_wrrd/app_wr_din_1d [18]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(27)
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
    \App_wr_din[19]_syn_6  (
    .ipad(App_wr_din[19]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n874,open_n875,open_n876,\u2_wrrd/app_wr_din_1d [19]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(27)
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
    \App_wr_din[1]_syn_6  (
    .ipad(App_wr_din[1]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n890,open_n891,open_n892,\u2_wrrd/app_wr_din_1d [1]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(27)
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
    \App_wr_din[20]_syn_6  (
    .ipad(App_wr_din[20]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n906,open_n907,open_n908,\u2_wrrd/app_wr_din_1d [20]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(27)
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
    \App_wr_din[21]_syn_6  (
    .ipad(App_wr_din[21]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n922,open_n923,open_n924,\u2_wrrd/app_wr_din_1d [21]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(27)
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
    \App_wr_din[22]_syn_6  (
    .ipad(App_wr_din[22]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n938,open_n939,open_n940,\u2_wrrd/app_wr_din_1d [22]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(27)
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
    \App_wr_din[23]_syn_6  (
    .ipad(App_wr_din[23]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n954,open_n955,open_n956,\u2_wrrd/app_wr_din_1d [23]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(27)
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
    \App_wr_din[24]_syn_6  (
    .ipad(App_wr_din[24]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n970,open_n971,open_n972,\u2_wrrd/app_wr_din_1d [24]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(27)
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
    \App_wr_din[25]_syn_6  (
    .ipad(App_wr_din[25]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n986,open_n987,open_n988,\u2_wrrd/app_wr_din_1d [25]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(27)
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
    \App_wr_din[26]_syn_6  (
    .ipad(App_wr_din[26]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n1002,open_n1003,open_n1004,\u2_wrrd/app_wr_din_1d [26]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(27)
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
    \App_wr_din[27]_syn_6  (
    .ipad(App_wr_din[27]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n1018,open_n1019,open_n1020,\u2_wrrd/app_wr_din_1d [27]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(27)
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
    \App_wr_din[28]_syn_6  (
    .ipad(App_wr_din[28]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n1034,open_n1035,open_n1036,\u2_wrrd/app_wr_din_1d [28]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(27)
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
    \App_wr_din[29]_syn_6  (
    .ipad(App_wr_din[29]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n1050,open_n1051,open_n1052,\u2_wrrd/app_wr_din_1d [29]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(27)
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
    \App_wr_din[2]_syn_6  (
    .ipad(App_wr_din[2]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n1066,open_n1067,open_n1068,\u2_wrrd/app_wr_din_1d [2]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(27)
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
    \App_wr_din[30]_syn_6  (
    .ipad(App_wr_din[30]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n1082,open_n1083,open_n1084,\u2_wrrd/app_wr_din_1d [30]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(27)
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
    \App_wr_din[31]_syn_6  (
    .ipad(App_wr_din[31]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n1098,open_n1099,open_n1100,\u2_wrrd/app_wr_din_1d [31]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(27)
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
    \App_wr_din[3]_syn_6  (
    .ipad(App_wr_din[3]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n1114,open_n1115,open_n1116,\u2_wrrd/app_wr_din_1d [3]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(27)
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
    \App_wr_din[4]_syn_6  (
    .ipad(App_wr_din[4]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n1130,open_n1131,open_n1132,\u2_wrrd/app_wr_din_1d [4]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(27)
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
    \App_wr_din[5]_syn_6  (
    .ipad(App_wr_din[5]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n1146,open_n1147,open_n1148,\u2_wrrd/app_wr_din_1d [5]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(27)
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
    \App_wr_din[6]_syn_6  (
    .ipad(App_wr_din[6]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n1162,open_n1163,open_n1164,\u2_wrrd/app_wr_din_1d [6]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(27)
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
    \App_wr_din[7]_syn_6  (
    .ipad(App_wr_din[7]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n1178,open_n1179,open_n1180,\u2_wrrd/app_wr_din_1d [7]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(27)
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
    \App_wr_din[8]_syn_6  (
    .ipad(App_wr_din[8]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n1194,open_n1195,open_n1196,\u2_wrrd/app_wr_din_1d [8]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(27)
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
    \App_wr_din[9]_syn_6  (
    .ipad(App_wr_din[9]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n1210,open_n1211,open_n1212,\u2_wrrd/app_wr_din_1d [9]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(27)
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
    \App_wr_dm[0]_syn_6  (
    .ipad(App_wr_dm[0]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n1226,open_n1227,open_n1228,\u2_wrrd/app_wr_dm_1d [0]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(26)
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
    \App_wr_dm[1]_syn_6  (
    .ipad(App_wr_dm[1]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n1242,open_n1243,open_n1244,\u2_wrrd/app_wr_dm_1d [1]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(26)
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
    \App_wr_dm[2]_syn_6  (
    .ipad(App_wr_dm[2]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n1258,open_n1259,open_n1260,\u2_wrrd/app_wr_dm_1d [2]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(26)
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
    \App_wr_dm[3]_syn_6  (
    .ipad(App_wr_dm[3]),
    .ipclk(Sdr_clk_dup_1),
    .diq({open_n1274,open_n1275,open_n1276,\u2_wrrd/app_wr_dm_1d [3]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(26)
  EG_PHY_PAD #(
    //.HYSTERESIS("OFF"),
    //.PCICLAMP("OFF"),
    .IDDRMODE("OFF"),
    .IDDRPIPEMODE("NONE"),
    .INCEMUX("1"),
    .INPCLKMUX("CLK"),
    .INRSTMUX("RST"),
    .IN_DFFMODE("FF"),
    .IN_REGSET("RESET"),
    .IOTYPE("LVCMOS25"),
    .MODE("IN"),
    .SRMODE("SYNC"),
    .TSMUX("1"))
    App_wr_en_syn_6 (
    .ipad(App_wr_en),
    .ipclk(Sdr_clk_dup_1),
    .rst(Rst_dup_175),
    .di(App_wr_en_dup_5),
    .diq({open_n1288,open_n1289,open_n1290,\u2_wrrd/app_wr_en_sft [0]}));  // RTL_1/enc_file/sdr_as_ram.enc.v(24)
  EG_PHY_PAD #(
    //.HYSTERESIS("OFF"),
    //.PCICLAMP("OFF"),
    .IOTYPE("LVCMOS25"),
    .MODE("IN"),
    .TSMUX("1"))
    Rst_syn_176 (
    .ipad(Rst),
    .di(Rst_dup_175));  // RTL_1/enc_file/sdr_as_ram.enc.v(16)
  buf SDRAM_CLK_syn_1 (SDRAM_CLK_dup_3, Sdr_clk_sft_dup_1);  // RTL_1/enc_file/sdr_as_ram.enc.v(35)
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .TSMUX("0"))
    SDRAM_CLK_syn_4 (
    .do({open_n1311,open_n1312,open_n1313,SDRAM_CLK_dup_3}),
    .opad(SDRAM_CLK));  // RTL_1/enc_file/sdr_as_ram.enc.v(35)
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DO_DFFMODE("FF"),
    .DO_REGSET("RESET"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .ODDRMODE("OFF"),
    .OUTCEMUX("1"),
    .OUTRSTMUX("INV"),
    .OUTSCLKMUX("CLK"),
    .SRMODE("SYNC"),
    .TSMUX("0"))
    \SDR_ADDR[0]_syn_6  (
    .do({open_n1328,open_n1329,open_n1330,\u2_wrrd/addr [0]}),
    .osclk(Sdr_clk_dup_1),
    .rst(\u2_wrrd/rw_vld ),
    .opad(SDR_ADDR[0]));  // RTL_1/enc_file/sdr_as_ram.enc.v(40)
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
    \SDR_ADDR[10]_syn_6  (
    .do({open_n1343,open_n1344,open_n1345,\u2_wrrd/SDR_ADDR_b [10]}),
    .osclk(Sdr_clk_dup_1),
    .opad(SDR_ADDR[10]));  // RTL_1/enc_file/sdr_as_ram.enc.v(40)
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
    \SDR_ADDR[1]_syn_6  (
    .do({open_n1359,open_n1360,open_n1361,\u2_wrrd/SDR_ADDR_b [1]}),
    .osclk(Sdr_clk_dup_1),
    .opad(SDR_ADDR[1]));  // RTL_1/enc_file/sdr_as_ram.enc.v(40)
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DO_DFFMODE("FF"),
    .DO_REGSET("RESET"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .ODDRMODE("OFF"),
    .OUTCEMUX("1"),
    .OUTRSTMUX("INV"),
    .OUTSCLKMUX("CLK"),
    .SRMODE("SYNC"),
    .TSMUX("0"))
    \SDR_ADDR[2]_syn_6  (
    .do({open_n1375,open_n1376,open_n1377,\u2_wrrd/addr [2]}),
    .osclk(Sdr_clk_dup_1),
    .rst(\u2_wrrd/rw_vld ),
    .opad(SDR_ADDR[2]));  // RTL_1/enc_file/sdr_as_ram.enc.v(40)
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DO_DFFMODE("FF"),
    .DO_REGSET("RESET"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .ODDRMODE("OFF"),
    .OUTCEMUX("1"),
    .OUTRSTMUX("INV"),
    .OUTSCLKMUX("CLK"),
    .SRMODE("SYNC"),
    .TSMUX("0"))
    \SDR_ADDR[3]_syn_6  (
    .do({open_n1390,open_n1391,open_n1392,\u2_wrrd/addr [3]}),
    .osclk(Sdr_clk_dup_1),
    .rst(\u2_wrrd/rw_vld ),
    .opad(SDR_ADDR[3]));  // RTL_1/enc_file/sdr_as_ram.enc.v(40)
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
    \SDR_ADDR[4]_syn_6  (
    .do({open_n1405,open_n1406,open_n1407,\u2_wrrd/SDR_ADDR_b [4]}),
    .osclk(Sdr_clk_dup_1),
    .opad(SDR_ADDR[4]));  // RTL_1/enc_file/sdr_as_ram.enc.v(40)
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
    \SDR_ADDR[5]_syn_6  (
    .do({open_n1421,open_n1422,open_n1423,\u2_wrrd/SDR_ADDR_b [5]}),
    .osclk(Sdr_clk_dup_1),
    .opad(SDR_ADDR[5]));  // RTL_1/enc_file/sdr_as_ram.enc.v(40)
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DO_DFFMODE("FF"),
    .DO_REGSET("RESET"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .ODDRMODE("OFF"),
    .OUTCEMUX("1"),
    .OUTRSTMUX("INV"),
    .OUTSCLKMUX("CLK"),
    .SRMODE("SYNC"),
    .TSMUX("0"))
    \SDR_ADDR[6]_syn_6  (
    .do({open_n1437,open_n1438,open_n1439,\u2_wrrd/addr [6]}),
    .osclk(Sdr_clk_dup_1),
    .rst(\u2_wrrd/rw_vld ),
    .opad(SDR_ADDR[6]));  // RTL_1/enc_file/sdr_as_ram.enc.v(40)
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DO_DFFMODE("FF"),
    .DO_REGSET("RESET"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .ODDRMODE("OFF"),
    .OUTCEMUX("1"),
    .OUTRSTMUX("INV"),
    .OUTSCLKMUX("CLK"),
    .SRMODE("SYNC"),
    .TSMUX("0"))
    \SDR_ADDR[7]_syn_6  (
    .do({open_n1452,open_n1453,open_n1454,\u2_wrrd/addr [7]}),
    .osclk(Sdr_clk_dup_1),
    .rst(\u2_wrrd/rw_vld ),
    .opad(SDR_ADDR[7]));  // RTL_1/enc_file/sdr_as_ram.enc.v(40)
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DO_DFFMODE("FF"),
    .DO_REGSET("RESET"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .ODDRMODE("OFF"),
    .OUTCEMUX("1"),
    .OUTRSTMUX("INV"),
    .OUTSCLKMUX("CLK"),
    .SRMODE("SYNC"),
    .TSMUX("0"))
    \SDR_ADDR[8]_syn_6  (
    .do({open_n1467,open_n1468,open_n1469,\u2_wrrd/addr [8]}),
    .osclk(Sdr_clk_dup_1),
    .rst(\u2_wrrd/rw_vld ),
    .opad(SDR_ADDR[8]));  // RTL_1/enc_file/sdr_as_ram.enc.v(40)
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DO_DFFMODE("FF"),
    .DO_REGSET("RESET"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .ODDRMODE("OFF"),
    .OUTCEMUX("1"),
    .OUTRSTMUX("INV"),
    .OUTSCLKMUX("CLK"),
    .SRMODE("SYNC"),
    .TSMUX("0"))
    \SDR_ADDR[9]_syn_6  (
    .do({open_n1482,open_n1483,open_n1484,\u2_wrrd/addr [9]}),
    .osclk(Sdr_clk_dup_1),
    .rst(\u2_wrrd/rw_vld ),
    .opad(SDR_ADDR[9]));  // RTL_1/enc_file/sdr_as_ram.enc.v(40)
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DO_DFFMODE("FF"),
    .DO_REGSET("RESET"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .ODDRMODE("OFF"),
    .OUTCEMUX("1"),
    .OUTRSTMUX("INV"),
    .OUTSCLKMUX("CLK"),
    .SRMODE("SYNC"),
    .TSMUX("0"))
    \SDR_BA[0]_syn_6  (
    .do({open_n1497,open_n1498,open_n1499,\u2_wrrd/ba [0]}),
    .osclk(Sdr_clk_dup_1),
    .rst(\u2_wrrd/rw_vld ),
    .opad(SDR_BA[0]));  // RTL_1/enc_file/sdr_as_ram.enc.v(39)
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DO_DFFMODE("FF"),
    .DO_REGSET("RESET"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .ODDRMODE("OFF"),
    .OUTCEMUX("1"),
    .OUTRSTMUX("INV"),
    .OUTSCLKMUX("CLK"),
    .SRMODE("SYNC"),
    .TSMUX("0"))
    \SDR_BA[1]_syn_6  (
    .do({open_n1512,open_n1513,open_n1514,\u2_wrrd/ba [1]}),
    .osclk(Sdr_clk_dup_1),
    .rst(\u2_wrrd/rw_vld ),
    .opad(SDR_BA[1]));  // RTL_1/enc_file/sdr_as_ram.enc.v(39)
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
    SDR_CAS_syn_6 (
    .do({open_n1527,open_n1528,open_n1529,\u2_wrrd/SDR_CAS_n }),
    .osclk(Sdr_clk_dup_1),
    .opad(SDR_CAS));  // RTL_1/enc_file/sdr_as_ram.enc.v(37)
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DO_DFFMODE("FF"),
    .DO_REGSET("SET"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .ODDRMODE("OFF"),
    .OUTCEMUX("1"),
    .OUTRSTMUX("RST"),
    .OUTSCLKMUX("CLK"),
    .SRMODE("SYNC"),
    .TSMUX("0"))
    \SDR_DM[0]_syn_6  (
    .do({open_n1543,open_n1544,open_n1545,\u2_wrrd/app_wr_dm_6d [0]}),
    .osclk(Sdr_clk_dup_1),
    .rst(Rst_dup_175),
    .opad(SDR_DM[0]));  // RTL_1/enc_file/sdr_as_ram.enc.v(41)
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DO_DFFMODE("FF"),
    .DO_REGSET("SET"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .ODDRMODE("OFF"),
    .OUTCEMUX("1"),
    .OUTRSTMUX("RST"),
    .OUTSCLKMUX("CLK"),
    .SRMODE("SYNC"),
    .TSMUX("0"))
    \SDR_DM[1]_syn_6  (
    .do({open_n1558,open_n1559,open_n1560,\u2_wrrd/app_wr_dm_6d [1]}),
    .osclk(Sdr_clk_dup_1),
    .rst(Rst_dup_175),
    .opad(SDR_DM[1]));  // RTL_1/enc_file/sdr_as_ram.enc.v(41)
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DO_DFFMODE("FF"),
    .DO_REGSET("SET"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .ODDRMODE("OFF"),
    .OUTCEMUX("1"),
    .OUTRSTMUX("RST"),
    .OUTSCLKMUX("CLK"),
    .SRMODE("SYNC"),
    .TSMUX("0"))
    \SDR_DM[2]_syn_6  (
    .do({open_n1573,open_n1574,open_n1575,\u2_wrrd/app_wr_dm_6d [2]}),
    .osclk(Sdr_clk_dup_1),
    .rst(Rst_dup_175),
    .opad(SDR_DM[2]));  // RTL_1/enc_file/sdr_as_ram.enc.v(41)
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DO_DFFMODE("FF"),
    .DO_REGSET("SET"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .ODDRMODE("OFF"),
    .OUTCEMUX("1"),
    .OUTRSTMUX("RST"),
    .OUTSCLKMUX("CLK"),
    .SRMODE("SYNC"),
    .TSMUX("0"))
    \SDR_DM[3]_syn_6  (
    .do({open_n1588,open_n1589,open_n1590,\u2_wrrd/app_wr_dm_6d [3]}),
    .osclk(Sdr_clk_dup_1),
    .rst(Rst_dup_175),
    .opad(SDR_DM[3]));  // RTL_1/enc_file/sdr_as_ram.enc.v(41)
  EG_PHY_PAD #(
    //.HYSTERESIS("OFF"),
    //.PCICLAMP("OFF"),
    //.SLEWRATE("SLOW"),
    .DO_DFFMODE("FF"),
    .DO_REGSET("RESET"),
    .DRIVE("8"),
    .IDDRMODE("OFF"),
    .IDDRPIPEMODE("NONE"),
    .INCEMUX("1"),
    .INPCLKMUX("CLK"),
    .INRSTMUX("0"),
    .IN_DFFMODE("FF"),
    .IN_REGSET("RESET"),
    .IOTYPE("LVCMOS25"),
    .MODE("BI"),
    .ODDRMODE("OFF"),
    .OUTCEMUX("1"),
    .OUTRSTMUX("0"),
    .OUTSCLKMUX("CLK"),
    .SRMODE("ASYNC"),
    .TSMUX("INV"))
    \SDR_DQ[0]_syn_2  (
    .do({open_n1603,open_n1604,open_n1605,\u2_wrrd/app_wr_din_6d [0]}),
    .ipclk(Sdr_clk_dup_1),
    .osclk(Sdr_clk_dup_1),
    .ts(\u2_wrrd/sdr_t ),
    .di(\SDR_DQ[0]_dup_1 ),
    .diq({open_n1610,open_n1611,open_n1612,\u2_wrrd/Sdr_rd_dout[0]_syn_3 }),
    .bpad(SDR_DQ[0]));  // RTL_1/enc_file/sdr_as_ram.enc.v(42)
  EG_PHY_PAD #(
    //.HYSTERESIS("OFF"),
    //.PCICLAMP("OFF"),
    //.SLEWRATE("SLOW"),
    .DO_DFFMODE("FF"),
    .DO_REGSET("RESET"),
    .DRIVE("8"),
    .IDDRMODE("OFF"),
    .IDDRPIPEMODE("NONE"),
    .INCEMUX("1"),
    .INPCLKMUX("CLK"),
    .INRSTMUX("0"),
    .IN_DFFMODE("FF"),
    .IN_REGSET("RESET"),
    .IOTYPE("LVCMOS25"),
    .MODE("BI"),
    .ODDRMODE("OFF"),
    .OUTCEMUX("1"),
    .OUTRSTMUX("0"),
    .OUTSCLKMUX("CLK"),
    .SRMODE("ASYNC"),
    .TSMUX("INV"))
    \SDR_DQ[10]_syn_2  (
    .do({open_n1615,open_n1616,open_n1617,\u2_wrrd/app_wr_din_6d [10]}),
    .ipclk(Sdr_clk_dup_1),
    .osclk(Sdr_clk_dup_1),
    .ts(\u2_wrrd/sdr_t ),
    .di(\SDR_DQ[10]_dup_1 ),
    .diq({open_n1622,open_n1623,open_n1624,\u2_wrrd/Sdr_rd_dout[10]_syn_3 }),
    .bpad(SDR_DQ[10]));  // RTL_1/enc_file/sdr_as_ram.enc.v(42)
  EG_PHY_PAD #(
    //.HYSTERESIS("OFF"),
    //.PCICLAMP("OFF"),
    //.SLEWRATE("SLOW"),
    .DO_DFFMODE("FF"),
    .DO_REGSET("RESET"),
    .DRIVE("8"),
    .IDDRMODE("OFF"),
    .IDDRPIPEMODE("NONE"),
    .INCEMUX("1"),
    .INPCLKMUX("CLK"),
    .INRSTMUX("0"),
    .IN_DFFMODE("FF"),
    .IN_REGSET("RESET"),
    .IOTYPE("LVCMOS25"),
    .MODE("BI"),
    .ODDRMODE("OFF"),
    .OUTCEMUX("1"),
    .OUTRSTMUX("0"),
    .OUTSCLKMUX("CLK"),
    .SRMODE("ASYNC"),
    .TSMUX("INV"))
    \SDR_DQ[11]_syn_2  (
    .do({open_n1627,open_n1628,open_n1629,\u2_wrrd/app_wr_din_6d [11]}),
    .ipclk(Sdr_clk_dup_1),
    .osclk(Sdr_clk_dup_1),
    .ts(\u2_wrrd/sdr_t ),
    .di(\SDR_DQ[11]_dup_1 ),
    .diq({open_n1634,open_n1635,open_n1636,\u2_wrrd/Sdr_rd_dout[11]_syn_3 }),
    .bpad(SDR_DQ[11]));  // RTL_1/enc_file/sdr_as_ram.enc.v(42)
  EG_PHY_PAD #(
    //.HYSTERESIS("OFF"),
    //.PCICLAMP("OFF"),
    //.SLEWRATE("SLOW"),
    .DO_DFFMODE("FF"),
    .DO_REGSET("RESET"),
    .DRIVE("8"),
    .IDDRMODE("OFF"),
    .IDDRPIPEMODE("NONE"),
    .INCEMUX("1"),
    .INPCLKMUX("CLK"),
    .INRSTMUX("0"),
    .IN_DFFMODE("FF"),
    .IN_REGSET("RESET"),
    .IOTYPE("LVCMOS25"),
    .MODE("BI"),
    .ODDRMODE("OFF"),
    .OUTCEMUX("1"),
    .OUTRSTMUX("0"),
    .OUTSCLKMUX("CLK"),
    .SRMODE("ASYNC"),
    .TSMUX("INV"))
    \SDR_DQ[12]_syn_2  (
    .do({open_n1639,open_n1640,open_n1641,\u2_wrrd/app_wr_din_6d [12]}),
    .ipclk(Sdr_clk_dup_1),
    .osclk(Sdr_clk_dup_1),
    .ts(\u2_wrrd/sdr_t ),
    .di(\SDR_DQ[12]_dup_1 ),
    .diq({open_n1646,open_n1647,open_n1648,\u2_wrrd/Sdr_rd_dout[12]_syn_3 }),
    .bpad(SDR_DQ[12]));  // RTL_1/enc_file/sdr_as_ram.enc.v(42)
  EG_PHY_PAD #(
    //.HYSTERESIS("OFF"),
    //.PCICLAMP("OFF"),
    //.SLEWRATE("SLOW"),
    .DO_DFFMODE("FF"),
    .DO_REGSET("RESET"),
    .DRIVE("8"),
    .IDDRMODE("OFF"),
    .IDDRPIPEMODE("NONE"),
    .INCEMUX("1"),
    .INPCLKMUX("CLK"),
    .INRSTMUX("0"),
    .IN_DFFMODE("FF"),
    .IN_REGSET("RESET"),
    .IOTYPE("LVCMOS25"),
    .MODE("BI"),
    .ODDRMODE("OFF"),
    .OUTCEMUX("1"),
    .OUTRSTMUX("0"),
    .OUTSCLKMUX("CLK"),
    .SRMODE("ASYNC"),
    .TSMUX("INV"))
    \SDR_DQ[13]_syn_2  (
    .do({open_n1651,open_n1652,open_n1653,\u2_wrrd/app_wr_din_6d [13]}),
    .ipclk(Sdr_clk_dup_1),
    .osclk(Sdr_clk_dup_1),
    .ts(\u2_wrrd/sdr_t ),
    .di(\SDR_DQ[13]_dup_1 ),
    .diq({open_n1658,open_n1659,open_n1660,\u2_wrrd/Sdr_rd_dout[13]_syn_3 }),
    .bpad(SDR_DQ[13]));  // RTL_1/enc_file/sdr_as_ram.enc.v(42)
  EG_PHY_PAD #(
    //.HYSTERESIS("OFF"),
    //.PCICLAMP("OFF"),
    //.SLEWRATE("SLOW"),
    .DO_DFFMODE("FF"),
    .DO_REGSET("RESET"),
    .DRIVE("8"),
    .IDDRMODE("OFF"),
    .IDDRPIPEMODE("NONE"),
    .INCEMUX("1"),
    .INPCLKMUX("CLK"),
    .INRSTMUX("0"),
    .IN_DFFMODE("FF"),
    .IN_REGSET("RESET"),
    .IOTYPE("LVCMOS25"),
    .MODE("BI"),
    .ODDRMODE("OFF"),
    .OUTCEMUX("1"),
    .OUTRSTMUX("0"),
    .OUTSCLKMUX("CLK"),
    .SRMODE("ASYNC"),
    .TSMUX("INV"))
    \SDR_DQ[14]_syn_2  (
    .do({open_n1663,open_n1664,open_n1665,\u2_wrrd/app_wr_din_6d [14]}),
    .ipclk(Sdr_clk_dup_1),
    .osclk(Sdr_clk_dup_1),
    .ts(\u2_wrrd/sdr_t ),
    .di(\SDR_DQ[14]_dup_1 ),
    .diq({open_n1670,open_n1671,open_n1672,\u2_wrrd/Sdr_rd_dout[14]_syn_3 }),
    .bpad(SDR_DQ[14]));  // RTL_1/enc_file/sdr_as_ram.enc.v(42)
  EG_PHY_PAD #(
    //.HYSTERESIS("OFF"),
    //.PCICLAMP("OFF"),
    //.SLEWRATE("SLOW"),
    .DO_DFFMODE("FF"),
    .DO_REGSET("RESET"),
    .DRIVE("8"),
    .IDDRMODE("OFF"),
    .IDDRPIPEMODE("NONE"),
    .INCEMUX("1"),
    .INPCLKMUX("CLK"),
    .INRSTMUX("0"),
    .IN_DFFMODE("FF"),
    .IN_REGSET("RESET"),
    .IOTYPE("LVCMOS25"),
    .MODE("BI"),
    .ODDRMODE("OFF"),
    .OUTCEMUX("1"),
    .OUTRSTMUX("0"),
    .OUTSCLKMUX("CLK"),
    .SRMODE("ASYNC"),
    .TSMUX("INV"))
    \SDR_DQ[15]_syn_2  (
    .do({open_n1675,open_n1676,open_n1677,\u2_wrrd/app_wr_din_6d [15]}),
    .ipclk(Sdr_clk_dup_1),
    .osclk(Sdr_clk_dup_1),
    .ts(\u2_wrrd/sdr_t ),
    .di(\SDR_DQ[15]_dup_1 ),
    .diq({open_n1682,open_n1683,open_n1684,\u2_wrrd/Sdr_rd_dout[15]_syn_3 }),
    .bpad(SDR_DQ[15]));  // RTL_1/enc_file/sdr_as_ram.enc.v(42)
  EG_PHY_PAD #(
    //.HYSTERESIS("OFF"),
    //.PCICLAMP("OFF"),
    //.SLEWRATE("SLOW"),
    .DO_DFFMODE("FF"),
    .DO_REGSET("RESET"),
    .DRIVE("8"),
    .IDDRMODE("OFF"),
    .IDDRPIPEMODE("NONE"),
    .INCEMUX("1"),
    .INPCLKMUX("CLK"),
    .INRSTMUX("0"),
    .IN_DFFMODE("FF"),
    .IN_REGSET("RESET"),
    .IOTYPE("LVCMOS25"),
    .MODE("BI"),
    .ODDRMODE("OFF"),
    .OUTCEMUX("1"),
    .OUTRSTMUX("0"),
    .OUTSCLKMUX("CLK"),
    .SRMODE("ASYNC"),
    .TSMUX("INV"))
    \SDR_DQ[16]_syn_2  (
    .do({open_n1687,open_n1688,open_n1689,\u2_wrrd/app_wr_din_6d [16]}),
    .ipclk(Sdr_clk_dup_1),
    .osclk(Sdr_clk_dup_1),
    .ts(\u2_wrrd/sdr_t ),
    .di(\SDR_DQ[16]_dup_1 ),
    .diq({open_n1694,open_n1695,open_n1696,\u2_wrrd/Sdr_rd_dout[16]_syn_3 }),
    .bpad(SDR_DQ[16]));  // RTL_1/enc_file/sdr_as_ram.enc.v(42)
  EG_PHY_PAD #(
    //.HYSTERESIS("OFF"),
    //.PCICLAMP("OFF"),
    //.SLEWRATE("SLOW"),
    .DO_DFFMODE("FF"),
    .DO_REGSET("RESET"),
    .DRIVE("8"),
    .IDDRMODE("OFF"),
    .IDDRPIPEMODE("NONE"),
    .INCEMUX("1"),
    .INPCLKMUX("CLK"),
    .INRSTMUX("0"),
    .IN_DFFMODE("FF"),
    .IN_REGSET("RESET"),
    .IOTYPE("LVCMOS25"),
    .MODE("BI"),
    .ODDRMODE("OFF"),
    .OUTCEMUX("1"),
    .OUTRSTMUX("0"),
    .OUTSCLKMUX("CLK"),
    .SRMODE("ASYNC"),
    .TSMUX("INV"))
    \SDR_DQ[17]_syn_2  (
    .do({open_n1699,open_n1700,open_n1701,\u2_wrrd/app_wr_din_6d [17]}),
    .ipclk(Sdr_clk_dup_1),
    .osclk(Sdr_clk_dup_1),
    .ts(\u2_wrrd/sdr_t ),
    .di(\SDR_DQ[17]_dup_1 ),
    .diq({open_n1706,open_n1707,open_n1708,\u2_wrrd/Sdr_rd_dout[17]_syn_3 }),
    .bpad(SDR_DQ[17]));  // RTL_1/enc_file/sdr_as_ram.enc.v(42)
  EG_PHY_PAD #(
    //.HYSTERESIS("OFF"),
    //.PCICLAMP("OFF"),
    //.SLEWRATE("SLOW"),
    .DO_DFFMODE("FF"),
    .DO_REGSET("RESET"),
    .DRIVE("8"),
    .IDDRMODE("OFF"),
    .IDDRPIPEMODE("NONE"),
    .INCEMUX("1"),
    .INPCLKMUX("CLK"),
    .INRSTMUX("0"),
    .IN_DFFMODE("FF"),
    .IN_REGSET("RESET"),
    .IOTYPE("LVCMOS25"),
    .MODE("BI"),
    .ODDRMODE("OFF"),
    .OUTCEMUX("1"),
    .OUTRSTMUX("0"),
    .OUTSCLKMUX("CLK"),
    .SRMODE("ASYNC"),
    .TSMUX("INV"))
    \SDR_DQ[18]_syn_2  (
    .do({open_n1711,open_n1712,open_n1713,\u2_wrrd/app_wr_din_6d [18]}),
    .ipclk(Sdr_clk_dup_1),
    .osclk(Sdr_clk_dup_1),
    .ts(\u2_wrrd/sdr_t ),
    .di(\SDR_DQ[18]_dup_1 ),
    .diq({open_n1718,open_n1719,open_n1720,\u2_wrrd/Sdr_rd_dout[18]_syn_3 }),
    .bpad(SDR_DQ[18]));  // RTL_1/enc_file/sdr_as_ram.enc.v(42)
  EG_PHY_PAD #(
    //.HYSTERESIS("OFF"),
    //.PCICLAMP("OFF"),
    //.SLEWRATE("SLOW"),
    .DO_DFFMODE("FF"),
    .DO_REGSET("RESET"),
    .DRIVE("8"),
    .IDDRMODE("OFF"),
    .IDDRPIPEMODE("NONE"),
    .INCEMUX("1"),
    .INPCLKMUX("CLK"),
    .INRSTMUX("0"),
    .IN_DFFMODE("FF"),
    .IN_REGSET("RESET"),
    .IOTYPE("LVCMOS25"),
    .MODE("BI"),
    .ODDRMODE("OFF"),
    .OUTCEMUX("1"),
    .OUTRSTMUX("0"),
    .OUTSCLKMUX("CLK"),
    .SRMODE("ASYNC"),
    .TSMUX("INV"))
    \SDR_DQ[19]_syn_2  (
    .do({open_n1723,open_n1724,open_n1725,\u2_wrrd/app_wr_din_6d [19]}),
    .ipclk(Sdr_clk_dup_1),
    .osclk(Sdr_clk_dup_1),
    .ts(\u2_wrrd/sdr_t ),
    .di(\SDR_DQ[19]_dup_1 ),
    .diq({open_n1730,open_n1731,open_n1732,\u2_wrrd/Sdr_rd_dout[19]_syn_3 }),
    .bpad(SDR_DQ[19]));  // RTL_1/enc_file/sdr_as_ram.enc.v(42)
  EG_PHY_PAD #(
    //.HYSTERESIS("OFF"),
    //.PCICLAMP("OFF"),
    //.SLEWRATE("SLOW"),
    .DO_DFFMODE("FF"),
    .DO_REGSET("RESET"),
    .DRIVE("8"),
    .IDDRMODE("OFF"),
    .IDDRPIPEMODE("NONE"),
    .INCEMUX("1"),
    .INPCLKMUX("CLK"),
    .INRSTMUX("0"),
    .IN_DFFMODE("FF"),
    .IN_REGSET("RESET"),
    .IOTYPE("LVCMOS25"),
    .MODE("BI"),
    .ODDRMODE("OFF"),
    .OUTCEMUX("1"),
    .OUTRSTMUX("0"),
    .OUTSCLKMUX("CLK"),
    .SRMODE("ASYNC"),
    .TSMUX("INV"))
    \SDR_DQ[1]_syn_2  (
    .do({open_n1735,open_n1736,open_n1737,\u2_wrrd/app_wr_din_6d [1]}),
    .ipclk(Sdr_clk_dup_1),
    .osclk(Sdr_clk_dup_1),
    .ts(\u2_wrrd/sdr_t ),
    .di(\SDR_DQ[1]_dup_1 ),
    .diq({open_n1742,open_n1743,open_n1744,\u2_wrrd/Sdr_rd_dout[1]_syn_3 }),
    .bpad(SDR_DQ[1]));  // RTL_1/enc_file/sdr_as_ram.enc.v(42)
  EG_PHY_PAD #(
    //.HYSTERESIS("OFF"),
    //.PCICLAMP("OFF"),
    //.SLEWRATE("SLOW"),
    .DO_DFFMODE("FF"),
    .DO_REGSET("RESET"),
    .DRIVE("8"),
    .IDDRMODE("OFF"),
    .IDDRPIPEMODE("NONE"),
    .INCEMUX("1"),
    .INPCLKMUX("CLK"),
    .INRSTMUX("0"),
    .IN_DFFMODE("FF"),
    .IN_REGSET("RESET"),
    .IOTYPE("LVCMOS25"),
    .MODE("BI"),
    .ODDRMODE("OFF"),
    .OUTCEMUX("1"),
    .OUTRSTMUX("0"),
    .OUTSCLKMUX("CLK"),
    .SRMODE("ASYNC"),
    .TSMUX("INV"))
    \SDR_DQ[20]_syn_2  (
    .do({open_n1747,open_n1748,open_n1749,\u2_wrrd/app_wr_din_6d [20]}),
    .ipclk(Sdr_clk_dup_1),
    .osclk(Sdr_clk_dup_1),
    .ts(\u2_wrrd/sdr_t ),
    .di(\SDR_DQ[20]_dup_1 ),
    .diq({open_n1754,open_n1755,open_n1756,\u2_wrrd/Sdr_rd_dout[20]_syn_3 }),
    .bpad(SDR_DQ[20]));  // RTL_1/enc_file/sdr_as_ram.enc.v(42)
  EG_PHY_PAD #(
    //.HYSTERESIS("OFF"),
    //.PCICLAMP("OFF"),
    //.SLEWRATE("SLOW"),
    .DO_DFFMODE("FF"),
    .DO_REGSET("RESET"),
    .DRIVE("8"),
    .IDDRMODE("OFF"),
    .IDDRPIPEMODE("NONE"),
    .INCEMUX("1"),
    .INPCLKMUX("CLK"),
    .INRSTMUX("0"),
    .IN_DFFMODE("FF"),
    .IN_REGSET("RESET"),
    .IOTYPE("LVCMOS25"),
    .MODE("BI"),
    .ODDRMODE("OFF"),
    .OUTCEMUX("1"),
    .OUTRSTMUX("0"),
    .OUTSCLKMUX("CLK"),
    .SRMODE("ASYNC"),
    .TSMUX("INV"))
    \SDR_DQ[21]_syn_2  (
    .do({open_n1759,open_n1760,open_n1761,\u2_wrrd/app_wr_din_6d [21]}),
    .ipclk(Sdr_clk_dup_1),
    .osclk(Sdr_clk_dup_1),
    .ts(\u2_wrrd/sdr_t ),
    .di(\SDR_DQ[21]_dup_1 ),
    .diq({open_n1766,open_n1767,open_n1768,\u2_wrrd/Sdr_rd_dout[21]_syn_3 }),
    .bpad(SDR_DQ[21]));  // RTL_1/enc_file/sdr_as_ram.enc.v(42)
  EG_PHY_PAD #(
    //.HYSTERESIS("OFF"),
    //.PCICLAMP("OFF"),
    //.SLEWRATE("SLOW"),
    .DO_DFFMODE("FF"),
    .DO_REGSET("RESET"),
    .DRIVE("8"),
    .IDDRMODE("OFF"),
    .IDDRPIPEMODE("NONE"),
    .INCEMUX("1"),
    .INPCLKMUX("CLK"),
    .INRSTMUX("0"),
    .IN_DFFMODE("FF"),
    .IN_REGSET("RESET"),
    .IOTYPE("LVCMOS25"),
    .MODE("BI"),
    .ODDRMODE("OFF"),
    .OUTCEMUX("1"),
    .OUTRSTMUX("0"),
    .OUTSCLKMUX("CLK"),
    .SRMODE("ASYNC"),
    .TSMUX("INV"))
    \SDR_DQ[22]_syn_2  (
    .do({open_n1771,open_n1772,open_n1773,\u2_wrrd/app_wr_din_6d [22]}),
    .ipclk(Sdr_clk_dup_1),
    .osclk(Sdr_clk_dup_1),
    .ts(\u2_wrrd/sdr_t ),
    .di(\SDR_DQ[22]_dup_1 ),
    .diq({open_n1778,open_n1779,open_n1780,\u2_wrrd/Sdr_rd_dout[22]_syn_3 }),
    .bpad(SDR_DQ[22]));  // RTL_1/enc_file/sdr_as_ram.enc.v(42)
  EG_PHY_PAD #(
    //.HYSTERESIS("OFF"),
    //.PCICLAMP("OFF"),
    //.SLEWRATE("SLOW"),
    .DO_DFFMODE("FF"),
    .DO_REGSET("RESET"),
    .DRIVE("8"),
    .IDDRMODE("OFF"),
    .IDDRPIPEMODE("NONE"),
    .INCEMUX("1"),
    .INPCLKMUX("CLK"),
    .INRSTMUX("0"),
    .IN_DFFMODE("FF"),
    .IN_REGSET("RESET"),
    .IOTYPE("LVCMOS25"),
    .MODE("BI"),
    .ODDRMODE("OFF"),
    .OUTCEMUX("1"),
    .OUTRSTMUX("0"),
    .OUTSCLKMUX("CLK"),
    .SRMODE("ASYNC"),
    .TSMUX("INV"))
    \SDR_DQ[23]_syn_2  (
    .do({open_n1783,open_n1784,open_n1785,\u2_wrrd/app_wr_din_6d [23]}),
    .ipclk(Sdr_clk_dup_1),
    .osclk(Sdr_clk_dup_1),
    .ts(\u2_wrrd/sdr_t ),
    .di(\SDR_DQ[23]_dup_1 ),
    .diq({open_n1790,open_n1791,open_n1792,\u2_wrrd/Sdr_rd_dout[23]_syn_3 }),
    .bpad(SDR_DQ[23]));  // RTL_1/enc_file/sdr_as_ram.enc.v(42)
  EG_PHY_PAD #(
    //.HYSTERESIS("OFF"),
    //.PCICLAMP("OFF"),
    //.SLEWRATE("SLOW"),
    .DO_DFFMODE("FF"),
    .DO_REGSET("RESET"),
    .DRIVE("8"),
    .IDDRMODE("OFF"),
    .IDDRPIPEMODE("NONE"),
    .INCEMUX("1"),
    .INPCLKMUX("CLK"),
    .INRSTMUX("0"),
    .IN_DFFMODE("FF"),
    .IN_REGSET("RESET"),
    .IOTYPE("LVCMOS25"),
    .MODE("BI"),
    .ODDRMODE("OFF"),
    .OUTCEMUX("1"),
    .OUTRSTMUX("0"),
    .OUTSCLKMUX("CLK"),
    .SRMODE("ASYNC"),
    .TSMUX("INV"))
    \SDR_DQ[24]_syn_2  (
    .do({open_n1795,open_n1796,open_n1797,\u2_wrrd/app_wr_din_6d [24]}),
    .ipclk(Sdr_clk_dup_1),
    .osclk(Sdr_clk_dup_1),
    .ts(\u2_wrrd/sdr_t ),
    .di(\SDR_DQ[24]_dup_1 ),
    .diq({open_n1802,open_n1803,open_n1804,\u2_wrrd/Sdr_rd_dout[24]_syn_3 }),
    .bpad(SDR_DQ[24]));  // RTL_1/enc_file/sdr_as_ram.enc.v(42)
  EG_PHY_PAD #(
    //.HYSTERESIS("OFF"),
    //.PCICLAMP("OFF"),
    //.SLEWRATE("SLOW"),
    .DO_DFFMODE("FF"),
    .DO_REGSET("RESET"),
    .DRIVE("8"),
    .IDDRMODE("OFF"),
    .IDDRPIPEMODE("NONE"),
    .INCEMUX("1"),
    .INPCLKMUX("CLK"),
    .INRSTMUX("0"),
    .IN_DFFMODE("FF"),
    .IN_REGSET("RESET"),
    .IOTYPE("LVCMOS25"),
    .MODE("BI"),
    .ODDRMODE("OFF"),
    .OUTCEMUX("1"),
    .OUTRSTMUX("0"),
    .OUTSCLKMUX("CLK"),
    .SRMODE("ASYNC"),
    .TSMUX("INV"))
    \SDR_DQ[25]_syn_2  (
    .do({open_n1807,open_n1808,open_n1809,\u2_wrrd/app_wr_din_6d [25]}),
    .ipclk(Sdr_clk_dup_1),
    .osclk(Sdr_clk_dup_1),
    .ts(\u2_wrrd/sdr_t ),
    .di(\SDR_DQ[25]_dup_1 ),
    .diq({open_n1814,open_n1815,open_n1816,\u2_wrrd/Sdr_rd_dout[25]_syn_3 }),
    .bpad(SDR_DQ[25]));  // RTL_1/enc_file/sdr_as_ram.enc.v(42)
  EG_PHY_PAD #(
    //.HYSTERESIS("OFF"),
    //.PCICLAMP("OFF"),
    //.SLEWRATE("SLOW"),
    .DO_DFFMODE("FF"),
    .DO_REGSET("RESET"),
    .DRIVE("8"),
    .IDDRMODE("OFF"),
    .IDDRPIPEMODE("NONE"),
    .INCEMUX("1"),
    .INPCLKMUX("CLK"),
    .INRSTMUX("0"),
    .IN_DFFMODE("FF"),
    .IN_REGSET("RESET"),
    .IOTYPE("LVCMOS25"),
    .MODE("BI"),
    .ODDRMODE("OFF"),
    .OUTCEMUX("1"),
    .OUTRSTMUX("0"),
    .OUTSCLKMUX("CLK"),
    .SRMODE("ASYNC"),
    .TSMUX("INV"))
    \SDR_DQ[26]_syn_2  (
    .do({open_n1819,open_n1820,open_n1821,\u2_wrrd/app_wr_din_6d [26]}),
    .ipclk(Sdr_clk_dup_1),
    .osclk(Sdr_clk_dup_1),
    .ts(\u2_wrrd/sdr_t ),
    .di(\SDR_DQ[26]_dup_1 ),
    .diq({open_n1826,open_n1827,open_n1828,\u2_wrrd/Sdr_rd_dout[26]_syn_3 }),
    .bpad(SDR_DQ[26]));  // RTL_1/enc_file/sdr_as_ram.enc.v(42)
  EG_PHY_PAD #(
    //.HYSTERESIS("OFF"),
    //.PCICLAMP("OFF"),
    //.SLEWRATE("SLOW"),
    .DO_DFFMODE("FF"),
    .DO_REGSET("RESET"),
    .DRIVE("8"),
    .IDDRMODE("OFF"),
    .IDDRPIPEMODE("NONE"),
    .INCEMUX("1"),
    .INPCLKMUX("CLK"),
    .INRSTMUX("0"),
    .IN_DFFMODE("FF"),
    .IN_REGSET("RESET"),
    .IOTYPE("LVCMOS25"),
    .MODE("BI"),
    .ODDRMODE("OFF"),
    .OUTCEMUX("1"),
    .OUTRSTMUX("0"),
    .OUTSCLKMUX("CLK"),
    .SRMODE("ASYNC"),
    .TSMUX("INV"))
    \SDR_DQ[27]_syn_2  (
    .do({open_n1831,open_n1832,open_n1833,\u2_wrrd/app_wr_din_6d [27]}),
    .ipclk(Sdr_clk_dup_1),
    .osclk(Sdr_clk_dup_1),
    .ts(\u2_wrrd/sdr_t ),
    .di(\SDR_DQ[27]_dup_1 ),
    .diq({open_n1838,open_n1839,open_n1840,\u2_wrrd/Sdr_rd_dout[27]_syn_3 }),
    .bpad(SDR_DQ[27]));  // RTL_1/enc_file/sdr_as_ram.enc.v(42)
  EG_PHY_PAD #(
    //.HYSTERESIS("OFF"),
    //.PCICLAMP("OFF"),
    //.SLEWRATE("SLOW"),
    .DO_DFFMODE("FF"),
    .DO_REGSET("RESET"),
    .DRIVE("8"),
    .IDDRMODE("OFF"),
    .IDDRPIPEMODE("NONE"),
    .INCEMUX("1"),
    .INPCLKMUX("CLK"),
    .INRSTMUX("0"),
    .IN_DFFMODE("FF"),
    .IN_REGSET("RESET"),
    .IOTYPE("LVCMOS25"),
    .MODE("BI"),
    .ODDRMODE("OFF"),
    .OUTCEMUX("1"),
    .OUTRSTMUX("0"),
    .OUTSCLKMUX("CLK"),
    .SRMODE("ASYNC"),
    .TSMUX("INV"))
    \SDR_DQ[28]_syn_2  (
    .do({open_n1843,open_n1844,open_n1845,\u2_wrrd/app_wr_din_6d [28]}),
    .ipclk(Sdr_clk_dup_1),
    .osclk(Sdr_clk_dup_1),
    .ts(\u2_wrrd/sdr_t ),
    .di(\SDR_DQ[28]_dup_1 ),
    .diq({open_n1850,open_n1851,open_n1852,\u2_wrrd/Sdr_rd_dout[28]_syn_3 }),
    .bpad(SDR_DQ[28]));  // RTL_1/enc_file/sdr_as_ram.enc.v(42)
  EG_PHY_PAD #(
    //.HYSTERESIS("OFF"),
    //.PCICLAMP("OFF"),
    //.SLEWRATE("SLOW"),
    .DO_DFFMODE("FF"),
    .DO_REGSET("RESET"),
    .DRIVE("8"),
    .IDDRMODE("OFF"),
    .IDDRPIPEMODE("NONE"),
    .INCEMUX("1"),
    .INPCLKMUX("CLK"),
    .INRSTMUX("0"),
    .IN_DFFMODE("FF"),
    .IN_REGSET("RESET"),
    .IOTYPE("LVCMOS25"),
    .MODE("BI"),
    .ODDRMODE("OFF"),
    .OUTCEMUX("1"),
    .OUTRSTMUX("0"),
    .OUTSCLKMUX("CLK"),
    .SRMODE("ASYNC"),
    .TSMUX("INV"))
    \SDR_DQ[29]_syn_2  (
    .do({open_n1855,open_n1856,open_n1857,\u2_wrrd/app_wr_din_6d [29]}),
    .ipclk(Sdr_clk_dup_1),
    .osclk(Sdr_clk_dup_1),
    .ts(\u2_wrrd/sdr_t ),
    .di(\SDR_DQ[29]_dup_1 ),
    .diq({open_n1862,open_n1863,open_n1864,\u2_wrrd/Sdr_rd_dout[29]_syn_3 }),
    .bpad(SDR_DQ[29]));  // RTL_1/enc_file/sdr_as_ram.enc.v(42)
  EG_PHY_PAD #(
    //.HYSTERESIS("OFF"),
    //.PCICLAMP("OFF"),
    //.SLEWRATE("SLOW"),
    .DO_DFFMODE("FF"),
    .DO_REGSET("RESET"),
    .DRIVE("8"),
    .IDDRMODE("OFF"),
    .IDDRPIPEMODE("NONE"),
    .INCEMUX("1"),
    .INPCLKMUX("CLK"),
    .INRSTMUX("0"),
    .IN_DFFMODE("FF"),
    .IN_REGSET("RESET"),
    .IOTYPE("LVCMOS25"),
    .MODE("BI"),
    .ODDRMODE("OFF"),
    .OUTCEMUX("1"),
    .OUTRSTMUX("0"),
    .OUTSCLKMUX("CLK"),
    .SRMODE("ASYNC"),
    .TSMUX("INV"))
    \SDR_DQ[2]_syn_2  (
    .do({open_n1867,open_n1868,open_n1869,\u2_wrrd/app_wr_din_6d [2]}),
    .ipclk(Sdr_clk_dup_1),
    .osclk(Sdr_clk_dup_1),
    .ts(\u2_wrrd/sdr_t ),
    .di(\SDR_DQ[2]_dup_1 ),
    .diq({open_n1874,open_n1875,open_n1876,\u2_wrrd/Sdr_rd_dout[2]_syn_3 }),
    .bpad(SDR_DQ[2]));  // RTL_1/enc_file/sdr_as_ram.enc.v(42)
  EG_PHY_PAD #(
    //.HYSTERESIS("OFF"),
    //.PCICLAMP("OFF"),
    //.SLEWRATE("SLOW"),
    .DO_DFFMODE("FF"),
    .DO_REGSET("RESET"),
    .DRIVE("8"),
    .IDDRMODE("OFF"),
    .IDDRPIPEMODE("NONE"),
    .INCEMUX("1"),
    .INPCLKMUX("CLK"),
    .INRSTMUX("0"),
    .IN_DFFMODE("FF"),
    .IN_REGSET("RESET"),
    .IOTYPE("LVCMOS25"),
    .MODE("BI"),
    .ODDRMODE("OFF"),
    .OUTCEMUX("1"),
    .OUTRSTMUX("0"),
    .OUTSCLKMUX("CLK"),
    .SRMODE("ASYNC"),
    .TSMUX("INV"))
    \SDR_DQ[30]_syn_2  (
    .do({open_n1879,open_n1880,open_n1881,\u2_wrrd/app_wr_din_6d [30]}),
    .ipclk(Sdr_clk_dup_1),
    .osclk(Sdr_clk_dup_1),
    .ts(\u2_wrrd/sdr_t ),
    .di(\SDR_DQ[30]_dup_1 ),
    .diq({open_n1886,open_n1887,open_n1888,\u2_wrrd/Sdr_rd_dout[30]_syn_3 }),
    .bpad(SDR_DQ[30]));  // RTL_1/enc_file/sdr_as_ram.enc.v(42)
  EG_PHY_PAD #(
    //.HYSTERESIS("OFF"),
    //.PCICLAMP("OFF"),
    //.SLEWRATE("SLOW"),
    .DO_DFFMODE("FF"),
    .DO_REGSET("RESET"),
    .DRIVE("8"),
    .IDDRMODE("OFF"),
    .IDDRPIPEMODE("NONE"),
    .INCEMUX("1"),
    .INPCLKMUX("CLK"),
    .INRSTMUX("0"),
    .IN_DFFMODE("FF"),
    .IN_REGSET("RESET"),
    .IOTYPE("LVCMOS25"),
    .MODE("BI"),
    .ODDRMODE("OFF"),
    .OUTCEMUX("1"),
    .OUTRSTMUX("0"),
    .OUTSCLKMUX("CLK"),
    .SRMODE("ASYNC"),
    .TSMUX("INV"))
    \SDR_DQ[31]_syn_2  (
    .do({open_n1891,open_n1892,open_n1893,\u2_wrrd/app_wr_din_6d [31]}),
    .ipclk(Sdr_clk_dup_1),
    .osclk(Sdr_clk_dup_1),
    .ts(\u2_wrrd/sdr_t ),
    .di(\SDR_DQ[31]_dup_1 ),
    .diq({open_n1898,open_n1899,open_n1900,\u2_wrrd/Sdr_rd_dout[31]_syn_3 }),
    .bpad(SDR_DQ[31]));  // RTL_1/enc_file/sdr_as_ram.enc.v(42)
  EG_PHY_PAD #(
    //.HYSTERESIS("OFF"),
    //.PCICLAMP("OFF"),
    //.SLEWRATE("SLOW"),
    .DO_DFFMODE("FF"),
    .DO_REGSET("RESET"),
    .DRIVE("8"),
    .IDDRMODE("OFF"),
    .IDDRPIPEMODE("NONE"),
    .INCEMUX("1"),
    .INPCLKMUX("CLK"),
    .INRSTMUX("0"),
    .IN_DFFMODE("FF"),
    .IN_REGSET("RESET"),
    .IOTYPE("LVCMOS25"),
    .MODE("BI"),
    .ODDRMODE("OFF"),
    .OUTCEMUX("1"),
    .OUTRSTMUX("0"),
    .OUTSCLKMUX("CLK"),
    .SRMODE("ASYNC"),
    .TSMUX("INV"))
    \SDR_DQ[3]_syn_2  (
    .do({open_n1903,open_n1904,open_n1905,\u2_wrrd/app_wr_din_6d [3]}),
    .ipclk(Sdr_clk_dup_1),
    .osclk(Sdr_clk_dup_1),
    .ts(\u2_wrrd/sdr_t ),
    .di(\SDR_DQ[3]_dup_1 ),
    .diq({open_n1910,open_n1911,open_n1912,\u2_wrrd/Sdr_rd_dout[3]_syn_3 }),
    .bpad(SDR_DQ[3]));  // RTL_1/enc_file/sdr_as_ram.enc.v(42)
  EG_PHY_PAD #(
    //.HYSTERESIS("OFF"),
    //.PCICLAMP("OFF"),
    //.SLEWRATE("SLOW"),
    .DO_DFFMODE("FF"),
    .DO_REGSET("RESET"),
    .DRIVE("8"),
    .IDDRMODE("OFF"),
    .IDDRPIPEMODE("NONE"),
    .INCEMUX("1"),
    .INPCLKMUX("CLK"),
    .INRSTMUX("0"),
    .IN_DFFMODE("FF"),
    .IN_REGSET("RESET"),
    .IOTYPE("LVCMOS25"),
    .MODE("BI"),
    .ODDRMODE("OFF"),
    .OUTCEMUX("1"),
    .OUTRSTMUX("0"),
    .OUTSCLKMUX("CLK"),
    .SRMODE("ASYNC"),
    .TSMUX("INV"))
    \SDR_DQ[4]_syn_2  (
    .do({open_n1915,open_n1916,open_n1917,\u2_wrrd/app_wr_din_6d [4]}),
    .ipclk(Sdr_clk_dup_1),
    .osclk(Sdr_clk_dup_1),
    .ts(\u2_wrrd/sdr_t ),
    .di(\SDR_DQ[4]_dup_1 ),
    .diq({open_n1922,open_n1923,open_n1924,\u2_wrrd/Sdr_rd_dout[4]_syn_3 }),
    .bpad(SDR_DQ[4]));  // RTL_1/enc_file/sdr_as_ram.enc.v(42)
  EG_PHY_PAD #(
    //.HYSTERESIS("OFF"),
    //.PCICLAMP("OFF"),
    //.SLEWRATE("SLOW"),
    .DO_DFFMODE("FF"),
    .DO_REGSET("RESET"),
    .DRIVE("8"),
    .IDDRMODE("OFF"),
    .IDDRPIPEMODE("NONE"),
    .INCEMUX("1"),
    .INPCLKMUX("CLK"),
    .INRSTMUX("0"),
    .IN_DFFMODE("FF"),
    .IN_REGSET("RESET"),
    .IOTYPE("LVCMOS25"),
    .MODE("BI"),
    .ODDRMODE("OFF"),
    .OUTCEMUX("1"),
    .OUTRSTMUX("0"),
    .OUTSCLKMUX("CLK"),
    .SRMODE("ASYNC"),
    .TSMUX("INV"))
    \SDR_DQ[5]_syn_2  (
    .do({open_n1927,open_n1928,open_n1929,\u2_wrrd/app_wr_din_6d [5]}),
    .ipclk(Sdr_clk_dup_1),
    .osclk(Sdr_clk_dup_1),
    .ts(\u2_wrrd/sdr_t ),
    .di(\SDR_DQ[5]_dup_1 ),
    .diq({open_n1934,open_n1935,open_n1936,\u2_wrrd/Sdr_rd_dout[5]_syn_3 }),
    .bpad(SDR_DQ[5]));  // RTL_1/enc_file/sdr_as_ram.enc.v(42)
  EG_PHY_PAD #(
    //.HYSTERESIS("OFF"),
    //.PCICLAMP("OFF"),
    //.SLEWRATE("SLOW"),
    .DO_DFFMODE("FF"),
    .DO_REGSET("RESET"),
    .DRIVE("8"),
    .IDDRMODE("OFF"),
    .IDDRPIPEMODE("NONE"),
    .INCEMUX("1"),
    .INPCLKMUX("CLK"),
    .INRSTMUX("0"),
    .IN_DFFMODE("FF"),
    .IN_REGSET("RESET"),
    .IOTYPE("LVCMOS25"),
    .MODE("BI"),
    .ODDRMODE("OFF"),
    .OUTCEMUX("1"),
    .OUTRSTMUX("0"),
    .OUTSCLKMUX("CLK"),
    .SRMODE("ASYNC"),
    .TSMUX("INV"))
    \SDR_DQ[6]_syn_2  (
    .do({open_n1939,open_n1940,open_n1941,\u2_wrrd/app_wr_din_6d [6]}),
    .ipclk(Sdr_clk_dup_1),
    .osclk(Sdr_clk_dup_1),
    .ts(\u2_wrrd/sdr_t ),
    .di(\SDR_DQ[6]_dup_1 ),
    .diq({open_n1946,open_n1947,open_n1948,\u2_wrrd/Sdr_rd_dout[6]_syn_3 }),
    .bpad(SDR_DQ[6]));  // RTL_1/enc_file/sdr_as_ram.enc.v(42)
  EG_PHY_PAD #(
    //.HYSTERESIS("OFF"),
    //.PCICLAMP("OFF"),
    //.SLEWRATE("SLOW"),
    .DO_DFFMODE("FF"),
    .DO_REGSET("RESET"),
    .DRIVE("8"),
    .IDDRMODE("OFF"),
    .IDDRPIPEMODE("NONE"),
    .INCEMUX("1"),
    .INPCLKMUX("CLK"),
    .INRSTMUX("0"),
    .IN_DFFMODE("FF"),
    .IN_REGSET("RESET"),
    .IOTYPE("LVCMOS25"),
    .MODE("BI"),
    .ODDRMODE("OFF"),
    .OUTCEMUX("1"),
    .OUTRSTMUX("0"),
    .OUTSCLKMUX("CLK"),
    .SRMODE("ASYNC"),
    .TSMUX("INV"))
    \SDR_DQ[7]_syn_2  (
    .do({open_n1951,open_n1952,open_n1953,\u2_wrrd/app_wr_din_6d [7]}),
    .ipclk(Sdr_clk_dup_1),
    .osclk(Sdr_clk_dup_1),
    .ts(\u2_wrrd/sdr_t ),
    .di(\SDR_DQ[7]_dup_1 ),
    .diq({open_n1958,open_n1959,open_n1960,\u2_wrrd/Sdr_rd_dout[7]_syn_3 }),
    .bpad(SDR_DQ[7]));  // RTL_1/enc_file/sdr_as_ram.enc.v(42)
  EG_PHY_PAD #(
    //.HYSTERESIS("OFF"),
    //.PCICLAMP("OFF"),
    //.SLEWRATE("SLOW"),
    .DO_DFFMODE("FF"),
    .DO_REGSET("RESET"),
    .DRIVE("8"),
    .IDDRMODE("OFF"),
    .IDDRPIPEMODE("NONE"),
    .INCEMUX("1"),
    .INPCLKMUX("CLK"),
    .INRSTMUX("0"),
    .IN_DFFMODE("FF"),
    .IN_REGSET("RESET"),
    .IOTYPE("LVCMOS25"),
    .MODE("BI"),
    .ODDRMODE("OFF"),
    .OUTCEMUX("1"),
    .OUTRSTMUX("0"),
    .OUTSCLKMUX("CLK"),
    .SRMODE("ASYNC"),
    .TSMUX("INV"))
    \SDR_DQ[8]_syn_2  (
    .do({open_n1963,open_n1964,open_n1965,\u2_wrrd/app_wr_din_6d [8]}),
    .ipclk(Sdr_clk_dup_1),
    .osclk(Sdr_clk_dup_1),
    .ts(\u2_wrrd/sdr_t ),
    .di(\SDR_DQ[8]_dup_1 ),
    .diq({open_n1970,open_n1971,open_n1972,\u2_wrrd/Sdr_rd_dout[8]_syn_3 }),
    .bpad(SDR_DQ[8]));  // RTL_1/enc_file/sdr_as_ram.enc.v(42)
  EG_PHY_PAD #(
    //.HYSTERESIS("OFF"),
    //.PCICLAMP("OFF"),
    //.SLEWRATE("SLOW"),
    .DO_DFFMODE("FF"),
    .DO_REGSET("RESET"),
    .DRIVE("8"),
    .IDDRMODE("OFF"),
    .IDDRPIPEMODE("NONE"),
    .INCEMUX("1"),
    .INPCLKMUX("CLK"),
    .INRSTMUX("0"),
    .IN_DFFMODE("FF"),
    .IN_REGSET("RESET"),
    .IOTYPE("LVCMOS25"),
    .MODE("BI"),
    .ODDRMODE("OFF"),
    .OUTCEMUX("1"),
    .OUTRSTMUX("0"),
    .OUTSCLKMUX("CLK"),
    .SRMODE("ASYNC"),
    .TSMUX("INV"))
    \SDR_DQ[9]_syn_2  (
    .do({open_n1975,open_n1976,open_n1977,\u2_wrrd/app_wr_din_6d [9]}),
    .ipclk(Sdr_clk_dup_1),
    .osclk(Sdr_clk_dup_1),
    .ts(\u2_wrrd/sdr_t ),
    .di(\SDR_DQ[9]_dup_1 ),
    .diq({open_n1982,open_n1983,open_n1984,\u2_wrrd/Sdr_rd_dout[9]_syn_3 }),
    .bpad(SDR_DQ[9]));  // RTL_1/enc_file/sdr_as_ram.enc.v(42)
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
    SDR_RAS_syn_6 (
    .do({open_n1987,open_n1988,open_n1989,\u2_wrrd/SDR_RAS_n }),
    .osclk(Sdr_clk_dup_1),
    .opad(SDR_RAS));  // RTL_1/enc_file/sdr_as_ram.enc.v(36)
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
    SDR_WE_syn_6 (
    .do({open_n2003,open_n2004,open_n2005,\u2_wrrd/SDR_WE_n }),
    .osclk(Sdr_clk_dup_1),
    .opad(SDR_WE));  // RTL_1/enc_file/sdr_as_ram.enc.v(38)
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DO_DFFMODE("FF"),
    .DO_REGSET("RESET"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .ODDRMODE("OFF"),
    .OUTCEMUX("1"),
    .OUTRSTMUX("RST"),
    .OUTSCLKMUX("CLK"),
    .SRMODE("SYNC"),
    .TSMUX("0"))
    Sdr_busy_syn_6 (
    .do({open_n2019,open_n2020,open_n2021,\u2_wrrd/Sdr_busy_n4 }),
    .osclk(Sdr_clk_dup_1),
    .rst(Rst_dup_175),
    .opad(Sdr_busy));  // RTL_1/enc_file/sdr_as_ram.enc.v(20)
  EG_PHY_PAD #(
    //.HYSTERESIS("OFF"),
    //.PCICLAMP("OFF"),
    .IOTYPE("LVCMOS25"),
    .MODE("IN"),
    .TSMUX("1"))
    Sdr_clk_sft_syn_2 (
    .ipad(Sdr_clk_sft),
    .di(Sdr_clk_sft_dup_1));  // RTL_1/enc_file/sdr_as_ram.enc.v(15)
  EG_PHY_PAD #(
    //.HYSTERESIS("OFF"),
    //.PCICLAMP("OFF"),
    .IOTYPE("LVCMOS25"),
    .MODE("IN"),
    .TSMUX("1"))
    Sdr_clk_syn_2 (
    .ipad(Sdr_clk),
    .di(Sdr_clk_dup_1));  // RTL_1/enc_file/sdr_as_ram.enc.v(14)
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DO_DFFMODE("FF"),
    .DO_REGSET("RESET"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .ODDRMODE("OFF"),
    .OUTCEMUX("CE"),
    .OUTRSTMUX("RST"),
    .OUTSCLKMUX("CLK"),
    .SRMODE("SYNC"),
    .TSMUX("0"))
    Sdr_init_done_syn_6 (
    .ce(\u1_init_ref/sdr_init_cnt [30]),
    .do({open_n2067,open_n2068,open_n2069,1'b1}),
    .osclk(Sdr_clk_dup_1),
    .rst(\u1_init_ref/init_done_n2 ),
    .opad(Sdr_init_done));  // RTL_1/enc_file/sdr_as_ram.enc.v(18)
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .TSMUX("0"))
    Sdr_init_ref_vld_syn_2 (
    .do({open_n2082,open_n2083,open_n2084,Sdr_init_ref_vld_dup_1}),
    .opad(Sdr_init_ref_vld));  // RTL_1/enc_file/sdr_as_ram.enc.v(19)
  buf \Sdr_rd_dout[0]_syn_1  (\Sdr_rd_dout[0]_dup_3 , \u2_wrrd/Sdr_rd_dout[0]_syn_4 );  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .TSMUX("0"))
    \Sdr_rd_dout[0]_syn_4  (
    .do({open_n2099,open_n2100,open_n2101,\Sdr_rd_dout[0]_dup_3 }),
    .opad(Sdr_rd_dout[0]));  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  buf \Sdr_rd_dout[10]_syn_1  (\Sdr_rd_dout[10]_dup_3 , \u2_wrrd/Sdr_rd_dout[10]_syn_4 );  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .TSMUX("0"))
    \Sdr_rd_dout[10]_syn_4  (
    .do({open_n2116,open_n2117,open_n2118,\Sdr_rd_dout[10]_dup_3 }),
    .opad(Sdr_rd_dout[10]));  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  buf \Sdr_rd_dout[11]_syn_1  (\Sdr_rd_dout[11]_dup_3 , \u2_wrrd/Sdr_rd_dout[11]_syn_4 );  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .TSMUX("0"))
    \Sdr_rd_dout[11]_syn_4  (
    .do({open_n2133,open_n2134,open_n2135,\Sdr_rd_dout[11]_dup_3 }),
    .opad(Sdr_rd_dout[11]));  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  buf \Sdr_rd_dout[12]_syn_1  (\Sdr_rd_dout[12]_dup_3 , \u2_wrrd/Sdr_rd_dout[12]_syn_4 );  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .TSMUX("0"))
    \Sdr_rd_dout[12]_syn_4  (
    .do({open_n2150,open_n2151,open_n2152,\Sdr_rd_dout[12]_dup_3 }),
    .opad(Sdr_rd_dout[12]));  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  buf \Sdr_rd_dout[13]_syn_1  (\Sdr_rd_dout[13]_dup_3 , \u2_wrrd/Sdr_rd_dout[13]_syn_4 );  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .TSMUX("0"))
    \Sdr_rd_dout[13]_syn_4  (
    .do({open_n2167,open_n2168,open_n2169,\Sdr_rd_dout[13]_dup_3 }),
    .opad(Sdr_rd_dout[13]));  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  buf \Sdr_rd_dout[14]_syn_1  (\Sdr_rd_dout[14]_dup_3 , \u2_wrrd/Sdr_rd_dout[14]_syn_4 );  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .TSMUX("0"))
    \Sdr_rd_dout[14]_syn_4  (
    .do({open_n2184,open_n2185,open_n2186,\Sdr_rd_dout[14]_dup_3 }),
    .opad(Sdr_rd_dout[14]));  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  buf \Sdr_rd_dout[15]_syn_1  (\Sdr_rd_dout[15]_dup_3 , \u2_wrrd/Sdr_rd_dout[15]_syn_4 );  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .TSMUX("0"))
    \Sdr_rd_dout[15]_syn_4  (
    .do({open_n2201,open_n2202,open_n2203,\Sdr_rd_dout[15]_dup_3 }),
    .opad(Sdr_rd_dout[15]));  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  buf \Sdr_rd_dout[16]_syn_1  (\Sdr_rd_dout[16]_dup_3 , \u2_wrrd/Sdr_rd_dout[16]_syn_4 );  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .TSMUX("0"))
    \Sdr_rd_dout[16]_syn_4  (
    .do({open_n2218,open_n2219,open_n2220,\Sdr_rd_dout[16]_dup_3 }),
    .opad(Sdr_rd_dout[16]));  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  buf \Sdr_rd_dout[17]_syn_1  (\Sdr_rd_dout[17]_dup_3 , \u2_wrrd/Sdr_rd_dout[17]_syn_4 );  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .TSMUX("0"))
    \Sdr_rd_dout[17]_syn_4  (
    .do({open_n2235,open_n2236,open_n2237,\Sdr_rd_dout[17]_dup_3 }),
    .opad(Sdr_rd_dout[17]));  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  buf \Sdr_rd_dout[18]_syn_1  (\Sdr_rd_dout[18]_dup_3 , \u2_wrrd/Sdr_rd_dout[18]_syn_4 );  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .TSMUX("0"))
    \Sdr_rd_dout[18]_syn_4  (
    .do({open_n2252,open_n2253,open_n2254,\Sdr_rd_dout[18]_dup_3 }),
    .opad(Sdr_rd_dout[18]));  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  buf \Sdr_rd_dout[19]_syn_1  (\Sdr_rd_dout[19]_dup_3 , \u2_wrrd/Sdr_rd_dout[19]_syn_4 );  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .TSMUX("0"))
    \Sdr_rd_dout[19]_syn_4  (
    .do({open_n2269,open_n2270,open_n2271,\Sdr_rd_dout[19]_dup_3 }),
    .opad(Sdr_rd_dout[19]));  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  buf \Sdr_rd_dout[1]_syn_1  (\Sdr_rd_dout[1]_dup_3 , \u2_wrrd/Sdr_rd_dout[1]_syn_4 );  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .TSMUX("0"))
    \Sdr_rd_dout[1]_syn_4  (
    .do({open_n2286,open_n2287,open_n2288,\Sdr_rd_dout[1]_dup_3 }),
    .opad(Sdr_rd_dout[1]));  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  buf \Sdr_rd_dout[20]_syn_1  (\Sdr_rd_dout[20]_dup_3 , \u2_wrrd/Sdr_rd_dout[20]_syn_4 );  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .TSMUX("0"))
    \Sdr_rd_dout[20]_syn_4  (
    .do({open_n2303,open_n2304,open_n2305,\Sdr_rd_dout[20]_dup_3 }),
    .opad(Sdr_rd_dout[20]));  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  buf \Sdr_rd_dout[21]_syn_1  (\Sdr_rd_dout[21]_dup_3 , \u2_wrrd/Sdr_rd_dout[21]_syn_4 );  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .TSMUX("0"))
    \Sdr_rd_dout[21]_syn_4  (
    .do({open_n2320,open_n2321,open_n2322,\Sdr_rd_dout[21]_dup_3 }),
    .opad(Sdr_rd_dout[21]));  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  buf \Sdr_rd_dout[22]_syn_1  (\Sdr_rd_dout[22]_dup_3 , \u2_wrrd/Sdr_rd_dout[22]_syn_4 );  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .TSMUX("0"))
    \Sdr_rd_dout[22]_syn_4  (
    .do({open_n2337,open_n2338,open_n2339,\Sdr_rd_dout[22]_dup_3 }),
    .opad(Sdr_rd_dout[22]));  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  buf \Sdr_rd_dout[23]_syn_1  (\Sdr_rd_dout[23]_dup_3 , \u2_wrrd/Sdr_rd_dout[23]_syn_4 );  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .TSMUX("0"))
    \Sdr_rd_dout[23]_syn_4  (
    .do({open_n2354,open_n2355,open_n2356,\Sdr_rd_dout[23]_dup_3 }),
    .opad(Sdr_rd_dout[23]));  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  buf \Sdr_rd_dout[24]_syn_1  (\Sdr_rd_dout[24]_dup_3 , \u2_wrrd/Sdr_rd_dout[24]_syn_4 );  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .TSMUX("0"))
    \Sdr_rd_dout[24]_syn_4  (
    .do({open_n2371,open_n2372,open_n2373,\Sdr_rd_dout[24]_dup_3 }),
    .opad(Sdr_rd_dout[24]));  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  buf \Sdr_rd_dout[25]_syn_1  (\Sdr_rd_dout[25]_dup_3 , \u2_wrrd/Sdr_rd_dout[25]_syn_4 );  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .TSMUX("0"))
    \Sdr_rd_dout[25]_syn_4  (
    .do({open_n2388,open_n2389,open_n2390,\Sdr_rd_dout[25]_dup_3 }),
    .opad(Sdr_rd_dout[25]));  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  buf \Sdr_rd_dout[26]_syn_1  (\Sdr_rd_dout[26]_dup_3 , \u2_wrrd/Sdr_rd_dout[26]_syn_4 );  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .TSMUX("0"))
    \Sdr_rd_dout[26]_syn_4  (
    .do({open_n2405,open_n2406,open_n2407,\Sdr_rd_dout[26]_dup_3 }),
    .opad(Sdr_rd_dout[26]));  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  buf \Sdr_rd_dout[27]_syn_1  (\Sdr_rd_dout[27]_dup_3 , \u2_wrrd/Sdr_rd_dout[27]_syn_4 );  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .TSMUX("0"))
    \Sdr_rd_dout[27]_syn_4  (
    .do({open_n2422,open_n2423,open_n2424,\Sdr_rd_dout[27]_dup_3 }),
    .opad(Sdr_rd_dout[27]));  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  buf \Sdr_rd_dout[28]_syn_1  (\Sdr_rd_dout[28]_dup_3 , \u2_wrrd/Sdr_rd_dout[28]_syn_4 );  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .TSMUX("0"))
    \Sdr_rd_dout[28]_syn_4  (
    .do({open_n2439,open_n2440,open_n2441,\Sdr_rd_dout[28]_dup_3 }),
    .opad(Sdr_rd_dout[28]));  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  buf \Sdr_rd_dout[29]_syn_1  (\Sdr_rd_dout[29]_dup_3 , \u2_wrrd/Sdr_rd_dout[29]_syn_4 );  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .TSMUX("0"))
    \Sdr_rd_dout[29]_syn_4  (
    .do({open_n2456,open_n2457,open_n2458,\Sdr_rd_dout[29]_dup_3 }),
    .opad(Sdr_rd_dout[29]));  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  buf \Sdr_rd_dout[2]_syn_1  (\Sdr_rd_dout[2]_dup_3 , \u2_wrrd/Sdr_rd_dout[2]_syn_4 );  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .TSMUX("0"))
    \Sdr_rd_dout[2]_syn_4  (
    .do({open_n2473,open_n2474,open_n2475,\Sdr_rd_dout[2]_dup_3 }),
    .opad(Sdr_rd_dout[2]));  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  buf \Sdr_rd_dout[30]_syn_1  (\Sdr_rd_dout[30]_dup_3 , \u2_wrrd/Sdr_rd_dout[30]_syn_4 );  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .TSMUX("0"))
    \Sdr_rd_dout[30]_syn_4  (
    .do({open_n2490,open_n2491,open_n2492,\Sdr_rd_dout[30]_dup_3 }),
    .opad(Sdr_rd_dout[30]));  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  buf \Sdr_rd_dout[31]_syn_1  (\Sdr_rd_dout[31]_dup_3 , \u2_wrrd/Sdr_rd_dout[31]_syn_4 );  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .TSMUX("0"))
    \Sdr_rd_dout[31]_syn_4  (
    .do({open_n2507,open_n2508,open_n2509,\Sdr_rd_dout[31]_dup_3 }),
    .opad(Sdr_rd_dout[31]));  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  buf \Sdr_rd_dout[3]_syn_1  (\Sdr_rd_dout[3]_dup_3 , \u2_wrrd/Sdr_rd_dout[3]_syn_4 );  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .TSMUX("0"))
    \Sdr_rd_dout[3]_syn_4  (
    .do({open_n2524,open_n2525,open_n2526,\Sdr_rd_dout[3]_dup_3 }),
    .opad(Sdr_rd_dout[3]));  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  buf \Sdr_rd_dout[4]_syn_1  (\Sdr_rd_dout[4]_dup_3 , \u2_wrrd/Sdr_rd_dout[4]_syn_4 );  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .TSMUX("0"))
    \Sdr_rd_dout[4]_syn_4  (
    .do({open_n2541,open_n2542,open_n2543,\Sdr_rd_dout[4]_dup_3 }),
    .opad(Sdr_rd_dout[4]));  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  buf \Sdr_rd_dout[5]_syn_1  (\Sdr_rd_dout[5]_dup_3 , \u2_wrrd/Sdr_rd_dout[5]_syn_4 );  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .TSMUX("0"))
    \Sdr_rd_dout[5]_syn_4  (
    .do({open_n2558,open_n2559,open_n2560,\Sdr_rd_dout[5]_dup_3 }),
    .opad(Sdr_rd_dout[5]));  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  buf \Sdr_rd_dout[6]_syn_1  (\Sdr_rd_dout[6]_dup_3 , \u2_wrrd/Sdr_rd_dout[6]_syn_4 );  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .TSMUX("0"))
    \Sdr_rd_dout[6]_syn_4  (
    .do({open_n2575,open_n2576,open_n2577,\Sdr_rd_dout[6]_dup_3 }),
    .opad(Sdr_rd_dout[6]));  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  buf \Sdr_rd_dout[7]_syn_1  (\Sdr_rd_dout[7]_dup_3 , \u2_wrrd/Sdr_rd_dout[7]_syn_4 );  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .TSMUX("0"))
    \Sdr_rd_dout[7]_syn_4  (
    .do({open_n2592,open_n2593,open_n2594,\Sdr_rd_dout[7]_dup_3 }),
    .opad(Sdr_rd_dout[7]));  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  buf \Sdr_rd_dout[8]_syn_1  (\Sdr_rd_dout[8]_dup_3 , \u2_wrrd/Sdr_rd_dout[8]_syn_4 );  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .TSMUX("0"))
    \Sdr_rd_dout[8]_syn_4  (
    .do({open_n2609,open_n2610,open_n2611,\Sdr_rd_dout[8]_dup_3 }),
    .opad(Sdr_rd_dout[8]));  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  buf \Sdr_rd_dout[9]_syn_1  (\Sdr_rd_dout[9]_dup_3 , \u2_wrrd/Sdr_rd_dout[9]_syn_4 );  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .TSMUX("0"))
    \Sdr_rd_dout[9]_syn_4  (
    .do({open_n2626,open_n2627,open_n2628,\Sdr_rd_dout[9]_dup_3 }),
    .opad(Sdr_rd_dout[9]));  // RTL_1/enc_file/sdr_as_ram.enc.v(32)
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
    Sdr_rd_en_syn_6 (
    .do({open_n2643,open_n2644,open_n2645,\u2_wrrd/app_rd_en_sft [9]}),
    .osclk(Sdr_clk_dup_1),
    .opad(Sdr_rd_en));  // RTL_1/enc_file/sdr_as_ram.enc.v(31)
  EG_PHY_CONFIG #(
    .DONE_PERSISTN("ENABLE"),
    .INIT_PERSISTN("ENABLE"),
    .JTAG_PERSISTN("DISABLE"),
    .PROGRAMN_PERSISTN("DISABLE"))
    config_inst ();
  AL_DFF_X \u1_init_ref/ad_reg[10]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/ad_reg[10]_syn_4 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u1_init_ref/Sdr_init_ref_addr [10]));
  AL_MAP_LUT4 #(
    .EQN("(~C*~(~A*~(D*~B)))"),
    .INIT(16'h0b0a))
    \u1_init_ref/ad_reg[10]_syn_5  (
    .a(\u1_init_ref/ras_reg_syn_5 ),
    .b(\u1_init_ref/ras_reg_syn_7 ),
    .c(Rst_dup_175),
    .d(\u1_init_ref/Sdr_init_ref_addr [10]),
    .o(\u1_init_ref/ad_reg[10]_syn_4 ));
  AL_DFF_X \u1_init_ref/ad_reg[1]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/ad_reg[1]_syn_4 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u1_init_ref/Sdr_init_ref_addr [1]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(~C*~B))"),
    .INIT(8'ha8))
    \u1_init_ref/ad_reg[1]_syn_5  (
    .a(\u1_init_ref/cas_reg_syn_5 ),
    .b(\u1_init_ref/ras_reg_syn_7 ),
    .c(\u1_init_ref/Sdr_init_ref_addr [1]),
    .o(\u1_init_ref/ad_reg[1]_syn_4 ));
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    \u1_init_ref/add1_syn_17  (
    .a(1'b0),
    .o({\u1_init_ref/add1_syn_91 ,open_n2707}));  // RTL_1/enc_file/sdr_init_ref.enc.v(61)
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1_init_ref/add1_syn_18  (
    .a(\u1_init_ref/pwr_200ms_cnt [0]),
    .b(1'b1),
    .c(\u1_init_ref/add1_syn_91 ),
    .o({\u1_init_ref/add1_syn_92 ,open_n2708}));  // RTL_1/enc_file/sdr_init_ref.enc.v(61)
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1_init_ref/add1_syn_19  (
    .a(\u1_init_ref/pwr_200ms_cnt [1]),
    .b(1'b0),
    .c(\u1_init_ref/add1_syn_92 ),
    .o({\u1_init_ref/add1_syn_93 ,\u1_init_ref/pwr_200ms_cnt_b3 [1]}));  // RTL_1/enc_file/sdr_init_ref.enc.v(61)
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1_init_ref/add1_syn_20  (
    .a(\u1_init_ref/pwr_200ms_cnt [2]),
    .b(1'b0),
    .c(\u1_init_ref/add1_syn_93 ),
    .o({\u1_init_ref/add1_syn_94 ,\u1_init_ref/pwr_200ms_cnt_b3 [2]}));  // RTL_1/enc_file/sdr_init_ref.enc.v(61)
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1_init_ref/add1_syn_21  (
    .a(\u1_init_ref/pwr_200ms_cnt [3]),
    .b(1'b0),
    .c(\u1_init_ref/add1_syn_94 ),
    .o({\u1_init_ref/add1_syn_95 ,\u1_init_ref/pwr_200ms_cnt_b3 [3]}));  // RTL_1/enc_file/sdr_init_ref.enc.v(61)
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1_init_ref/add1_syn_22  (
    .a(\u1_init_ref/pwr_200ms_cnt [4]),
    .b(1'b0),
    .c(\u1_init_ref/add1_syn_95 ),
    .o({\u1_init_ref/add1_syn_96 ,\u1_init_ref/pwr_200ms_cnt_b3 [4]}));  // RTL_1/enc_file/sdr_init_ref.enc.v(61)
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1_init_ref/add1_syn_23  (
    .a(\u1_init_ref/pwr_200ms_cnt [5]),
    .b(1'b0),
    .c(\u1_init_ref/add1_syn_96 ),
    .o({\u1_init_ref/add1_syn_97 ,\u1_init_ref/pwr_200ms_cnt_b3 [5]}));  // RTL_1/enc_file/sdr_init_ref.enc.v(61)
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1_init_ref/add1_syn_24  (
    .a(\u1_init_ref/pwr_200ms_cnt [6]),
    .b(1'b0),
    .c(\u1_init_ref/add1_syn_97 ),
    .o({\u1_init_ref/add1_syn_98 ,\u1_init_ref/pwr_200ms_cnt_b3 [6]}));  // RTL_1/enc_file/sdr_init_ref.enc.v(61)
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1_init_ref/add1_syn_25  (
    .a(\u1_init_ref/pwr_200ms_cnt [7]),
    .b(1'b0),
    .c(\u1_init_ref/add1_syn_98 ),
    .o({\u1_init_ref/add1_syn_99 ,\u1_init_ref/pwr_200ms_cnt_b3 [7]}));  // RTL_1/enc_file/sdr_init_ref.enc.v(61)
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1_init_ref/add1_syn_26  (
    .a(\u1_init_ref/pwr_200ms_cnt [8]),
    .b(1'b0),
    .c(\u1_init_ref/add1_syn_99 ),
    .o({\u1_init_ref/add1_syn_100 ,\u1_init_ref/pwr_200ms_cnt_b3 [8]}));  // RTL_1/enc_file/sdr_init_ref.enc.v(61)
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1_init_ref/add1_syn_27  (
    .a(\u1_init_ref/pwr_200ms_cnt [9]),
    .b(1'b0),
    .c(\u1_init_ref/add1_syn_100 ),
    .o({\u1_init_ref/add1_syn_101 ,\u1_init_ref/pwr_200ms_cnt_b3 [9]}));  // RTL_1/enc_file/sdr_init_ref.enc.v(61)
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1_init_ref/add1_syn_28  (
    .a(\u1_init_ref/pwr_200ms_cnt [10]),
    .b(1'b0),
    .c(\u1_init_ref/add1_syn_101 ),
    .o({\u1_init_ref/add1_syn_102 ,\u1_init_ref/pwr_200ms_cnt_b3 [10]}));  // RTL_1/enc_file/sdr_init_ref.enc.v(61)
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1_init_ref/add1_syn_29  (
    .a(\u1_init_ref/pwr_200ms_cnt [11]),
    .b(1'b0),
    .c(\u1_init_ref/add1_syn_102 ),
    .o({\u1_init_ref/add1_syn_103 ,\u1_init_ref/pwr_200ms_cnt_b3 [11]}));  // RTL_1/enc_file/sdr_init_ref.enc.v(61)
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1_init_ref/add1_syn_30  (
    .a(\u1_init_ref/pwr_200ms_cnt [12]),
    .b(1'b0),
    .c(\u1_init_ref/add1_syn_103 ),
    .o({\u1_init_ref/add1_syn_104 ,\u1_init_ref/pwr_200ms_cnt_b3 [12]}));  // RTL_1/enc_file/sdr_init_ref.enc.v(61)
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1_init_ref/add1_syn_31  (
    .a(\u1_init_ref/pwr_200ms_cnt [13]),
    .b(1'b0),
    .c(\u1_init_ref/add1_syn_104 ),
    .o({\u1_init_ref/add1_syn_105 ,\u1_init_ref/pwr_200ms_cnt_b3 [13]}));  // RTL_1/enc_file/sdr_init_ref.enc.v(61)
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1_init_ref/add1_syn_32  (
    .a(\u1_init_ref/pwr_200ms_cnt [14]),
    .b(1'b0),
    .c(\u1_init_ref/add1_syn_105 ),
    .o({\u1_init_ref/add1_syn_106 ,\u1_init_ref/pwr_200ms_cnt_b3 [14]}));  // RTL_1/enc_file/sdr_init_ref.enc.v(61)
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1_init_ref/add1_syn_33  (
    .a(\u1_init_ref/pwr_200ms_cnt [15]),
    .b(1'b0),
    .c(\u1_init_ref/add1_syn_106 ),
    .o({\u1_init_ref/add1_syn_107 ,\u1_init_ref/pwr_200ms_cnt_b3 [15]}));  // RTL_1/enc_file/sdr_init_ref.enc.v(61)
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1_init_ref/add1_syn_34  (
    .a(\u1_init_ref/pwr_200ms_cnt [16]),
    .b(1'b0),
    .c(\u1_init_ref/add1_syn_107 ),
    .o({\u1_init_ref/add1_syn_108 ,\u1_init_ref/pwr_200ms_cnt_b3 [16]}));  // RTL_1/enc_file/sdr_init_ref.enc.v(61)
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    \u1_init_ref/add1_syn_35  (
    .a(\u1_init_ref/pwr_200ms_cnt [17]),
    .b(1'b0),
    .c(\u1_init_ref/add1_syn_108 ),
    .o({open_n2709,\u1_init_ref/pwr_200ms_cnt_b3 [17]}));  // RTL_1/enc_file/sdr_init_ref.enc.v(61)
  AL_DFF_X \u1_init_ref/cas_reg  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/cas_reg_syn_3 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u1_init_ref/Sdr_init_ref_cas ));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C*~B))"),
    .INIT(8'h45))
    \u1_init_ref/cas_reg_syn_4  (
    .a(Rst_dup_175),
    .b(\u1_init_ref/sdr_init_cnt [0]),
    .c(\u1_init_ref/sdr_init_cnt [1]),
    .o(\u1_init_ref/cas_reg_syn_5 ));
  AL_MAP_LUT3 #(
    .EQN("~(B*~(~C*~A))"),
    .INIT(8'h37))
    \u1_init_ref/cas_reg_syn_6  (
    .a(\u1_init_ref/ras_reg_syn_9 ),
    .b(\u1_init_ref/cas_reg_syn_5 ),
    .c(\u1_init_ref/ras_reg_syn_7 ),
    .o(\u1_init_ref/cas_reg_syn_3 ));
  AL_MAP_LUT2 #(
    .EQN("~(~B*~A)"),
    .INIT(4'he))
    \u1_init_ref/init_done_n2_syn_1  (
    .a(Rst_dup_175),
    .b(\u1_init_ref/sdr_init_en ),
    .o(\u1_init_ref/init_done_n2 ));
  AL_DFF_X \u1_init_ref/init_vld_reg  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/init_vld_reg_syn_5 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u1_init_ref/init_vld ));  // RTL_1/enc_file/sdr_init_ref.enc.v(77)
  AL_MAP_LUT4 #(
    .EQN("(~D*~A*~(~C*~B))"),
    .INIT(16'h0054))
    \u1_init_ref/init_vld_reg_syn_6  (
    .a(Rst_dup_175),
    .b(\u1_init_ref/init_vld ),
    .c(\u1_init_ref/sdr_init_cnt [0]),
    .d(\u1_init_ref/sdr_init_cnt [30]),
    .o(\u1_init_ref/init_vld_reg_syn_5 ));  // RTL_1/enc_file/sdr_init_ref.enc.v(77)
  AL_DFF_X \u1_init_ref/power_up_200ms_1d_reg  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/pwr_200ms_cnt [17]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u1_init_ref/power_up_200ms_1d ));  // RTL_1/enc_file/sdr_init_ref.enc.v(54)
  AL_DFF_X \u1_init_ref/power_up_200ms_2d_reg  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/power_up_200ms_1d ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u1_init_ref/power_up_200ms_2d ));  // RTL_1/enc_file/sdr_init_ref.enc.v(54)
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    \u1_init_ref/power_up_en_n_syn_1  (
    .a(\u1_init_ref/power_up_200ms_1d ),
    .b(\u1_init_ref/power_up_200ms_2d ),
    .o(\u1_init_ref/power_up_en_n ));
  AL_DFF_X \u1_init_ref/power_up_en_reg  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/power_up_en_n ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u1_init_ref/power_up_en ));  // RTL_1/enc_file/sdr_init_ref.enc.v(54)
  AL_MAP_LUT1 #(
    .EQN("(~A)"),
    .INIT(2'h1))
    \u1_init_ref/pwr_200ms_cnt[0]_syn_3  (
    .a(\u1_init_ref/pwr_200ms_cnt [0]),
    .o(\u1_init_ref/pwr_200ms_cnt[0]_syn_2 ));  // RTL_1/enc_file/sdr_init_ref.enc.v(38)
  AL_MAP_LUT2 #(
    .EQN("~(~B*~A)"),
    .INIT(4'he))
    \u1_init_ref/pwr_200ms_cnt_b1[17]_syn_1  (
    .a(\u1_init_ref/pwr_200ms_cnt_b3 [17]),
    .b(\u1_init_ref/pwr_200ms_cnt [17]),
    .o(\u1_init_ref/pwr_200ms_cnt_b1 [17]));
  AL_DFF_X \u1_init_ref/pwr_200ms_cnt_reg[0]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/pwr_200ms_cnt[0]_syn_2 ),
    .en(~\u1_init_ref/pwr_200ms_cnt [17]),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u1_init_ref/pwr_200ms_cnt [0]));  // RTL_1/enc_file/sdr_init_ref.enc.v(54)
  AL_DFF_X \u1_init_ref/pwr_200ms_cnt_reg[10]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/pwr_200ms_cnt_b3 [10]),
    .en(~\u1_init_ref/pwr_200ms_cnt [17]),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u1_init_ref/pwr_200ms_cnt [10]));  // RTL_1/enc_file/sdr_init_ref.enc.v(54)
  AL_DFF_X \u1_init_ref/pwr_200ms_cnt_reg[11]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/pwr_200ms_cnt_b3 [11]),
    .en(~\u1_init_ref/pwr_200ms_cnt [17]),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u1_init_ref/pwr_200ms_cnt [11]));  // RTL_1/enc_file/sdr_init_ref.enc.v(54)
  AL_DFF_X \u1_init_ref/pwr_200ms_cnt_reg[12]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/pwr_200ms_cnt_b3 [12]),
    .en(~\u1_init_ref/pwr_200ms_cnt [17]),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u1_init_ref/pwr_200ms_cnt [12]));  // RTL_1/enc_file/sdr_init_ref.enc.v(54)
  AL_DFF_X \u1_init_ref/pwr_200ms_cnt_reg[13]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/pwr_200ms_cnt_b3 [13]),
    .en(~\u1_init_ref/pwr_200ms_cnt [17]),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u1_init_ref/pwr_200ms_cnt [13]));  // RTL_1/enc_file/sdr_init_ref.enc.v(54)
  AL_DFF_X \u1_init_ref/pwr_200ms_cnt_reg[14]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/pwr_200ms_cnt_b3 [14]),
    .en(~\u1_init_ref/pwr_200ms_cnt [17]),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u1_init_ref/pwr_200ms_cnt [14]));  // RTL_1/enc_file/sdr_init_ref.enc.v(54)
  AL_DFF_X \u1_init_ref/pwr_200ms_cnt_reg[15]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/pwr_200ms_cnt_b3 [15]),
    .en(~\u1_init_ref/pwr_200ms_cnt [17]),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u1_init_ref/pwr_200ms_cnt [15]));  // RTL_1/enc_file/sdr_init_ref.enc.v(54)
  AL_DFF_X \u1_init_ref/pwr_200ms_cnt_reg[16]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/pwr_200ms_cnt_b3 [16]),
    .en(~\u1_init_ref/pwr_200ms_cnt [17]),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u1_init_ref/pwr_200ms_cnt [16]));  // RTL_1/enc_file/sdr_init_ref.enc.v(54)
  AL_DFF_X \u1_init_ref/pwr_200ms_cnt_reg[17]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/pwr_200ms_cnt_b1 [17]),
    .en(1'b1),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u1_init_ref/pwr_200ms_cnt [17]));  // RTL_1/enc_file/sdr_init_ref.enc.v(54)
  AL_DFF_X \u1_init_ref/pwr_200ms_cnt_reg[1]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/pwr_200ms_cnt_b3 [1]),
    .en(~\u1_init_ref/pwr_200ms_cnt [17]),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u1_init_ref/pwr_200ms_cnt [1]));  // RTL_1/enc_file/sdr_init_ref.enc.v(54)
  AL_DFF_X \u1_init_ref/pwr_200ms_cnt_reg[2]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/pwr_200ms_cnt_b3 [2]),
    .en(~\u1_init_ref/pwr_200ms_cnt [17]),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u1_init_ref/pwr_200ms_cnt [2]));  // RTL_1/enc_file/sdr_init_ref.enc.v(54)
  AL_DFF_X \u1_init_ref/pwr_200ms_cnt_reg[3]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/pwr_200ms_cnt_b3 [3]),
    .en(~\u1_init_ref/pwr_200ms_cnt [17]),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u1_init_ref/pwr_200ms_cnt [3]));  // RTL_1/enc_file/sdr_init_ref.enc.v(54)
  AL_DFF_X \u1_init_ref/pwr_200ms_cnt_reg[4]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/pwr_200ms_cnt_b3 [4]),
    .en(~\u1_init_ref/pwr_200ms_cnt [17]),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u1_init_ref/pwr_200ms_cnt [4]));  // RTL_1/enc_file/sdr_init_ref.enc.v(54)
  AL_DFF_X \u1_init_ref/pwr_200ms_cnt_reg[5]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/pwr_200ms_cnt_b3 [5]),
    .en(~\u1_init_ref/pwr_200ms_cnt [17]),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u1_init_ref/pwr_200ms_cnt [5]));  // RTL_1/enc_file/sdr_init_ref.enc.v(54)
  AL_DFF_X \u1_init_ref/pwr_200ms_cnt_reg[6]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/pwr_200ms_cnt_b3 [6]),
    .en(~\u1_init_ref/pwr_200ms_cnt [17]),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u1_init_ref/pwr_200ms_cnt [6]));  // RTL_1/enc_file/sdr_init_ref.enc.v(54)
  AL_DFF_X \u1_init_ref/pwr_200ms_cnt_reg[7]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/pwr_200ms_cnt_b3 [7]),
    .en(~\u1_init_ref/pwr_200ms_cnt [17]),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u1_init_ref/pwr_200ms_cnt [7]));  // RTL_1/enc_file/sdr_init_ref.enc.v(54)
  AL_DFF_X \u1_init_ref/pwr_200ms_cnt_reg[8]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/pwr_200ms_cnt_b3 [8]),
    .en(~\u1_init_ref/pwr_200ms_cnt [17]),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u1_init_ref/pwr_200ms_cnt [8]));  // RTL_1/enc_file/sdr_init_ref.enc.v(54)
  AL_DFF_X \u1_init_ref/pwr_200ms_cnt_reg[9]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/pwr_200ms_cnt_b3 [9]),
    .en(~\u1_init_ref/pwr_200ms_cnt [17]),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u1_init_ref/pwr_200ms_cnt [9]));  // RTL_1/enc_file/sdr_init_ref.enc.v(54)
  AL_DFF_X \u1_init_ref/ras_reg  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/ras_reg_syn_3 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u1_init_ref/Sdr_init_ref_ras ));
  AL_MAP_LUT4 #(
    .EQN("~(~D*~(~C*~B*~A))"),
    .INIT(16'hff01))
    \u1_init_ref/ras_reg_syn_10  (
    .a(\u1_init_ref/ras_reg_syn_9 ),
    .b(\u1_init_ref/ras_reg_syn_5 ),
    .c(\u1_init_ref/ras_reg_syn_7 ),
    .d(Rst_dup_175),
    .o(\u1_init_ref/ras_reg_syn_3 ));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    \u1_init_ref/ras_reg_syn_4  (
    .a(\u1_init_ref/sdr_init_cnt [0]),
    .b(\u1_init_ref/sdr_init_cnt [1]),
    .o(\u1_init_ref/ras_reg_syn_5 ));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    \u1_init_ref/ras_reg_syn_6  (
    .a(\u1_init_ref/sdr_init_cnt [7]),
    .b(\u1_init_ref/sdr_init_cnt [8]),
    .o(\u1_init_ref/ras_reg_syn_7 ));
  AL_MAP_LUT4 #(
    .EQN("(D*~C*~B*~A)"),
    .INIT(16'h0100))
    \u1_init_ref/ras_reg_syn_8  (
    .a(App_rd_en_dup_5),
    .b(App_wr_en_dup_5),
    .c(\u2_wrrd/rw_vld ),
    .d(\u1_init_ref/sdr_ref_ack_sft [2]),
    .o(\u1_init_ref/ras_reg_syn_9 ));
  AL_DFF_X \u1_init_ref/ref_vld_reg  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/ref_vld_reg_syn_5 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u1_init_ref/ref_vld ));  // RTL_1/enc_file/sdr_init_ref.enc.v(121)
  AL_MAP_LUT4 #(
    .EQN("(~D*C*~B*~A)"),
    .INIT(16'h0010))
    \u1_init_ref/ref_vld_reg_syn_6  (
    .a(App_rd_en_dup_5),
    .b(App_wr_en_dup_5),
    .c(\u1_init_ref/Sdr_ref_ack ),
    .d(\u2_wrrd/rw_vld ),
    .o(\u1_init_ref/ref_vld_reg_syn_7 ));  // RTL_1/enc_file/sdr_init_ref.enc.v(121)
  AL_MAP_LUT4 #(
    .EQN("(~B*~(~A*~(~D*C)))"),
    .INIT(16'h2232))
    \u1_init_ref/ref_vld_reg_syn_8  (
    .a(\u1_init_ref/ref_vld_reg_syn_7 ),
    .b(Rst_dup_175),
    .c(\u1_init_ref/ref_vld ),
    .d(\u1_init_ref/sdr_ref_ack_sft [19]),
    .o(\u1_init_ref/ref_vld_reg_syn_5 ));  // RTL_1/enc_file/sdr_init_ref.enc.v(121)
  AL_DFF_X #(
    .INIT(1'b0))
    \u1_init_ref/sdr_init_cnt_reg[0]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/sdr_init_en ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u1_init_ref/sdr_init_cnt [0]));  // RTL_1/enc_file/sdr_init_ref.enc.v(71)
  AL_DFF_X #(
    .INIT(1'b0))
    \u1_init_ref/sdr_init_cnt_reg[10]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/sdr_init_cnt [9]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u1_init_ref/sdr_init_cnt [10]));  // RTL_1/enc_file/sdr_init_ref.enc.v(71)
  AL_DFF_X #(
    .INIT(1'b0))
    \u1_init_ref/sdr_init_cnt_reg[11]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/sdr_init_cnt [10]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u1_init_ref/sdr_init_cnt [11]));  // RTL_1/enc_file/sdr_init_ref.enc.v(71)
  AL_DFF_X #(
    .INIT(1'b0))
    \u1_init_ref/sdr_init_cnt_reg[12]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/sdr_init_cnt [11]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u1_init_ref/sdr_init_cnt [12]));  // RTL_1/enc_file/sdr_init_ref.enc.v(71)
  AL_DFF_X #(
    .INIT(1'b0))
    \u1_init_ref/sdr_init_cnt_reg[13]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/sdr_init_cnt [12]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u1_init_ref/sdr_init_cnt [13]));  // RTL_1/enc_file/sdr_init_ref.enc.v(71)
  AL_DFF_X #(
    .INIT(1'b0))
    \u1_init_ref/sdr_init_cnt_reg[14]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/sdr_init_cnt [13]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u1_init_ref/sdr_init_cnt [14]));  // RTL_1/enc_file/sdr_init_ref.enc.v(71)
  AL_DFF_X #(
    .INIT(1'b0))
    \u1_init_ref/sdr_init_cnt_reg[15]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/sdr_init_cnt [14]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u1_init_ref/sdr_init_cnt [15]));  // RTL_1/enc_file/sdr_init_ref.enc.v(71)
  AL_DFF_X #(
    .INIT(1'b0))
    \u1_init_ref/sdr_init_cnt_reg[16]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/sdr_init_cnt [15]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u1_init_ref/sdr_init_cnt [16]));  // RTL_1/enc_file/sdr_init_ref.enc.v(71)
  AL_DFF_X #(
    .INIT(1'b0))
    \u1_init_ref/sdr_init_cnt_reg[17]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/sdr_init_cnt [16]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u1_init_ref/sdr_init_cnt [17]));  // RTL_1/enc_file/sdr_init_ref.enc.v(71)
  AL_DFF_X #(
    .INIT(1'b0))
    \u1_init_ref/sdr_init_cnt_reg[18]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/sdr_init_cnt [17]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u1_init_ref/sdr_init_cnt [18]));  // RTL_1/enc_file/sdr_init_ref.enc.v(71)
  AL_DFF_X #(
    .INIT(1'b0))
    \u1_init_ref/sdr_init_cnt_reg[19]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/sdr_init_cnt [18]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u1_init_ref/sdr_init_cnt [19]));  // RTL_1/enc_file/sdr_init_ref.enc.v(71)
  AL_DFF_X #(
    .INIT(1'b0))
    \u1_init_ref/sdr_init_cnt_reg[1]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/sdr_init_cnt [0]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u1_init_ref/sdr_init_cnt [1]));  // RTL_1/enc_file/sdr_init_ref.enc.v(71)
  AL_DFF_X #(
    .INIT(1'b0))
    \u1_init_ref/sdr_init_cnt_reg[20]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/sdr_init_cnt [19]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u1_init_ref/sdr_init_cnt [20]));  // RTL_1/enc_file/sdr_init_ref.enc.v(71)
  AL_DFF_X #(
    .INIT(1'b0))
    \u1_init_ref/sdr_init_cnt_reg[21]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/sdr_init_cnt [20]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u1_init_ref/sdr_init_cnt [21]));  // RTL_1/enc_file/sdr_init_ref.enc.v(71)
  AL_DFF_X #(
    .INIT(1'b0))
    \u1_init_ref/sdr_init_cnt_reg[22]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/sdr_init_cnt [21]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u1_init_ref/sdr_init_cnt [22]));  // RTL_1/enc_file/sdr_init_ref.enc.v(71)
  AL_DFF_X #(
    .INIT(1'b0))
    \u1_init_ref/sdr_init_cnt_reg[23]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/sdr_init_cnt [22]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u1_init_ref/sdr_init_cnt [23]));  // RTL_1/enc_file/sdr_init_ref.enc.v(71)
  AL_DFF_X #(
    .INIT(1'b0))
    \u1_init_ref/sdr_init_cnt_reg[24]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/sdr_init_cnt [23]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u1_init_ref/sdr_init_cnt [24]));  // RTL_1/enc_file/sdr_init_ref.enc.v(71)
  AL_DFF_X #(
    .INIT(1'b0))
    \u1_init_ref/sdr_init_cnt_reg[25]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/sdr_init_cnt [24]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u1_init_ref/sdr_init_cnt [25]));  // RTL_1/enc_file/sdr_init_ref.enc.v(71)
  AL_DFF_X #(
    .INIT(1'b0))
    \u1_init_ref/sdr_init_cnt_reg[26]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/sdr_init_cnt [25]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u1_init_ref/sdr_init_cnt [26]));  // RTL_1/enc_file/sdr_init_ref.enc.v(71)
  AL_DFF_X #(
    .INIT(1'b0))
    \u1_init_ref/sdr_init_cnt_reg[27]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/sdr_init_cnt [26]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u1_init_ref/sdr_init_cnt [27]));  // RTL_1/enc_file/sdr_init_ref.enc.v(71)
  AL_DFF_X #(
    .INIT(1'b0))
    \u1_init_ref/sdr_init_cnt_reg[28]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/sdr_init_cnt [27]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u1_init_ref/sdr_init_cnt [28]));  // RTL_1/enc_file/sdr_init_ref.enc.v(71)
  AL_DFF_X #(
    .INIT(1'b0))
    \u1_init_ref/sdr_init_cnt_reg[29]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/sdr_init_cnt [28]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u1_init_ref/sdr_init_cnt [29]));  // RTL_1/enc_file/sdr_init_ref.enc.v(71)
  AL_DFF_X #(
    .INIT(1'b0))
    \u1_init_ref/sdr_init_cnt_reg[2]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/sdr_init_cnt [1]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u1_init_ref/sdr_init_cnt [2]));  // RTL_1/enc_file/sdr_init_ref.enc.v(71)
  AL_DFF_X #(
    .INIT(1'b0))
    \u1_init_ref/sdr_init_cnt_reg[30]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/sdr_init_cnt [29]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u1_init_ref/sdr_init_cnt [30]));  // RTL_1/enc_file/sdr_init_ref.enc.v(71)
  AL_DFF_X #(
    .INIT(1'b0))
    \u1_init_ref/sdr_init_cnt_reg[3]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/sdr_init_cnt [2]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u1_init_ref/sdr_init_cnt [3]));  // RTL_1/enc_file/sdr_init_ref.enc.v(71)
  AL_DFF_X #(
    .INIT(1'b0))
    \u1_init_ref/sdr_init_cnt_reg[4]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/sdr_init_cnt [3]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u1_init_ref/sdr_init_cnt [4]));  // RTL_1/enc_file/sdr_init_ref.enc.v(71)
  AL_DFF_X #(
    .INIT(1'b0))
    \u1_init_ref/sdr_init_cnt_reg[5]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/sdr_init_cnt [4]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u1_init_ref/sdr_init_cnt [5]));  // RTL_1/enc_file/sdr_init_ref.enc.v(71)
  AL_DFF_X #(
    .INIT(1'b0))
    \u1_init_ref/sdr_init_cnt_reg[6]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/sdr_init_cnt [5]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u1_init_ref/sdr_init_cnt [6]));  // RTL_1/enc_file/sdr_init_ref.enc.v(71)
  AL_DFF_X #(
    .INIT(1'b0))
    \u1_init_ref/sdr_init_cnt_reg[7]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/sdr_init_cnt [6]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u1_init_ref/sdr_init_cnt [7]));  // RTL_1/enc_file/sdr_init_ref.enc.v(71)
  AL_DFF_X #(
    .INIT(1'b0))
    \u1_init_ref/sdr_init_cnt_reg[8]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/sdr_init_cnt [7]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u1_init_ref/sdr_init_cnt [8]));  // RTL_1/enc_file/sdr_init_ref.enc.v(71)
  AL_DFF_X #(
    .INIT(1'b0))
    \u1_init_ref/sdr_init_cnt_reg[9]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/sdr_init_cnt [8]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u1_init_ref/sdr_init_cnt [9]));  // RTL_1/enc_file/sdr_init_ref.enc.v(71)
  AL_DFF_X \u1_init_ref/sdr_init_en_reg  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/power_up_en ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u1_init_ref/sdr_init_en ));  // RTL_1/enc_file/sdr_init_ref.enc.v(54)
  AL_DFF_X \u1_init_ref/sdr_ref_ack_sft_reg[0]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/Sdr_ref_ack ),
    .en(1'b1),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u1_init_ref/sdr_ref_ack_sft [0]));  // RTL_1/enc_file/sdr_init_ref.enc.v(108)
  AL_DFF_X \u1_init_ref/sdr_ref_ack_sft_reg[10]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/sdr_ref_ack_sft [9]),
    .en(1'b1),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u1_init_ref/sdr_ref_ack_sft [10]));  // RTL_1/enc_file/sdr_init_ref.enc.v(108)
  AL_DFF_X \u1_init_ref/sdr_ref_ack_sft_reg[11]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/sdr_ref_ack_sft [10]),
    .en(1'b1),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u1_init_ref/sdr_ref_ack_sft [11]));  // RTL_1/enc_file/sdr_init_ref.enc.v(108)
  AL_DFF_X \u1_init_ref/sdr_ref_ack_sft_reg[12]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/sdr_ref_ack_sft [11]),
    .en(1'b1),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u1_init_ref/sdr_ref_ack_sft [12]));  // RTL_1/enc_file/sdr_init_ref.enc.v(108)
  AL_DFF_X \u1_init_ref/sdr_ref_ack_sft_reg[13]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/sdr_ref_ack_sft [12]),
    .en(1'b1),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u1_init_ref/sdr_ref_ack_sft [13]));  // RTL_1/enc_file/sdr_init_ref.enc.v(108)
  AL_DFF_X \u1_init_ref/sdr_ref_ack_sft_reg[14]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/sdr_ref_ack_sft [13]),
    .en(1'b1),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u1_init_ref/sdr_ref_ack_sft [14]));  // RTL_1/enc_file/sdr_init_ref.enc.v(108)
  AL_DFF_X \u1_init_ref/sdr_ref_ack_sft_reg[15]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/sdr_ref_ack_sft [14]),
    .en(1'b1),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u1_init_ref/sdr_ref_ack_sft [15]));  // RTL_1/enc_file/sdr_init_ref.enc.v(108)
  AL_DFF_X \u1_init_ref/sdr_ref_ack_sft_reg[16]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/sdr_ref_ack_sft [15]),
    .en(1'b1),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u1_init_ref/sdr_ref_ack_sft [16]));  // RTL_1/enc_file/sdr_init_ref.enc.v(108)
  AL_DFF_X \u1_init_ref/sdr_ref_ack_sft_reg[17]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/sdr_ref_ack_sft [16]),
    .en(1'b1),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u1_init_ref/sdr_ref_ack_sft [17]));  // RTL_1/enc_file/sdr_init_ref.enc.v(108)
  AL_DFF_X \u1_init_ref/sdr_ref_ack_sft_reg[18]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/sdr_ref_ack_sft [17]),
    .en(1'b1),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u1_init_ref/sdr_ref_ack_sft [18]));  // RTL_1/enc_file/sdr_init_ref.enc.v(108)
  AL_DFF_X \u1_init_ref/sdr_ref_ack_sft_reg[19]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/sdr_ref_ack_sft [18]),
    .en(1'b1),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u1_init_ref/sdr_ref_ack_sft [19]));  // RTL_1/enc_file/sdr_init_ref.enc.v(108)
  AL_DFF_X \u1_init_ref/sdr_ref_ack_sft_reg[1]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/sdr_ref_ack_sft [0]),
    .en(1'b1),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u1_init_ref/sdr_ref_ack_sft [1]));  // RTL_1/enc_file/sdr_init_ref.enc.v(108)
  AL_DFF_X \u1_init_ref/sdr_ref_ack_sft_reg[2]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/sdr_ref_ack_sft [1]),
    .en(1'b1),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u1_init_ref/sdr_ref_ack_sft [2]));  // RTL_1/enc_file/sdr_init_ref.enc.v(108)
  AL_DFF_X \u1_init_ref/sdr_ref_ack_sft_reg[3]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/sdr_ref_ack_sft [2]),
    .en(1'b1),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u1_init_ref/sdr_ref_ack_sft [3]));  // RTL_1/enc_file/sdr_init_ref.enc.v(108)
  AL_DFF_X \u1_init_ref/sdr_ref_ack_sft_reg[4]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/sdr_ref_ack_sft [3]),
    .en(1'b1),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u1_init_ref/sdr_ref_ack_sft [4]));  // RTL_1/enc_file/sdr_init_ref.enc.v(108)
  AL_DFF_X \u1_init_ref/sdr_ref_ack_sft_reg[5]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/sdr_ref_ack_sft [4]),
    .en(1'b1),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u1_init_ref/sdr_ref_ack_sft [5]));  // RTL_1/enc_file/sdr_init_ref.enc.v(108)
  AL_DFF_X \u1_init_ref/sdr_ref_ack_sft_reg[6]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/sdr_ref_ack_sft [5]),
    .en(1'b1),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u1_init_ref/sdr_ref_ack_sft [6]));  // RTL_1/enc_file/sdr_init_ref.enc.v(108)
  AL_DFF_X \u1_init_ref/sdr_ref_ack_sft_reg[7]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/sdr_ref_ack_sft [6]),
    .en(1'b1),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u1_init_ref/sdr_ref_ack_sft [7]));  // RTL_1/enc_file/sdr_init_ref.enc.v(108)
  AL_DFF_X \u1_init_ref/sdr_ref_ack_sft_reg[8]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/sdr_ref_ack_sft [7]),
    .en(1'b1),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u1_init_ref/sdr_ref_ack_sft [8]));  // RTL_1/enc_file/sdr_init_ref.enc.v(108)
  AL_DFF_X \u1_init_ref/sdr_ref_ack_sft_reg[9]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/sdr_ref_ack_sft [8]),
    .en(1'b1),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u1_init_ref/sdr_ref_ack_sft [9]));  // RTL_1/enc_file/sdr_init_ref.enc.v(108)
  AL_DFF_X \u1_init_ref/we_reg  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u1_init_ref/we_reg_syn_3 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u1_init_ref/Sdr_init_ref_we ));
  AL_MAP_LUT3 #(
    .EQN("~(~C*~(~B*~A))"),
    .INIT(8'hf1))
    \u1_init_ref/we_reg_syn_4  (
    .a(\u1_init_ref/ras_reg_syn_5 ),
    .b(\u1_init_ref/ras_reg_syn_7 ),
    .c(Rst_dup_175),
    .o(\u1_init_ref/we_reg_syn_3 ));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    \u2_wrrd/SDR_ADDR_b[10]_syn_1  (
    .a(\u2_wrrd/rw_vld ),
    .b(\u1_init_ref/Sdr_init_ref_addr [10]),
    .c(\u2_wrrd/addr [10]),
    .o(\u2_wrrd/SDR_ADDR_b [10]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    \u2_wrrd/SDR_ADDR_b[1]_syn_1  (
    .a(\u2_wrrd/rw_vld ),
    .b(\u1_init_ref/Sdr_init_ref_addr [1]),
    .c(\u2_wrrd/addr [1]),
    .o(\u2_wrrd/SDR_ADDR_b [1]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    \u2_wrrd/SDR_ADDR_b[4]_syn_1  (
    .a(\u2_wrrd/rw_vld ),
    .b(\u1_init_ref/Sdr_init_ref_addr [1]),
    .c(\u2_wrrd/addr [4]),
    .o(\u2_wrrd/SDR_ADDR_b [4]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    \u2_wrrd/SDR_ADDR_b[5]_syn_1  (
    .a(\u2_wrrd/rw_vld ),
    .b(\u1_init_ref/Sdr_init_ref_addr [1]),
    .c(\u2_wrrd/addr [5]),
    .o(\u2_wrrd/SDR_ADDR_b [5]));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    \u2_wrrd/SDR_CAS_n_syn_1  (
    .a(\u1_init_ref/Sdr_init_ref_cas ),
    .b(\u2_wrrd/cas ),
    .c(\u2_wrrd/rw_vld ),
    .o(\u2_wrrd/SDR_CAS_n ));
  AL_MAP_LUT3 #(
    .EQN("(A*~(B)*~(C)+A*B*~(C)+~(A)*B*C+A*B*C)"),
    .INIT(8'hca))
    \u2_wrrd/SDR_RAS_n_syn_1  (
    .a(\u1_init_ref/Sdr_init_ref_ras ),
    .b(\u2_wrrd/ras ),
    .c(\u2_wrrd/rw_vld ),
    .o(\u2_wrrd/SDR_RAS_n ));
  AL_MAP_LUT3 #(
    .EQN("(A*~(C)*~(B)+A*C*~(B)+~(A)*C*B+A*C*B)"),
    .INIT(8'he2))
    \u2_wrrd/SDR_WE_n_syn_1  (
    .a(\u1_init_ref/Sdr_init_ref_we ),
    .b(\u2_wrrd/rw_vld ),
    .c(\u2_wrrd/we ),
    .o(\u2_wrrd/SDR_WE_n ));
  AL_MAP_LUT2 #(
    .EQN("~(~B*~A)"),
    .INIT(4'he))
    \u2_wrrd/Sdr_busy_n4_syn_1  (
    .a(\u2_wrrd/state_reg_syn_1 [1]),
    .b(\u2_wrrd/state_reg_syn_1 [2]),
    .o(\u2_wrrd/Sdr_busy_n4 ));
  buf \u2_wrrd/Sdr_rd_dout[0]_syn_1  (\u2_wrrd/Sdr_rd_dout [0], \u2_wrrd/Sdr_rd_dout[0]_syn_3 );
  buf \u2_wrrd/Sdr_rd_dout[0]_syn_2  (\u2_wrrd/Sdr_rd_dout[0]_syn_4 , \u2_wrrd/Sdr_rd_dout [0]);
  buf \u2_wrrd/Sdr_rd_dout[10]_syn_1  (\u2_wrrd/Sdr_rd_dout [10], \u2_wrrd/Sdr_rd_dout[10]_syn_3 );
  buf \u2_wrrd/Sdr_rd_dout[10]_syn_2  (\u2_wrrd/Sdr_rd_dout[10]_syn_4 , \u2_wrrd/Sdr_rd_dout [10]);
  buf \u2_wrrd/Sdr_rd_dout[11]_syn_1  (\u2_wrrd/Sdr_rd_dout [11], \u2_wrrd/Sdr_rd_dout[11]_syn_3 );
  buf \u2_wrrd/Sdr_rd_dout[11]_syn_2  (\u2_wrrd/Sdr_rd_dout[11]_syn_4 , \u2_wrrd/Sdr_rd_dout [11]);
  buf \u2_wrrd/Sdr_rd_dout[12]_syn_1  (\u2_wrrd/Sdr_rd_dout [12], \u2_wrrd/Sdr_rd_dout[12]_syn_3 );
  buf \u2_wrrd/Sdr_rd_dout[12]_syn_2  (\u2_wrrd/Sdr_rd_dout[12]_syn_4 , \u2_wrrd/Sdr_rd_dout [12]);
  buf \u2_wrrd/Sdr_rd_dout[13]_syn_1  (\u2_wrrd/Sdr_rd_dout [13], \u2_wrrd/Sdr_rd_dout[13]_syn_3 );
  buf \u2_wrrd/Sdr_rd_dout[13]_syn_2  (\u2_wrrd/Sdr_rd_dout[13]_syn_4 , \u2_wrrd/Sdr_rd_dout [13]);
  buf \u2_wrrd/Sdr_rd_dout[14]_syn_1  (\u2_wrrd/Sdr_rd_dout [14], \u2_wrrd/Sdr_rd_dout[14]_syn_3 );
  buf \u2_wrrd/Sdr_rd_dout[14]_syn_2  (\u2_wrrd/Sdr_rd_dout[14]_syn_4 , \u2_wrrd/Sdr_rd_dout [14]);
  buf \u2_wrrd/Sdr_rd_dout[15]_syn_1  (\u2_wrrd/Sdr_rd_dout [15], \u2_wrrd/Sdr_rd_dout[15]_syn_3 );
  buf \u2_wrrd/Sdr_rd_dout[15]_syn_2  (\u2_wrrd/Sdr_rd_dout[15]_syn_4 , \u2_wrrd/Sdr_rd_dout [15]);
  buf \u2_wrrd/Sdr_rd_dout[16]_syn_1  (\u2_wrrd/Sdr_rd_dout [16], \u2_wrrd/Sdr_rd_dout[16]_syn_3 );
  buf \u2_wrrd/Sdr_rd_dout[16]_syn_2  (\u2_wrrd/Sdr_rd_dout[16]_syn_4 , \u2_wrrd/Sdr_rd_dout [16]);
  buf \u2_wrrd/Sdr_rd_dout[17]_syn_1  (\u2_wrrd/Sdr_rd_dout [17], \u2_wrrd/Sdr_rd_dout[17]_syn_3 );
  buf \u2_wrrd/Sdr_rd_dout[17]_syn_2  (\u2_wrrd/Sdr_rd_dout[17]_syn_4 , \u2_wrrd/Sdr_rd_dout [17]);
  buf \u2_wrrd/Sdr_rd_dout[18]_syn_1  (\u2_wrrd/Sdr_rd_dout [18], \u2_wrrd/Sdr_rd_dout[18]_syn_3 );
  buf \u2_wrrd/Sdr_rd_dout[18]_syn_2  (\u2_wrrd/Sdr_rd_dout[18]_syn_4 , \u2_wrrd/Sdr_rd_dout [18]);
  buf \u2_wrrd/Sdr_rd_dout[19]_syn_1  (\u2_wrrd/Sdr_rd_dout [19], \u2_wrrd/Sdr_rd_dout[19]_syn_3 );
  buf \u2_wrrd/Sdr_rd_dout[19]_syn_2  (\u2_wrrd/Sdr_rd_dout[19]_syn_4 , \u2_wrrd/Sdr_rd_dout [19]);
  buf \u2_wrrd/Sdr_rd_dout[1]_syn_1  (\u2_wrrd/Sdr_rd_dout [1], \u2_wrrd/Sdr_rd_dout[1]_syn_3 );
  buf \u2_wrrd/Sdr_rd_dout[1]_syn_2  (\u2_wrrd/Sdr_rd_dout[1]_syn_4 , \u2_wrrd/Sdr_rd_dout [1]);
  buf \u2_wrrd/Sdr_rd_dout[20]_syn_1  (\u2_wrrd/Sdr_rd_dout [20], \u2_wrrd/Sdr_rd_dout[20]_syn_3 );
  buf \u2_wrrd/Sdr_rd_dout[20]_syn_2  (\u2_wrrd/Sdr_rd_dout[20]_syn_4 , \u2_wrrd/Sdr_rd_dout [20]);
  buf \u2_wrrd/Sdr_rd_dout[21]_syn_1  (\u2_wrrd/Sdr_rd_dout [21], \u2_wrrd/Sdr_rd_dout[21]_syn_3 );
  buf \u2_wrrd/Sdr_rd_dout[21]_syn_2  (\u2_wrrd/Sdr_rd_dout[21]_syn_4 , \u2_wrrd/Sdr_rd_dout [21]);
  buf \u2_wrrd/Sdr_rd_dout[22]_syn_1  (\u2_wrrd/Sdr_rd_dout [22], \u2_wrrd/Sdr_rd_dout[22]_syn_3 );
  buf \u2_wrrd/Sdr_rd_dout[22]_syn_2  (\u2_wrrd/Sdr_rd_dout[22]_syn_4 , \u2_wrrd/Sdr_rd_dout [22]);
  buf \u2_wrrd/Sdr_rd_dout[23]_syn_1  (\u2_wrrd/Sdr_rd_dout [23], \u2_wrrd/Sdr_rd_dout[23]_syn_3 );
  buf \u2_wrrd/Sdr_rd_dout[23]_syn_2  (\u2_wrrd/Sdr_rd_dout[23]_syn_4 , \u2_wrrd/Sdr_rd_dout [23]);
  buf \u2_wrrd/Sdr_rd_dout[24]_syn_1  (\u2_wrrd/Sdr_rd_dout [24], \u2_wrrd/Sdr_rd_dout[24]_syn_3 );
  buf \u2_wrrd/Sdr_rd_dout[24]_syn_2  (\u2_wrrd/Sdr_rd_dout[24]_syn_4 , \u2_wrrd/Sdr_rd_dout [24]);
  buf \u2_wrrd/Sdr_rd_dout[25]_syn_1  (\u2_wrrd/Sdr_rd_dout [25], \u2_wrrd/Sdr_rd_dout[25]_syn_3 );
  buf \u2_wrrd/Sdr_rd_dout[25]_syn_2  (\u2_wrrd/Sdr_rd_dout[25]_syn_4 , \u2_wrrd/Sdr_rd_dout [25]);
  buf \u2_wrrd/Sdr_rd_dout[26]_syn_1  (\u2_wrrd/Sdr_rd_dout [26], \u2_wrrd/Sdr_rd_dout[26]_syn_3 );
  buf \u2_wrrd/Sdr_rd_dout[26]_syn_2  (\u2_wrrd/Sdr_rd_dout[26]_syn_4 , \u2_wrrd/Sdr_rd_dout [26]);
  buf \u2_wrrd/Sdr_rd_dout[27]_syn_1  (\u2_wrrd/Sdr_rd_dout [27], \u2_wrrd/Sdr_rd_dout[27]_syn_3 );
  buf \u2_wrrd/Sdr_rd_dout[27]_syn_2  (\u2_wrrd/Sdr_rd_dout[27]_syn_4 , \u2_wrrd/Sdr_rd_dout [27]);
  buf \u2_wrrd/Sdr_rd_dout[28]_syn_1  (\u2_wrrd/Sdr_rd_dout [28], \u2_wrrd/Sdr_rd_dout[28]_syn_3 );
  buf \u2_wrrd/Sdr_rd_dout[28]_syn_2  (\u2_wrrd/Sdr_rd_dout[28]_syn_4 , \u2_wrrd/Sdr_rd_dout [28]);
  buf \u2_wrrd/Sdr_rd_dout[29]_syn_1  (\u2_wrrd/Sdr_rd_dout [29], \u2_wrrd/Sdr_rd_dout[29]_syn_3 );
  buf \u2_wrrd/Sdr_rd_dout[29]_syn_2  (\u2_wrrd/Sdr_rd_dout[29]_syn_4 , \u2_wrrd/Sdr_rd_dout [29]);
  buf \u2_wrrd/Sdr_rd_dout[2]_syn_1  (\u2_wrrd/Sdr_rd_dout [2], \u2_wrrd/Sdr_rd_dout[2]_syn_3 );
  buf \u2_wrrd/Sdr_rd_dout[2]_syn_2  (\u2_wrrd/Sdr_rd_dout[2]_syn_4 , \u2_wrrd/Sdr_rd_dout [2]);
  buf \u2_wrrd/Sdr_rd_dout[30]_syn_1  (\u2_wrrd/Sdr_rd_dout [30], \u2_wrrd/Sdr_rd_dout[30]_syn_3 );
  buf \u2_wrrd/Sdr_rd_dout[30]_syn_2  (\u2_wrrd/Sdr_rd_dout[30]_syn_4 , \u2_wrrd/Sdr_rd_dout [30]);
  buf \u2_wrrd/Sdr_rd_dout[31]_syn_1  (\u2_wrrd/Sdr_rd_dout [31], \u2_wrrd/Sdr_rd_dout[31]_syn_3 );
  buf \u2_wrrd/Sdr_rd_dout[31]_syn_2  (\u2_wrrd/Sdr_rd_dout[31]_syn_4 , \u2_wrrd/Sdr_rd_dout [31]);
  buf \u2_wrrd/Sdr_rd_dout[3]_syn_1  (\u2_wrrd/Sdr_rd_dout [3], \u2_wrrd/Sdr_rd_dout[3]_syn_3 );
  buf \u2_wrrd/Sdr_rd_dout[3]_syn_2  (\u2_wrrd/Sdr_rd_dout[3]_syn_4 , \u2_wrrd/Sdr_rd_dout [3]);
  buf \u2_wrrd/Sdr_rd_dout[4]_syn_1  (\u2_wrrd/Sdr_rd_dout [4], \u2_wrrd/Sdr_rd_dout[4]_syn_3 );
  buf \u2_wrrd/Sdr_rd_dout[4]_syn_2  (\u2_wrrd/Sdr_rd_dout[4]_syn_4 , \u2_wrrd/Sdr_rd_dout [4]);
  buf \u2_wrrd/Sdr_rd_dout[5]_syn_1  (\u2_wrrd/Sdr_rd_dout [5], \u2_wrrd/Sdr_rd_dout[5]_syn_3 );
  buf \u2_wrrd/Sdr_rd_dout[5]_syn_2  (\u2_wrrd/Sdr_rd_dout[5]_syn_4 , \u2_wrrd/Sdr_rd_dout [5]);
  buf \u2_wrrd/Sdr_rd_dout[6]_syn_1  (\u2_wrrd/Sdr_rd_dout [6], \u2_wrrd/Sdr_rd_dout[6]_syn_3 );
  buf \u2_wrrd/Sdr_rd_dout[6]_syn_2  (\u2_wrrd/Sdr_rd_dout[6]_syn_4 , \u2_wrrd/Sdr_rd_dout [6]);
  buf \u2_wrrd/Sdr_rd_dout[7]_syn_1  (\u2_wrrd/Sdr_rd_dout [7], \u2_wrrd/Sdr_rd_dout[7]_syn_3 );
  buf \u2_wrrd/Sdr_rd_dout[7]_syn_2  (\u2_wrrd/Sdr_rd_dout[7]_syn_4 , \u2_wrrd/Sdr_rd_dout [7]);
  buf \u2_wrrd/Sdr_rd_dout[8]_syn_1  (\u2_wrrd/Sdr_rd_dout [8], \u2_wrrd/Sdr_rd_dout[8]_syn_3 );
  buf \u2_wrrd/Sdr_rd_dout[8]_syn_2  (\u2_wrrd/Sdr_rd_dout[8]_syn_4 , \u2_wrrd/Sdr_rd_dout [8]);
  buf \u2_wrrd/Sdr_rd_dout[9]_syn_1  (\u2_wrrd/Sdr_rd_dout [9], \u2_wrrd/Sdr_rd_dout[9]_syn_3 );
  buf \u2_wrrd/Sdr_rd_dout[9]_syn_2  (\u2_wrrd/Sdr_rd_dout[9]_syn_4 , \u2_wrrd/Sdr_rd_dout [9]);
  AL_DFF_X
    //.FORCE_KEEP("ON"),
    \u2_wrrd/Sdr_rd_dout_reg[0]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(1'b0),
    .d(\SDR_DQ[0]_dup_1 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0)); /* synthesis keep=true */ 
  AL_DFF_X
    //.FORCE_KEEP("ON"),
    \u2_wrrd/Sdr_rd_dout_reg[10]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(1'b0),
    .d(\SDR_DQ[10]_dup_1 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0)); /* synthesis keep=true */ 
  AL_DFF_X
    //.FORCE_KEEP("ON"),
    \u2_wrrd/Sdr_rd_dout_reg[11]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(1'b0),
    .d(\SDR_DQ[11]_dup_1 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0)); /* synthesis keep=true */ 
  AL_DFF_X
    //.FORCE_KEEP("ON"),
    \u2_wrrd/Sdr_rd_dout_reg[12]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(1'b0),
    .d(\SDR_DQ[12]_dup_1 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0)); /* synthesis keep=true */ 
  AL_DFF_X
    //.FORCE_KEEP("ON"),
    \u2_wrrd/Sdr_rd_dout_reg[13]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(1'b0),
    .d(\SDR_DQ[13]_dup_1 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0)); /* synthesis keep=true */ 
  AL_DFF_X
    //.FORCE_KEEP("ON"),
    \u2_wrrd/Sdr_rd_dout_reg[14]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(1'b0),
    .d(\SDR_DQ[14]_dup_1 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0)); /* synthesis keep=true */ 
  AL_DFF_X
    //.FORCE_KEEP("ON"),
    \u2_wrrd/Sdr_rd_dout_reg[15]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(1'b0),
    .d(\SDR_DQ[15]_dup_1 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0)); /* synthesis keep=true */ 
  AL_DFF_X
    //.FORCE_KEEP("ON"),
    \u2_wrrd/Sdr_rd_dout_reg[16]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(1'b0),
    .d(\SDR_DQ[16]_dup_1 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0)); /* synthesis keep=true */ 
  AL_DFF_X
    //.FORCE_KEEP("ON"),
    \u2_wrrd/Sdr_rd_dout_reg[17]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(1'b0),
    .d(\SDR_DQ[17]_dup_1 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0)); /* synthesis keep=true */ 
  AL_DFF_X
    //.FORCE_KEEP("ON"),
    \u2_wrrd/Sdr_rd_dout_reg[18]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(1'b0),
    .d(\SDR_DQ[18]_dup_1 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0)); /* synthesis keep=true */ 
  AL_DFF_X
    //.FORCE_KEEP("ON"),
    \u2_wrrd/Sdr_rd_dout_reg[19]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(1'b0),
    .d(\SDR_DQ[19]_dup_1 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0)); /* synthesis keep=true */ 
  AL_DFF_X
    //.FORCE_KEEP("ON"),
    \u2_wrrd/Sdr_rd_dout_reg[1]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(1'b0),
    .d(\SDR_DQ[1]_dup_1 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0)); /* synthesis keep=true */ 
  AL_DFF_X
    //.FORCE_KEEP("ON"),
    \u2_wrrd/Sdr_rd_dout_reg[20]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(1'b0),
    .d(\SDR_DQ[20]_dup_1 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0)); /* synthesis keep=true */ 
  AL_DFF_X
    //.FORCE_KEEP("ON"),
    \u2_wrrd/Sdr_rd_dout_reg[21]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(1'b0),
    .d(\SDR_DQ[21]_dup_1 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0)); /* synthesis keep=true */ 
  AL_DFF_X
    //.FORCE_KEEP("ON"),
    \u2_wrrd/Sdr_rd_dout_reg[22]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(1'b0),
    .d(\SDR_DQ[22]_dup_1 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0)); /* synthesis keep=true */ 
  AL_DFF_X
    //.FORCE_KEEP("ON"),
    \u2_wrrd/Sdr_rd_dout_reg[23]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(1'b0),
    .d(\SDR_DQ[23]_dup_1 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0)); /* synthesis keep=true */ 
  AL_DFF_X
    //.FORCE_KEEP("ON"),
    \u2_wrrd/Sdr_rd_dout_reg[24]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(1'b0),
    .d(\SDR_DQ[24]_dup_1 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0)); /* synthesis keep=true */ 
  AL_DFF_X
    //.FORCE_KEEP("ON"),
    \u2_wrrd/Sdr_rd_dout_reg[25]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(1'b0),
    .d(\SDR_DQ[25]_dup_1 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0)); /* synthesis keep=true */ 
  AL_DFF_X
    //.FORCE_KEEP("ON"),
    \u2_wrrd/Sdr_rd_dout_reg[26]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(1'b0),
    .d(\SDR_DQ[26]_dup_1 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0)); /* synthesis keep=true */ 
  AL_DFF_X
    //.FORCE_KEEP("ON"),
    \u2_wrrd/Sdr_rd_dout_reg[27]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(1'b0),
    .d(\SDR_DQ[27]_dup_1 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0)); /* synthesis keep=true */ 
  AL_DFF_X
    //.FORCE_KEEP("ON"),
    \u2_wrrd/Sdr_rd_dout_reg[28]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(1'b0),
    .d(\SDR_DQ[28]_dup_1 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0)); /* synthesis keep=true */ 
  AL_DFF_X
    //.FORCE_KEEP("ON"),
    \u2_wrrd/Sdr_rd_dout_reg[29]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(1'b0),
    .d(\SDR_DQ[29]_dup_1 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0)); /* synthesis keep=true */ 
  AL_DFF_X
    //.FORCE_KEEP("ON"),
    \u2_wrrd/Sdr_rd_dout_reg[2]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(1'b0),
    .d(\SDR_DQ[2]_dup_1 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0)); /* synthesis keep=true */ 
  AL_DFF_X
    //.FORCE_KEEP("ON"),
    \u2_wrrd/Sdr_rd_dout_reg[30]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(1'b0),
    .d(\SDR_DQ[30]_dup_1 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0)); /* synthesis keep=true */ 
  AL_DFF_X
    //.FORCE_KEEP("ON"),
    \u2_wrrd/Sdr_rd_dout_reg[31]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(1'b0),
    .d(\SDR_DQ[31]_dup_1 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0)); /* synthesis keep=true */ 
  AL_DFF_X
    //.FORCE_KEEP("ON"),
    \u2_wrrd/Sdr_rd_dout_reg[3]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(1'b0),
    .d(\SDR_DQ[3]_dup_1 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0)); /* synthesis keep=true */ 
  AL_DFF_X
    //.FORCE_KEEP("ON"),
    \u2_wrrd/Sdr_rd_dout_reg[4]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(1'b0),
    .d(\SDR_DQ[4]_dup_1 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0)); /* synthesis keep=true */ 
  AL_DFF_X
    //.FORCE_KEEP("ON"),
    \u2_wrrd/Sdr_rd_dout_reg[5]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(1'b0),
    .d(\SDR_DQ[5]_dup_1 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0)); /* synthesis keep=true */ 
  AL_DFF_X
    //.FORCE_KEEP("ON"),
    \u2_wrrd/Sdr_rd_dout_reg[6]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(1'b0),
    .d(\SDR_DQ[6]_dup_1 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0)); /* synthesis keep=true */ 
  AL_DFF_X
    //.FORCE_KEEP("ON"),
    \u2_wrrd/Sdr_rd_dout_reg[7]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(1'b0),
    .d(\SDR_DQ[7]_dup_1 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0)); /* synthesis keep=true */ 
  AL_DFF_X
    //.FORCE_KEEP("ON"),
    \u2_wrrd/Sdr_rd_dout_reg[8]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(1'b0),
    .d(\SDR_DQ[8]_dup_1 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0)); /* synthesis keep=true */ 
  AL_DFF_X
    //.FORCE_KEEP("ON"),
    \u2_wrrd/Sdr_rd_dout_reg[9]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(1'b0),
    .d(\SDR_DQ[9]_dup_1 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0)); /* synthesis keep=true */ 
  AL_MAP_LUT4 #(
    .EQN("(~B*~A*~(~D*~C))"),
    .INIT(16'h1110))
    \u2_wrrd/Sdr_ref_ack_n_syn_1  (
    .a(App_rd_en_dup_5),
    .b(App_wr_en_dup_5),
    .c(\u2_wrrd/ref_ack ),
    .d(\u2_wrrd/wrrd_ref_ack ),
    .o(\u2_wrrd/Sdr_ref_ack_n ));
  AL_DFF_X \u2_wrrd/Sdr_ref_ack_reg  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/Sdr_ref_ack_n ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u1_init_ref/Sdr_ref_ack ));
  buf \u2_wrrd/Sdr_ref_req_syn_1  (\u2_wrrd/Sdr_ref_req , App_ref_req_dup_1);
  buf \u2_wrrd/Sdr_ref_req_syn_2  (\u2_wrrd/Sdr_ref_req_syn_4 , \u2_wrrd/Sdr_ref_req );
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    \u2_wrrd/active_ba_b1[0]_syn_1  (
    .a(\u2_wrrd/active_row_b1[9]_syn_2 ),
    .b(\u2_wrrd/app_rd_addr_1d [2]),
    .c(\u2_wrrd/app_wr_addr_1d [2]),
    .o(\u2_wrrd/active_ba_b1 [0]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    \u2_wrrd/active_ba_b1[1]_syn_1  (
    .a(\u2_wrrd/active_row_b1[9]_syn_2 ),
    .b(\u2_wrrd/app_rd_addr_1d [3]),
    .c(\u2_wrrd/app_wr_addr_1d [3]),
    .o(\u2_wrrd/active_ba_b1 [1]));
  AL_DFF_X \u2_wrrd/active_ba_reg[0]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/active_ba_b1 [0]),
    .en(\u2_wrrd/mux21_syn_2 [0]),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u2_wrrd/active_ba [0]));
  AL_DFF_X \u2_wrrd/active_ba_reg[1]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/active_ba_b1 [1]),
    .en(\u2_wrrd/mux21_syn_2 [0]),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u2_wrrd/active_ba [1]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    \u2_wrrd/active_col_b1[0]_syn_1  (
    .a(\u2_wrrd/active_col_b1[6]_syn_2 ),
    .b(\u2_wrrd/app_rd_addr_4d [0]),
    .c(\u2_wrrd/app_wr_addr_4d [0]),
    .o(\u2_wrrd/active_col_b1 [0]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    \u2_wrrd/active_col_b1[1]_syn_1  (
    .a(\u2_wrrd/active_col_b1[6]_syn_2 ),
    .b(\u2_wrrd/app_rd_addr_4d [1]),
    .c(\u2_wrrd/app_wr_addr_4d [1]),
    .o(\u2_wrrd/active_col_b1 [1]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    \u2_wrrd/active_col_b1[2]_syn_1  (
    .a(\u2_wrrd/active_col_b1[6]_syn_2 ),
    .b(\u2_wrrd/app_rd_addr_4d [4]),
    .c(\u2_wrrd/app_wr_addr_4d [4]),
    .o(\u2_wrrd/active_col_b1 [2]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    \u2_wrrd/active_col_b1[3]_syn_1  (
    .a(\u2_wrrd/active_col_b1[6]_syn_2 ),
    .b(\u2_wrrd/app_rd_addr_4d [5]),
    .c(\u2_wrrd/app_wr_addr_4d [5]),
    .o(\u2_wrrd/active_col_b1 [3]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    \u2_wrrd/active_col_b1[4]_syn_1  (
    .a(\u2_wrrd/active_col_b1[6]_syn_2 ),
    .b(\u2_wrrd/app_rd_addr_4d [6]),
    .c(\u2_wrrd/app_wr_addr_4d [6]),
    .o(\u2_wrrd/active_col_b1 [4]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    \u2_wrrd/active_col_b1[5]_syn_1  (
    .a(\u2_wrrd/active_col_b1[6]_syn_2 ),
    .b(\u2_wrrd/app_rd_addr_4d [7]),
    .c(\u2_wrrd/app_wr_addr_4d [7]),
    .o(\u2_wrrd/active_col_b1 [5]));
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    \u2_wrrd/active_col_b1[6]_syn_1  (
    .a(\u2_wrrd/app_wr_en_sft [0]),
    .b(\u2_wrrd/cnt4 [0]),
    .c(\u2_wrrd/cnt4 [1]),
    .o(\u2_wrrd/active_col_b1[6]_syn_2 ));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    \u2_wrrd/active_col_b1[6]_syn_3  (
    .a(\u2_wrrd/active_col_b1[6]_syn_2 ),
    .b(\u2_wrrd/app_rd_addr_4d [8]),
    .c(\u2_wrrd/app_wr_addr_4d [8]),
    .o(\u2_wrrd/active_col_b1 [6]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    \u2_wrrd/active_col_b1[7]_syn_1  (
    .a(\u2_wrrd/active_col_b1[6]_syn_2 ),
    .b(\u2_wrrd/app_rd_addr_4d [9]),
    .c(\u2_wrrd/app_wr_addr_4d [9]),
    .o(\u2_wrrd/active_col_b1 [7]));
  AL_DFF_X \u2_wrrd/active_col_reg[0]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/active_col_b1 [0]),
    .en(\u2_wrrd/mux1_syn_2 [7]),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u2_wrrd/active_col [0]));
  AL_DFF_X \u2_wrrd/active_col_reg[1]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/active_col_b1 [1]),
    .en(\u2_wrrd/mux1_syn_2 [7]),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u2_wrrd/active_col [1]));
  AL_DFF_X \u2_wrrd/active_col_reg[2]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/active_col_b1 [2]),
    .en(\u2_wrrd/mux1_syn_2 [7]),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u2_wrrd/active_col [2]));
  AL_DFF_X \u2_wrrd/active_col_reg[3]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/active_col_b1 [3]),
    .en(\u2_wrrd/mux1_syn_2 [7]),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u2_wrrd/active_col [3]));
  AL_DFF_X \u2_wrrd/active_col_reg[4]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/active_col_b1 [4]),
    .en(\u2_wrrd/mux1_syn_2 [7]),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u2_wrrd/active_col [4]));
  AL_DFF_X \u2_wrrd/active_col_reg[5]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/active_col_b1 [5]),
    .en(\u2_wrrd/mux1_syn_2 [7]),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u2_wrrd/active_col [5]));
  AL_DFF_X \u2_wrrd/active_col_reg[6]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/active_col_b1 [6]),
    .en(\u2_wrrd/mux1_syn_2 [7]),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u2_wrrd/active_col [6]));
  AL_DFF_X \u2_wrrd/active_col_reg[7]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/active_col_b1 [7]),
    .en(\u2_wrrd/mux1_syn_2 [7]),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u2_wrrd/active_col [7]));
  AL_DFF_X \u2_wrrd/active_en_reg  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/active_en_reg_syn_3 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/active_en ));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*~A)"),
    .INIT(16'h0001))
    \u2_wrrd/active_en_reg_syn_4  (
    .a(\u2_wrrd/mux1_syn_72 ),
    .b(Rst_dup_175),
    .c(\u2_wrrd/cnt4 [0]),
    .d(\u2_wrrd/cnt4 [1]),
    .o(\u2_wrrd/active_en_reg_syn_3 ));
  AL_MAP_LUT1 #(
    .EQN("(~A)"),
    .INIT(2'h1))
    \u2_wrrd/active_en_syn_15  (
    .a(\u2_wrrd/active_en ),
    .o(\u2_wrrd/active_en_syn_2 ));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    \u2_wrrd/active_row_b1[0]_syn_1  (
    .a(\u2_wrrd/active_row_b1[9]_syn_2 ),
    .b(\u2_wrrd/app_rd_addr_1d [10]),
    .c(\u2_wrrd/app_wr_addr_1d [10]),
    .o(\u2_wrrd/active_row_b1 [0]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    \u2_wrrd/active_row_b1[10]_syn_1  (
    .a(\u2_wrrd/active_row_b1[9]_syn_2 ),
    .b(\u2_wrrd/app_rd_addr_1d [20]),
    .c(\u2_wrrd/app_wr_addr_1d [20]),
    .o(\u2_wrrd/active_row_b1 [10]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    \u2_wrrd/active_row_b1[1]_syn_1  (
    .a(\u2_wrrd/active_row_b1[9]_syn_2 ),
    .b(\u2_wrrd/app_rd_addr_1d [11]),
    .c(\u2_wrrd/app_wr_addr_1d [11]),
    .o(\u2_wrrd/active_row_b1 [1]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    \u2_wrrd/active_row_b1[2]_syn_1  (
    .a(\u2_wrrd/active_row_b1[9]_syn_2 ),
    .b(\u2_wrrd/app_rd_addr_1d [12]),
    .c(\u2_wrrd/app_wr_addr_1d [12]),
    .o(\u2_wrrd/active_row_b1 [2]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    \u2_wrrd/active_row_b1[3]_syn_1  (
    .a(\u2_wrrd/active_row_b1[9]_syn_2 ),
    .b(\u2_wrrd/app_rd_addr_1d [13]),
    .c(\u2_wrrd/app_wr_addr_1d [13]),
    .o(\u2_wrrd/active_row_b1 [3]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    \u2_wrrd/active_row_b1[4]_syn_1  (
    .a(\u2_wrrd/active_row_b1[9]_syn_2 ),
    .b(\u2_wrrd/app_rd_addr_1d [14]),
    .c(\u2_wrrd/app_wr_addr_1d [14]),
    .o(\u2_wrrd/active_row_b1 [4]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    \u2_wrrd/active_row_b1[5]_syn_1  (
    .a(\u2_wrrd/active_row_b1[9]_syn_2 ),
    .b(\u2_wrrd/app_rd_addr_1d [15]),
    .c(\u2_wrrd/app_wr_addr_1d [15]),
    .o(\u2_wrrd/active_row_b1 [5]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    \u2_wrrd/active_row_b1[6]_syn_1  (
    .a(\u2_wrrd/active_row_b1[9]_syn_2 ),
    .b(\u2_wrrd/app_rd_addr_1d [16]),
    .c(\u2_wrrd/app_wr_addr_1d [16]),
    .o(\u2_wrrd/active_row_b1 [6]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    \u2_wrrd/active_row_b1[7]_syn_1  (
    .a(\u2_wrrd/active_row_b1[9]_syn_2 ),
    .b(\u2_wrrd/app_rd_addr_1d [17]),
    .c(\u2_wrrd/app_wr_addr_1d [17]),
    .o(\u2_wrrd/active_row_b1 [7]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    \u2_wrrd/active_row_b1[8]_syn_1  (
    .a(\u2_wrrd/active_row_b1[9]_syn_2 ),
    .b(\u2_wrrd/app_rd_addr_1d [18]),
    .c(\u2_wrrd/app_wr_addr_1d [18]),
    .o(\u2_wrrd/active_row_b1 [8]));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*A)"),
    .INIT(8'h02))
    \u2_wrrd/active_row_b1[9]_syn_1  (
    .a(\u2_wrrd/app_wr_en_sft [0]),
    .b(\u2_wrrd/cnt4 [0]),
    .c(\u2_wrrd/cnt4 [1]),
    .o(\u2_wrrd/active_row_b1[9]_syn_2 ));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    \u2_wrrd/active_row_b1[9]_syn_3  (
    .a(\u2_wrrd/active_row_b1[9]_syn_2 ),
    .b(\u2_wrrd/app_rd_addr_1d [19]),
    .c(\u2_wrrd/app_wr_addr_1d [19]),
    .o(\u2_wrrd/active_row_b1 [9]));
  AL_DFF_X \u2_wrrd/active_row_reg[0]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/active_row_b1 [0]),
    .en(\u2_wrrd/mux21_syn_2 [0]),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u2_wrrd/active_row [0]));
  AL_DFF_X \u2_wrrd/active_row_reg[10]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/active_row_b1 [10]),
    .en(\u2_wrrd/mux21_syn_2 [0]),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u2_wrrd/active_row [10]));
  AL_DFF_X \u2_wrrd/active_row_reg[1]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/active_row_b1 [1]),
    .en(\u2_wrrd/mux21_syn_2 [0]),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u2_wrrd/active_row [1]));
  AL_DFF_X \u2_wrrd/active_row_reg[2]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/active_row_b1 [2]),
    .en(\u2_wrrd/mux21_syn_2 [0]),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u2_wrrd/active_row [2]));
  AL_DFF_X \u2_wrrd/active_row_reg[3]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/active_row_b1 [3]),
    .en(\u2_wrrd/mux21_syn_2 [0]),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u2_wrrd/active_row [3]));
  AL_DFF_X \u2_wrrd/active_row_reg[4]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/active_row_b1 [4]),
    .en(\u2_wrrd/mux21_syn_2 [0]),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u2_wrrd/active_row [4]));
  AL_DFF_X \u2_wrrd/active_row_reg[5]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/active_row_b1 [5]),
    .en(\u2_wrrd/mux21_syn_2 [0]),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u2_wrrd/active_row [5]));
  AL_DFF_X \u2_wrrd/active_row_reg[6]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/active_row_b1 [6]),
    .en(\u2_wrrd/mux21_syn_2 [0]),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u2_wrrd/active_row [6]));
  AL_DFF_X \u2_wrrd/active_row_reg[7]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/active_row_b1 [7]),
    .en(\u2_wrrd/mux21_syn_2 [0]),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u2_wrrd/active_row [7]));
  AL_DFF_X \u2_wrrd/active_row_reg[8]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/active_row_b1 [8]),
    .en(\u2_wrrd/mux21_syn_2 [0]),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u2_wrrd/active_row [8]));
  AL_DFF_X \u2_wrrd/active_row_reg[9]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/active_row_b1 [9]),
    .en(\u2_wrrd/mux21_syn_2 [0]),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u2_wrrd/active_row [9]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    \u2_wrrd/addr_b[0]_syn_1  (
    .a(\u2_wrrd/active_en ),
    .b(\u2_wrrd/active_col [0]),
    .c(\u2_wrrd/active_row [0]),
    .o(\u2_wrrd/addr_b [0]));
  AL_MAP_LUT2 #(
    .EQN("~(~B*A)"),
    .INIT(4'hd))
    \u2_wrrd/addr_b[10]_syn_1  (
    .a(\u2_wrrd/active_en ),
    .b(\u2_wrrd/active_row [10]),
    .o(\u2_wrrd/addr_b [10]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    \u2_wrrd/addr_b[1]_syn_1  (
    .a(\u2_wrrd/active_en ),
    .b(\u2_wrrd/active_col [1]),
    .c(\u2_wrrd/active_row [1]),
    .o(\u2_wrrd/addr_b [1]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    \u2_wrrd/addr_b[2]_syn_1  (
    .a(\u2_wrrd/active_en ),
    .b(\u2_wrrd/active_col [2]),
    .c(\u2_wrrd/active_row [2]),
    .o(\u2_wrrd/addr_b [2]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    \u2_wrrd/addr_b[3]_syn_1  (
    .a(\u2_wrrd/active_en ),
    .b(\u2_wrrd/active_col [3]),
    .c(\u2_wrrd/active_row [3]),
    .o(\u2_wrrd/addr_b [3]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    \u2_wrrd/addr_b[4]_syn_1  (
    .a(\u2_wrrd/active_en ),
    .b(\u2_wrrd/active_col [4]),
    .c(\u2_wrrd/active_row [4]),
    .o(\u2_wrrd/addr_b [4]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    \u2_wrrd/addr_b[5]_syn_1  (
    .a(\u2_wrrd/active_en ),
    .b(\u2_wrrd/active_col [5]),
    .c(\u2_wrrd/active_row [5]),
    .o(\u2_wrrd/addr_b [5]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    \u2_wrrd/addr_b[6]_syn_1  (
    .a(\u2_wrrd/active_en ),
    .b(\u2_wrrd/active_col [6]),
    .c(\u2_wrrd/active_row [6]),
    .o(\u2_wrrd/addr_b [6]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    \u2_wrrd/addr_b[7]_syn_1  (
    .a(\u2_wrrd/active_en ),
    .b(\u2_wrrd/active_col [7]),
    .c(\u2_wrrd/active_row [7]),
    .o(\u2_wrrd/addr_b [7]));
  AL_DFF_X \u2_wrrd/addr_reg[0]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/addr_b [0]),
    .en(\u2_wrrd/mux4_syn_2 [10]),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/addr [0]));
  AL_DFF_X \u2_wrrd/addr_reg[10]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/addr_b [10]),
    .en(\u2_wrrd/mux4_syn_2 [10]),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/addr [10]));
  AL_DFF_X \u2_wrrd/addr_reg[1]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/addr_b [1]),
    .en(\u2_wrrd/mux4_syn_2 [10]),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/addr [1]));
  AL_DFF_X \u2_wrrd/addr_reg[2]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/addr_b [2]),
    .en(\u2_wrrd/mux4_syn_2 [10]),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/addr [2]));
  AL_DFF_X \u2_wrrd/addr_reg[3]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/addr_b [3]),
    .en(\u2_wrrd/mux4_syn_2 [10]),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/addr [3]));
  AL_DFF_X \u2_wrrd/addr_reg[4]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/addr_b [4]),
    .en(\u2_wrrd/mux4_syn_2 [10]),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/addr [4]));
  AL_DFF_X \u2_wrrd/addr_reg[5]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/addr_b [5]),
    .en(\u2_wrrd/mux4_syn_2 [10]),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/addr [5]));
  AL_DFF_X \u2_wrrd/addr_reg[6]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/addr_b [6]),
    .en(\u2_wrrd/mux4_syn_2 [10]),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/addr [6]));
  AL_DFF_X \u2_wrrd/addr_reg[7]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/addr_b [7]),
    .en(\u2_wrrd/mux4_syn_2 [10]),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/addr [7]));
  AL_DFF_X \u2_wrrd/addr_reg[8]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/addr_reg[8]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/addr [8]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    \u2_wrrd/addr_reg[8]_syn_3  (
    .a(\u2_wrrd/active_en ),
    .b(\u2_wrrd/active_row [8]),
    .c(\u2_wrrd/addr [8]),
    .o(\u2_wrrd/addr_reg[8]_syn_2 ));
  AL_DFF_X \u2_wrrd/addr_reg[9]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/addr_reg[9]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/addr [9]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    \u2_wrrd/addr_reg[9]_syn_3  (
    .a(\u2_wrrd/active_en ),
    .b(\u2_wrrd/active_row [9]),
    .c(\u2_wrrd/addr [9]),
    .o(\u2_wrrd/addr_reg[9]_syn_2 ));
  AL_DFF_X \u2_wrrd/app_rd_addr_2d_reg[0]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_rd_addr_1d [0]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_rd_addr_2d [0]));
  AL_DFF_X \u2_wrrd/app_rd_addr_2d_reg[1]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_rd_addr_1d [1]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_rd_addr_2d [1]));
  AL_DFF_X \u2_wrrd/app_rd_addr_2d_reg[4]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_rd_addr_1d [4]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_rd_addr_2d [4]));
  AL_DFF_X \u2_wrrd/app_rd_addr_2d_reg[5]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_rd_addr_1d [5]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_rd_addr_2d [5]));
  AL_DFF_X \u2_wrrd/app_rd_addr_2d_reg[6]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_rd_addr_1d [6]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_rd_addr_2d [6]));
  AL_DFF_X \u2_wrrd/app_rd_addr_2d_reg[7]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_rd_addr_1d [7]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_rd_addr_2d [7]));
  AL_DFF_X \u2_wrrd/app_rd_addr_2d_reg[8]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_rd_addr_1d [8]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_rd_addr_2d [8]));
  AL_DFF_X \u2_wrrd/app_rd_addr_2d_reg[9]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_rd_addr_1d [9]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_rd_addr_2d [9]));
  AL_DFF_X \u2_wrrd/app_rd_addr_3d_reg[0]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_rd_addr_2d [0]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_rd_addr_3d [0]));
  AL_DFF_X \u2_wrrd/app_rd_addr_3d_reg[1]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_rd_addr_2d [1]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_rd_addr_3d [1]));
  AL_DFF_X \u2_wrrd/app_rd_addr_3d_reg[4]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_rd_addr_2d [4]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_rd_addr_3d [4]));
  AL_DFF_X \u2_wrrd/app_rd_addr_3d_reg[5]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_rd_addr_2d [5]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_rd_addr_3d [5]));
  AL_DFF_X \u2_wrrd/app_rd_addr_3d_reg[6]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_rd_addr_2d [6]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_rd_addr_3d [6]));
  AL_DFF_X \u2_wrrd/app_rd_addr_3d_reg[7]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_rd_addr_2d [7]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_rd_addr_3d [7]));
  AL_DFF_X \u2_wrrd/app_rd_addr_3d_reg[8]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_rd_addr_2d [8]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_rd_addr_3d [8]));
  AL_DFF_X \u2_wrrd/app_rd_addr_3d_reg[9]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_rd_addr_2d [9]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_rd_addr_3d [9]));
  AL_DFF_X \u2_wrrd/app_rd_addr_4d_reg[0]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_rd_addr_3d [0]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_rd_addr_4d [0]));
  AL_DFF_X \u2_wrrd/app_rd_addr_4d_reg[1]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_rd_addr_3d [1]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_rd_addr_4d [1]));
  AL_DFF_X \u2_wrrd/app_rd_addr_4d_reg[4]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_rd_addr_3d [4]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_rd_addr_4d [4]));
  AL_DFF_X \u2_wrrd/app_rd_addr_4d_reg[5]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_rd_addr_3d [5]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_rd_addr_4d [5]));
  AL_DFF_X \u2_wrrd/app_rd_addr_4d_reg[6]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_rd_addr_3d [6]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_rd_addr_4d [6]));
  AL_DFF_X \u2_wrrd/app_rd_addr_4d_reg[7]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_rd_addr_3d [7]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_rd_addr_4d [7]));
  AL_DFF_X \u2_wrrd/app_rd_addr_4d_reg[8]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_rd_addr_3d [8]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_rd_addr_4d [8]));
  AL_DFF_X \u2_wrrd/app_rd_addr_4d_reg[9]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_rd_addr_3d [9]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_rd_addr_4d [9]));
  AL_DFF_X \u2_wrrd/app_rd_en_sft_reg[10]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_rd_en_sft [9]),
    .en(1'b1),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u2_wrrd/app_rd_en_sft [10]));
  AL_DFF_X \u2_wrrd/app_rd_en_sft_reg[1]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_rd_en_sft [0]),
    .en(1'b1),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u2_wrrd/app_rd_en_sft [1]));
  AL_DFF_X \u2_wrrd/app_rd_en_sft_reg[2]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_rd_en_sft [1]),
    .en(1'b1),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u2_wrrd/app_rd_en_sft [2]));
  AL_DFF_X \u2_wrrd/app_rd_en_sft_reg[3]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_rd_en_sft [2]),
    .en(1'b1),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u2_wrrd/app_rd_en_sft [3]));
  AL_DFF_X \u2_wrrd/app_rd_en_sft_reg[4]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_rd_en_sft [3]),
    .en(1'b1),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u2_wrrd/app_rd_en_sft [4]));
  AL_DFF_X \u2_wrrd/app_rd_en_sft_reg[5]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_rd_en_sft [4]),
    .en(1'b1),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u2_wrrd/app_rd_en_sft [5]));
  AL_DFF_X \u2_wrrd/app_rd_en_sft_reg[6]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_rd_en_sft [5]),
    .en(1'b1),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u2_wrrd/app_rd_en_sft [6]));
  AL_DFF_X \u2_wrrd/app_rd_en_sft_reg[7]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_rd_en_sft [6]),
    .en(1'b1),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u2_wrrd/app_rd_en_sft [7]));
  AL_DFF_X \u2_wrrd/app_rd_en_sft_reg[8]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_rd_en_sft [7]),
    .en(1'b1),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u2_wrrd/app_rd_en_sft [8]));
  AL_DFF_X \u2_wrrd/app_rd_en_sft_reg[9]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_rd_en_sft [8]),
    .en(1'b1),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u2_wrrd/app_rd_en_sft [9]));
  AL_DFF_X \u2_wrrd/app_wr_addr_2d_reg[0]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_addr_1d [0]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_addr_2d [0]));
  AL_DFF_X \u2_wrrd/app_wr_addr_2d_reg[1]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_addr_1d [1]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_addr_2d [1]));
  AL_DFF_X \u2_wrrd/app_wr_addr_2d_reg[4]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_addr_1d [4]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_addr_2d [4]));
  AL_DFF_X \u2_wrrd/app_wr_addr_2d_reg[5]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_addr_1d [5]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_addr_2d [5]));
  AL_DFF_X \u2_wrrd/app_wr_addr_2d_reg[6]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_addr_1d [6]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_addr_2d [6]));
  AL_DFF_X \u2_wrrd/app_wr_addr_2d_reg[7]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_addr_1d [7]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_addr_2d [7]));
  AL_DFF_X \u2_wrrd/app_wr_addr_2d_reg[8]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_addr_1d [8]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_addr_2d [8]));
  AL_DFF_X \u2_wrrd/app_wr_addr_2d_reg[9]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_addr_1d [9]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_addr_2d [9]));
  AL_DFF_X \u2_wrrd/app_wr_addr_3d_reg[0]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_addr_2d [0]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_addr_3d [0]));
  AL_DFF_X \u2_wrrd/app_wr_addr_3d_reg[1]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_addr_2d [1]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_addr_3d [1]));
  AL_DFF_X \u2_wrrd/app_wr_addr_3d_reg[4]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_addr_2d [4]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_addr_3d [4]));
  AL_DFF_X \u2_wrrd/app_wr_addr_3d_reg[5]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_addr_2d [5]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_addr_3d [5]));
  AL_DFF_X \u2_wrrd/app_wr_addr_3d_reg[6]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_addr_2d [6]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_addr_3d [6]));
  AL_DFF_X \u2_wrrd/app_wr_addr_3d_reg[7]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_addr_2d [7]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_addr_3d [7]));
  AL_DFF_X \u2_wrrd/app_wr_addr_3d_reg[8]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_addr_2d [8]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_addr_3d [8]));
  AL_DFF_X \u2_wrrd/app_wr_addr_3d_reg[9]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_addr_2d [9]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_addr_3d [9]));
  AL_DFF_X \u2_wrrd/app_wr_addr_4d_reg[0]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_addr_3d [0]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_addr_4d [0]));
  AL_DFF_X \u2_wrrd/app_wr_addr_4d_reg[1]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_addr_3d [1]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_addr_4d [1]));
  AL_DFF_X \u2_wrrd/app_wr_addr_4d_reg[4]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_addr_3d [4]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_addr_4d [4]));
  AL_DFF_X \u2_wrrd/app_wr_addr_4d_reg[5]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_addr_3d [5]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_addr_4d [5]));
  AL_DFF_X \u2_wrrd/app_wr_addr_4d_reg[6]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_addr_3d [6]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_addr_4d [6]));
  AL_DFF_X \u2_wrrd/app_wr_addr_4d_reg[7]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_addr_3d [7]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_addr_4d [7]));
  AL_DFF_X \u2_wrrd/app_wr_addr_4d_reg[8]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_addr_3d [8]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_addr_4d [8]));
  AL_DFF_X \u2_wrrd/app_wr_addr_4d_reg[9]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_addr_3d [9]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_addr_4d [9]));
  AL_DFF_X \u2_wrrd/app_wr_din_2d_reg[0]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_1d [0]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_2d [0]));
  AL_DFF_X \u2_wrrd/app_wr_din_2d_reg[10]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_1d [10]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_2d [10]));
  AL_DFF_X \u2_wrrd/app_wr_din_2d_reg[11]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_1d [11]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_2d [11]));
  AL_DFF_X \u2_wrrd/app_wr_din_2d_reg[12]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_1d [12]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_2d [12]));
  AL_DFF_X \u2_wrrd/app_wr_din_2d_reg[13]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_1d [13]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_2d [13]));
  AL_DFF_X \u2_wrrd/app_wr_din_2d_reg[14]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_1d [14]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_2d [14]));
  AL_DFF_X \u2_wrrd/app_wr_din_2d_reg[15]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_1d [15]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_2d [15]));
  AL_DFF_X \u2_wrrd/app_wr_din_2d_reg[16]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_1d [16]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_2d [16]));
  AL_DFF_X \u2_wrrd/app_wr_din_2d_reg[17]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_1d [17]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_2d [17]));
  AL_DFF_X \u2_wrrd/app_wr_din_2d_reg[18]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_1d [18]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_2d [18]));
  AL_DFF_X \u2_wrrd/app_wr_din_2d_reg[19]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_1d [19]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_2d [19]));
  AL_DFF_X \u2_wrrd/app_wr_din_2d_reg[1]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_1d [1]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_2d [1]));
  AL_DFF_X \u2_wrrd/app_wr_din_2d_reg[20]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_1d [20]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_2d [20]));
  AL_DFF_X \u2_wrrd/app_wr_din_2d_reg[21]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_1d [21]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_2d [21]));
  AL_DFF_X \u2_wrrd/app_wr_din_2d_reg[22]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_1d [22]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_2d [22]));
  AL_DFF_X \u2_wrrd/app_wr_din_2d_reg[23]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_1d [23]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_2d [23]));
  AL_DFF_X \u2_wrrd/app_wr_din_2d_reg[24]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_1d [24]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_2d [24]));
  AL_DFF_X \u2_wrrd/app_wr_din_2d_reg[25]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_1d [25]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_2d [25]));
  AL_DFF_X \u2_wrrd/app_wr_din_2d_reg[26]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_1d [26]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_2d [26]));
  AL_DFF_X \u2_wrrd/app_wr_din_2d_reg[27]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_1d [27]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_2d [27]));
  AL_DFF_X \u2_wrrd/app_wr_din_2d_reg[28]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_1d [28]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_2d [28]));
  AL_DFF_X \u2_wrrd/app_wr_din_2d_reg[29]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_1d [29]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_2d [29]));
  AL_DFF_X \u2_wrrd/app_wr_din_2d_reg[2]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_1d [2]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_2d [2]));
  AL_DFF_X \u2_wrrd/app_wr_din_2d_reg[30]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_1d [30]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_2d [30]));
  AL_DFF_X \u2_wrrd/app_wr_din_2d_reg[31]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_1d [31]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_2d [31]));
  AL_DFF_X \u2_wrrd/app_wr_din_2d_reg[3]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_1d [3]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_2d [3]));
  AL_DFF_X \u2_wrrd/app_wr_din_2d_reg[4]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_1d [4]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_2d [4]));
  AL_DFF_X \u2_wrrd/app_wr_din_2d_reg[5]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_1d [5]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_2d [5]));
  AL_DFF_X \u2_wrrd/app_wr_din_2d_reg[6]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_1d [6]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_2d [6]));
  AL_DFF_X \u2_wrrd/app_wr_din_2d_reg[7]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_1d [7]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_2d [7]));
  AL_DFF_X \u2_wrrd/app_wr_din_2d_reg[8]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_1d [8]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_2d [8]));
  AL_DFF_X \u2_wrrd/app_wr_din_2d_reg[9]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_1d [9]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_2d [9]));
  AL_DFF_X \u2_wrrd/app_wr_din_3d_reg[0]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_2d [0]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_3d [0]));
  AL_DFF_X \u2_wrrd/app_wr_din_3d_reg[10]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_2d [10]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_3d [10]));
  AL_DFF_X \u2_wrrd/app_wr_din_3d_reg[11]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_2d [11]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_3d [11]));
  AL_DFF_X \u2_wrrd/app_wr_din_3d_reg[12]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_2d [12]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_3d [12]));
  AL_DFF_X \u2_wrrd/app_wr_din_3d_reg[13]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_2d [13]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_3d [13]));
  AL_DFF_X \u2_wrrd/app_wr_din_3d_reg[14]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_2d [14]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_3d [14]));
  AL_DFF_X \u2_wrrd/app_wr_din_3d_reg[15]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_2d [15]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_3d [15]));
  AL_DFF_X \u2_wrrd/app_wr_din_3d_reg[16]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_2d [16]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_3d [16]));
  AL_DFF_X \u2_wrrd/app_wr_din_3d_reg[17]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_2d [17]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_3d [17]));
  AL_DFF_X \u2_wrrd/app_wr_din_3d_reg[18]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_2d [18]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_3d [18]));
  AL_DFF_X \u2_wrrd/app_wr_din_3d_reg[19]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_2d [19]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_3d [19]));
  AL_DFF_X \u2_wrrd/app_wr_din_3d_reg[1]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_2d [1]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_3d [1]));
  AL_DFF_X \u2_wrrd/app_wr_din_3d_reg[20]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_2d [20]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_3d [20]));
  AL_DFF_X \u2_wrrd/app_wr_din_3d_reg[21]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_2d [21]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_3d [21]));
  AL_DFF_X \u2_wrrd/app_wr_din_3d_reg[22]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_2d [22]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_3d [22]));
  AL_DFF_X \u2_wrrd/app_wr_din_3d_reg[23]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_2d [23]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_3d [23]));
  AL_DFF_X \u2_wrrd/app_wr_din_3d_reg[24]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_2d [24]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_3d [24]));
  AL_DFF_X \u2_wrrd/app_wr_din_3d_reg[25]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_2d [25]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_3d [25]));
  AL_DFF_X \u2_wrrd/app_wr_din_3d_reg[26]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_2d [26]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_3d [26]));
  AL_DFF_X \u2_wrrd/app_wr_din_3d_reg[27]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_2d [27]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_3d [27]));
  AL_DFF_X \u2_wrrd/app_wr_din_3d_reg[28]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_2d [28]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_3d [28]));
  AL_DFF_X \u2_wrrd/app_wr_din_3d_reg[29]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_2d [29]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_3d [29]));
  AL_DFF_X \u2_wrrd/app_wr_din_3d_reg[2]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_2d [2]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_3d [2]));
  AL_DFF_X \u2_wrrd/app_wr_din_3d_reg[30]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_2d [30]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_3d [30]));
  AL_DFF_X \u2_wrrd/app_wr_din_3d_reg[31]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_2d [31]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_3d [31]));
  AL_DFF_X \u2_wrrd/app_wr_din_3d_reg[3]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_2d [3]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_3d [3]));
  AL_DFF_X \u2_wrrd/app_wr_din_3d_reg[4]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_2d [4]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_3d [4]));
  AL_DFF_X \u2_wrrd/app_wr_din_3d_reg[5]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_2d [5]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_3d [5]));
  AL_DFF_X \u2_wrrd/app_wr_din_3d_reg[6]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_2d [6]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_3d [6]));
  AL_DFF_X \u2_wrrd/app_wr_din_3d_reg[7]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_2d [7]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_3d [7]));
  AL_DFF_X \u2_wrrd/app_wr_din_3d_reg[8]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_2d [8]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_3d [8]));
  AL_DFF_X \u2_wrrd/app_wr_din_3d_reg[9]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_2d [9]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_3d [9]));
  AL_DFF_X \u2_wrrd/app_wr_din_4d_reg[0]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_3d [0]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_4d [0]));
  AL_DFF_X \u2_wrrd/app_wr_din_4d_reg[10]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_3d [10]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_4d [10]));
  AL_DFF_X \u2_wrrd/app_wr_din_4d_reg[11]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_3d [11]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_4d [11]));
  AL_DFF_X \u2_wrrd/app_wr_din_4d_reg[12]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_3d [12]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_4d [12]));
  AL_DFF_X \u2_wrrd/app_wr_din_4d_reg[13]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_3d [13]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_4d [13]));
  AL_DFF_X \u2_wrrd/app_wr_din_4d_reg[14]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_3d [14]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_4d [14]));
  AL_DFF_X \u2_wrrd/app_wr_din_4d_reg[15]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_3d [15]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_4d [15]));
  AL_DFF_X \u2_wrrd/app_wr_din_4d_reg[16]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_3d [16]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_4d [16]));
  AL_DFF_X \u2_wrrd/app_wr_din_4d_reg[17]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_3d [17]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_4d [17]));
  AL_DFF_X \u2_wrrd/app_wr_din_4d_reg[18]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_3d [18]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_4d [18]));
  AL_DFF_X \u2_wrrd/app_wr_din_4d_reg[19]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_3d [19]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_4d [19]));
  AL_DFF_X \u2_wrrd/app_wr_din_4d_reg[1]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_3d [1]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_4d [1]));
  AL_DFF_X \u2_wrrd/app_wr_din_4d_reg[20]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_3d [20]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_4d [20]));
  AL_DFF_X \u2_wrrd/app_wr_din_4d_reg[21]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_3d [21]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_4d [21]));
  AL_DFF_X \u2_wrrd/app_wr_din_4d_reg[22]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_3d [22]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_4d [22]));
  AL_DFF_X \u2_wrrd/app_wr_din_4d_reg[23]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_3d [23]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_4d [23]));
  AL_DFF_X \u2_wrrd/app_wr_din_4d_reg[24]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_3d [24]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_4d [24]));
  AL_DFF_X \u2_wrrd/app_wr_din_4d_reg[25]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_3d [25]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_4d [25]));
  AL_DFF_X \u2_wrrd/app_wr_din_4d_reg[26]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_3d [26]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_4d [26]));
  AL_DFF_X \u2_wrrd/app_wr_din_4d_reg[27]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_3d [27]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_4d [27]));
  AL_DFF_X \u2_wrrd/app_wr_din_4d_reg[28]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_3d [28]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_4d [28]));
  AL_DFF_X \u2_wrrd/app_wr_din_4d_reg[29]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_3d [29]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_4d [29]));
  AL_DFF_X \u2_wrrd/app_wr_din_4d_reg[2]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_3d [2]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_4d [2]));
  AL_DFF_X \u2_wrrd/app_wr_din_4d_reg[30]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_3d [30]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_4d [30]));
  AL_DFF_X \u2_wrrd/app_wr_din_4d_reg[31]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_3d [31]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_4d [31]));
  AL_DFF_X \u2_wrrd/app_wr_din_4d_reg[3]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_3d [3]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_4d [3]));
  AL_DFF_X \u2_wrrd/app_wr_din_4d_reg[4]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_3d [4]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_4d [4]));
  AL_DFF_X \u2_wrrd/app_wr_din_4d_reg[5]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_3d [5]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_4d [5]));
  AL_DFF_X \u2_wrrd/app_wr_din_4d_reg[6]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_3d [6]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_4d [6]));
  AL_DFF_X \u2_wrrd/app_wr_din_4d_reg[7]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_3d [7]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_4d [7]));
  AL_DFF_X \u2_wrrd/app_wr_din_4d_reg[8]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_3d [8]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_4d [8]));
  AL_DFF_X \u2_wrrd/app_wr_din_4d_reg[9]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_3d [9]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_4d [9]));
  AL_DFF_X \u2_wrrd/app_wr_din_5d_reg[0]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_4d [0]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_5d [0]));
  AL_DFF_X \u2_wrrd/app_wr_din_5d_reg[10]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_4d [10]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_5d [10]));
  AL_DFF_X \u2_wrrd/app_wr_din_5d_reg[11]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_4d [11]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_5d [11]));
  AL_DFF_X \u2_wrrd/app_wr_din_5d_reg[12]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_4d [12]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_5d [12]));
  AL_DFF_X \u2_wrrd/app_wr_din_5d_reg[13]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_4d [13]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_5d [13]));
  AL_DFF_X \u2_wrrd/app_wr_din_5d_reg[14]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_4d [14]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_5d [14]));
  AL_DFF_X \u2_wrrd/app_wr_din_5d_reg[15]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_4d [15]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_5d [15]));
  AL_DFF_X \u2_wrrd/app_wr_din_5d_reg[16]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_4d [16]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_5d [16]));
  AL_DFF_X \u2_wrrd/app_wr_din_5d_reg[17]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_4d [17]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_5d [17]));
  AL_DFF_X \u2_wrrd/app_wr_din_5d_reg[18]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_4d [18]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_5d [18]));
  AL_DFF_X \u2_wrrd/app_wr_din_5d_reg[19]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_4d [19]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_5d [19]));
  AL_DFF_X \u2_wrrd/app_wr_din_5d_reg[1]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_4d [1]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_5d [1]));
  AL_DFF_X \u2_wrrd/app_wr_din_5d_reg[20]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_4d [20]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_5d [20]));
  AL_DFF_X \u2_wrrd/app_wr_din_5d_reg[21]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_4d [21]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_5d [21]));
  AL_DFF_X \u2_wrrd/app_wr_din_5d_reg[22]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_4d [22]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_5d [22]));
  AL_DFF_X \u2_wrrd/app_wr_din_5d_reg[23]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_4d [23]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_5d [23]));
  AL_DFF_X \u2_wrrd/app_wr_din_5d_reg[24]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_4d [24]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_5d [24]));
  AL_DFF_X \u2_wrrd/app_wr_din_5d_reg[25]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_4d [25]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_5d [25]));
  AL_DFF_X \u2_wrrd/app_wr_din_5d_reg[26]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_4d [26]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_5d [26]));
  AL_DFF_X \u2_wrrd/app_wr_din_5d_reg[27]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_4d [27]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_5d [27]));
  AL_DFF_X \u2_wrrd/app_wr_din_5d_reg[28]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_4d [28]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_5d [28]));
  AL_DFF_X \u2_wrrd/app_wr_din_5d_reg[29]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_4d [29]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_5d [29]));
  AL_DFF_X \u2_wrrd/app_wr_din_5d_reg[2]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_4d [2]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_5d [2]));
  AL_DFF_X \u2_wrrd/app_wr_din_5d_reg[30]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_4d [30]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_5d [30]));
  AL_DFF_X \u2_wrrd/app_wr_din_5d_reg[31]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_4d [31]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_5d [31]));
  AL_DFF_X \u2_wrrd/app_wr_din_5d_reg[3]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_4d [3]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_5d [3]));
  AL_DFF_X \u2_wrrd/app_wr_din_5d_reg[4]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_4d [4]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_5d [4]));
  AL_DFF_X \u2_wrrd/app_wr_din_5d_reg[5]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_4d [5]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_5d [5]));
  AL_DFF_X \u2_wrrd/app_wr_din_5d_reg[6]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_4d [6]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_5d [6]));
  AL_DFF_X \u2_wrrd/app_wr_din_5d_reg[7]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_4d [7]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_5d [7]));
  AL_DFF_X \u2_wrrd/app_wr_din_5d_reg[8]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_4d [8]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_5d [8]));
  AL_DFF_X \u2_wrrd/app_wr_din_5d_reg[9]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_4d [9]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_5d [9]));
  AL_DFF_X \u2_wrrd/app_wr_din_6d_reg[0]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_5d [0]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_6d [0]));
  AL_DFF_X \u2_wrrd/app_wr_din_6d_reg[10]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_5d [10]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_6d [10]));
  AL_DFF_X \u2_wrrd/app_wr_din_6d_reg[11]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_5d [11]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_6d [11]));
  AL_DFF_X \u2_wrrd/app_wr_din_6d_reg[12]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_5d [12]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_6d [12]));
  AL_DFF_X \u2_wrrd/app_wr_din_6d_reg[13]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_5d [13]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_6d [13]));
  AL_DFF_X \u2_wrrd/app_wr_din_6d_reg[14]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_5d [14]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_6d [14]));
  AL_DFF_X \u2_wrrd/app_wr_din_6d_reg[15]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_5d [15]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_6d [15]));
  AL_DFF_X \u2_wrrd/app_wr_din_6d_reg[16]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_5d [16]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_6d [16]));
  AL_DFF_X \u2_wrrd/app_wr_din_6d_reg[17]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_5d [17]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_6d [17]));
  AL_DFF_X \u2_wrrd/app_wr_din_6d_reg[18]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_5d [18]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_6d [18]));
  AL_DFF_X \u2_wrrd/app_wr_din_6d_reg[19]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_5d [19]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_6d [19]));
  AL_DFF_X \u2_wrrd/app_wr_din_6d_reg[1]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_5d [1]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_6d [1]));
  AL_DFF_X \u2_wrrd/app_wr_din_6d_reg[20]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_5d [20]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_6d [20]));
  AL_DFF_X \u2_wrrd/app_wr_din_6d_reg[21]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_5d [21]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_6d [21]));
  AL_DFF_X \u2_wrrd/app_wr_din_6d_reg[22]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_5d [22]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_6d [22]));
  AL_DFF_X \u2_wrrd/app_wr_din_6d_reg[23]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_5d [23]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_6d [23]));
  AL_DFF_X \u2_wrrd/app_wr_din_6d_reg[24]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_5d [24]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_6d [24]));
  AL_DFF_X \u2_wrrd/app_wr_din_6d_reg[25]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_5d [25]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_6d [25]));
  AL_DFF_X \u2_wrrd/app_wr_din_6d_reg[26]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_5d [26]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_6d [26]));
  AL_DFF_X \u2_wrrd/app_wr_din_6d_reg[27]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_5d [27]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_6d [27]));
  AL_DFF_X \u2_wrrd/app_wr_din_6d_reg[28]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_5d [28]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_6d [28]));
  AL_DFF_X \u2_wrrd/app_wr_din_6d_reg[29]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_5d [29]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_6d [29]));
  AL_DFF_X \u2_wrrd/app_wr_din_6d_reg[2]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_5d [2]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_6d [2]));
  AL_DFF_X \u2_wrrd/app_wr_din_6d_reg[30]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_5d [30]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_6d [30]));
  AL_DFF_X \u2_wrrd/app_wr_din_6d_reg[31]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_5d [31]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_6d [31]));
  AL_DFF_X \u2_wrrd/app_wr_din_6d_reg[3]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_5d [3]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_6d [3]));
  AL_DFF_X \u2_wrrd/app_wr_din_6d_reg[4]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_5d [4]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_6d [4]));
  AL_DFF_X \u2_wrrd/app_wr_din_6d_reg[5]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_5d [5]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_6d [5]));
  AL_DFF_X \u2_wrrd/app_wr_din_6d_reg[6]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_5d [6]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_6d [6]));
  AL_DFF_X \u2_wrrd/app_wr_din_6d_reg[7]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_5d [7]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_6d [7]));
  AL_DFF_X \u2_wrrd/app_wr_din_6d_reg[8]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_5d [8]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_6d [8]));
  AL_DFF_X \u2_wrrd/app_wr_din_6d_reg[9]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_din_5d [9]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_din_6d [9]));
  AL_DFF_X \u2_wrrd/app_wr_dm_2d_reg[0]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_dm_1d [0]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_dm_2d [0]));
  AL_DFF_X \u2_wrrd/app_wr_dm_2d_reg[1]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_dm_1d [1]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_dm_2d [1]));
  AL_DFF_X \u2_wrrd/app_wr_dm_2d_reg[2]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_dm_1d [2]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_dm_2d [2]));
  AL_DFF_X \u2_wrrd/app_wr_dm_2d_reg[3]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_dm_1d [3]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_dm_2d [3]));
  AL_DFF_X \u2_wrrd/app_wr_dm_3d_reg[0]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_dm_2d [0]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_dm_3d [0]));
  AL_DFF_X \u2_wrrd/app_wr_dm_3d_reg[1]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_dm_2d [1]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_dm_3d [1]));
  AL_DFF_X \u2_wrrd/app_wr_dm_3d_reg[2]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_dm_2d [2]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_dm_3d [2]));
  AL_DFF_X \u2_wrrd/app_wr_dm_3d_reg[3]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_dm_2d [3]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_dm_3d [3]));
  AL_DFF_X \u2_wrrd/app_wr_dm_4d_reg[0]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_dm_3d [0]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_dm_4d [0]));
  AL_DFF_X \u2_wrrd/app_wr_dm_4d_reg[1]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_dm_3d [1]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_dm_4d [1]));
  AL_DFF_X \u2_wrrd/app_wr_dm_4d_reg[2]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_dm_3d [2]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_dm_4d [2]));
  AL_DFF_X \u2_wrrd/app_wr_dm_4d_reg[3]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_dm_3d [3]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_dm_4d [3]));
  AL_DFF_X \u2_wrrd/app_wr_dm_5d_reg[0]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_dm_4d [0]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_dm_5d [0]));
  AL_DFF_X \u2_wrrd/app_wr_dm_5d_reg[1]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_dm_4d [1]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_dm_5d [1]));
  AL_DFF_X \u2_wrrd/app_wr_dm_5d_reg[2]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_dm_4d [2]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_dm_5d [2]));
  AL_DFF_X \u2_wrrd/app_wr_dm_5d_reg[3]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_dm_4d [3]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_dm_5d [3]));
  AL_DFF_X \u2_wrrd/app_wr_dm_6d_reg[0]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_dm_5d [0]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_dm_6d [0]));
  AL_DFF_X \u2_wrrd/app_wr_dm_6d_reg[1]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_dm_5d [1]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_dm_6d [1]));
  AL_DFF_X \u2_wrrd/app_wr_dm_6d_reg[2]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_dm_5d [2]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_dm_6d [2]));
  AL_DFF_X \u2_wrrd/app_wr_dm_6d_reg[3]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_dm_5d [3]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_dm_6d [3]));
  AL_DFF_X \u2_wrrd/app_wr_en_sft_reg[1]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_en_sft [0]),
    .en(1'b1),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_en_sft [1]));
  AL_DFF_X \u2_wrrd/app_wr_en_sft_reg[2]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_en_sft [1]),
    .en(1'b1),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_en_sft [2]));
  AL_DFF_X \u2_wrrd/app_wr_en_sft_reg[3]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_en_sft [2]),
    .en(1'b1),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_en_sft [3]));
  AL_DFF_X \u2_wrrd/app_wr_en_sft_reg[4]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_en_sft [3]),
    .en(1'b1),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_en_sft [4]));
  AL_DFF_X \u2_wrrd/app_wr_en_sft_reg[5]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_en_sft [4]),
    .en(1'b1),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_en_sft [5]));
  AL_DFF_X \u2_wrrd/app_wr_en_sft_reg[6]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_en_sft [5]),
    .en(1'b1),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_en_sft [6]));
  AL_DFF_X \u2_wrrd/app_wr_en_sft_reg[7]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/app_wr_en_sft [6]),
    .en(1'b1),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u2_wrrd/app_wr_en_sft [7]));
  AL_DFF_X \u2_wrrd/ba_reg[0]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/ba_reg[0]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/ba [0]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    \u2_wrrd/ba_reg[0]_syn_3  (
    .a(\u2_wrrd/active_en ),
    .b(\u2_wrrd/active_ba [0]),
    .c(\u2_wrrd/ba [0]),
    .o(\u2_wrrd/ba_reg[0]_syn_2 ));
  AL_DFF_X \u2_wrrd/ba_reg[1]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/ba_reg[1]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/ba [1]));
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    \u2_wrrd/ba_reg[1]_syn_3  (
    .a(\u2_wrrd/active_en ),
    .b(\u2_wrrd/active_ba [1]),
    .c(\u2_wrrd/ba [1]),
    .o(\u2_wrrd/ba_reg[1]_syn_2 ));
  AL_DFF_X \u2_wrrd/cas_reg  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/cas_reg_syn_3 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/cas ));
  AL_MAP_LUT4 #(
    .EQN("~(B*~A*(D@C))"),
    .INIT(16'hfbbf))
    \u2_wrrd/cas_reg_syn_4  (
    .a(\u2_wrrd/active_en ),
    .b(\u2_wrrd/col_en ),
    .c(\u2_wrrd/app_rd_en_sft [1]),
    .d(\u2_wrrd/app_wr_en_sft [1]),
    .o(\u2_wrrd/cas_reg_syn_3 ));
  AL_DFF_X \u2_wrrd/cnt4_reg[0]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/cnt4_reg[0]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/cnt4 [0]));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*~A)"),
    .INIT(8'h01))
    \u2_wrrd/cnt4_reg[0]_syn_3  (
    .a(\u2_wrrd/mux1_syn_72 ),
    .b(Rst_dup_175),
    .c(\u2_wrrd/cnt4 [0]),
    .o(\u2_wrrd/cnt4_reg[0]_syn_2 ));
  AL_DFF_X \u2_wrrd/cnt4_reg[1]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/cnt4_reg[1]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/cnt4 [1]));
  AL_MAP_LUT4 #(
    .EQN("(~B*~A*(D@C))"),
    .INIT(16'h0110))
    \u2_wrrd/cnt4_reg[1]_syn_3  (
    .a(\u2_wrrd/mux1_syn_72 ),
    .b(Rst_dup_175),
    .c(\u2_wrrd/cnt4 [0]),
    .d(\u2_wrrd/cnt4 [1]),
    .o(\u2_wrrd/cnt4_reg[1]_syn_2 ));
  AL_DFF_X \u2_wrrd/col_en_reg  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/col_en_reg_syn_3 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/col_en ));
  AL_MAP_LUT4 #(
    .EQN("(D*C*~B*~A)"),
    .INIT(16'h1000))
    \u2_wrrd/col_en_reg_syn_4  (
    .a(\u2_wrrd/mux1_syn_72 ),
    .b(Rst_dup_175),
    .c(\u2_wrrd/cnt4 [0]),
    .d(\u2_wrrd/cnt4 [1]),
    .o(\u2_wrrd/col_en_reg_syn_3 ));
  AL_DFF_X \u2_wrrd/init_ref_vld_1d_reg  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(Sdr_init_ref_vld_dup_1),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/init_ref_vld_1d ));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    \u2_wrrd/mux1_syn_71  (
    .a(\u2_wrrd/app_rd_en_sft [0]),
    .b(\u2_wrrd/app_wr_en_sft [0]),
    .o(\u2_wrrd/mux1_syn_72 ));
  AL_MAP_LUT3 #(
    .EQN("(C*B*~A)"),
    .INIT(8'h40))
    \u2_wrrd/mux1_syn_73  (
    .a(\u2_wrrd/mux1_syn_72 ),
    .b(\u2_wrrd/cnt4 [0]),
    .c(\u2_wrrd/cnt4 [1]),
    .o(\u2_wrrd/mux1_syn_2 [7]));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*~A)"),
    .INIT(8'h01))
    \u2_wrrd/mux21_syn_23  (
    .a(\u2_wrrd/mux1_syn_72 ),
    .b(\u2_wrrd/cnt4 [0]),
    .c(\u2_wrrd/cnt4 [1]),
    .o(\u2_wrrd/mux21_syn_2 [0]));
  AL_MAP_LUT2 #(
    .EQN("~(~B*~A)"),
    .INIT(4'he))
    \u2_wrrd/mux4_syn_85  (
    .a(\u2_wrrd/active_en ),
    .b(\u2_wrrd/col_en ),
    .o(\u2_wrrd/mux4_syn_2 [10]));
  AL_DFF_X \u2_wrrd/ras_reg  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/active_en_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/ras ));
  AL_DFF_X \u2_wrrd/ref_ack_reg  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/ref_ack_reg_syn_3 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/ref_ack ));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    \u2_wrrd/ref_ack_reg_syn_4  (
    .a(\u2_wrrd/rw_vld ),
    .b(\u2_wrrd/Sdr_ref_req_syn_4 ),
    .o(\u2_wrrd/ref_ack_reg_syn_3 ));
  AL_MAP_LUT2 #(
    .EQN("~(~B*~A)"),
    .INIT(4'he))
    \u2_wrrd/ref_over_n_syn_1  (
    .a(\u1_init_ref/init_vld ),
    .b(\u1_init_ref/ref_vld ),
    .o(Sdr_init_ref_vld_dup_1));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    \u2_wrrd/ref_over_n_syn_2  (
    .a(Sdr_init_ref_vld_dup_1),
    .b(\u2_wrrd/init_ref_vld_1d ),
    .o(\u2_wrrd/ref_over_n ));
  AL_DFF_X \u2_wrrd/ref_over_reg  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/ref_over_n ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/ref_over ));
  AL_DFF_X \u2_wrrd/ref_vld_reg  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/ref_vld_reg_syn_5 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/ref_vld ));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(~C*~B))"),
    .INIT(8'h54))
    \u2_wrrd/ref_vld_reg_syn_6  (
    .a(\u2_wrrd/ref_over ),
    .b(\u2_wrrd/ref_vld ),
    .c(\u2_wrrd/Sdr_ref_req_syn_4 ),
    .o(\u2_wrrd/ref_vld_reg_syn_5 ));
  AL_DFF_X \u2_wrrd/rw_vld_1d_reg  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/rw_vld ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/rw_vld_1d ));
  AL_DFF_X \u2_wrrd/rw_vld_reg  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/rw_vld_reg_syn_5 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/rw_vld ));
  AL_MAP_LUT5 #(
    .EQN("(A*~(E*~D)*~(~C*B))"),
    .INIT(32'ha200a2a2))
    \u2_wrrd/rw_vld_reg_syn_6  (
    .a(\u2_wrrd/sdr_t_reg_syn_7 ),
    .b(\u2_wrrd/mux1_syn_72 ),
    .c(\u2_wrrd/rw_vld ),
    .d(\u2_wrrd/app_rd_en_sft [9]),
    .e(\u2_wrrd/app_rd_en_sft [10]),
    .o(\u2_wrrd/rw_vld_reg_syn_5 ));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    \u2_wrrd/sdr_op_over_n_syn_1  (
    .a(\u2_wrrd/rw_vld_1d ),
    .b(\u2_wrrd/rw_vld ),
    .o(\u2_wrrd/sdr_op_over_n ));
  AL_DFF_X \u2_wrrd/sdr_op_over_reg  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/sdr_op_over_n ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/sdr_op_over ));
  AL_DFF_X \u2_wrrd/sdr_t_reg  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/sdr_t_reg_syn_5 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/sdr_t ));
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C*~B))"),
    .INIT(8'h45))
    \u2_wrrd/sdr_t_reg_syn_6  (
    .a(Rst_dup_175),
    .b(\u2_wrrd/app_wr_en_sft [6]),
    .c(\u2_wrrd/app_wr_en_sft [7]),
    .o(\u2_wrrd/sdr_t_reg_syn_7 ));
  AL_MAP_LUT5 #(
    .EQN("~(~(~E*~C*B)*~(D*A))"),
    .INIT(32'haa00ae0c))
    \u2_wrrd/sdr_t_reg_syn_8  (
    .a(\u2_wrrd/sdr_t_reg_syn_7 ),
    .b(\u2_wrrd/app_wr_en_sft [0]),
    .c(Rst_dup_175),
    .d(\u2_wrrd/sdr_t ),
    .e(\u2_wrrd/app_wr_en_sft [1]),
    .o(\u2_wrrd/sdr_t_reg_syn_5 ));
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+A*~(B)*~(C)*~(D)*~(E)+~(A)*~(B)*C*~(D)*~(E)+A*~(B)*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+A*~(B)*~(C)*D*~(E)+~(A)*~(B)*C*D*~(E)+A*~(B)*C*D*~(E)+~(A)*B*C*D*~(E)+A*B*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+~(A)*B*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+~(A)*B*C*~(D)*E+~(A)*~(B)*~(C)*D*E+A*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'hf755f333))
    \u2_wrrd/sel2_syn_100  (
    .a(\u2_wrrd/sel2_syn_96 ),
    .b(\u2_wrrd/sel2_syn_98 ),
    .c(\u2_wrrd/mux7_syn_2 [0]),
    .d(\u2_wrrd/state_reg_syn_1 [0]),
    .e(\u2_wrrd/state_reg_syn_1 [1]),
    .o(\u2_wrrd/sel2_syn_1 [0]));
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    \u2_wrrd/sel2_syn_90  (
    .a(\u2_wrrd/ref_vld ),
    .b(\u2_wrrd/sdr_op_over ),
    .o(\u2_wrrd/mux9_syn_1 [2]));
  AL_MAP_LUT4 #(
    .EQN("~(~(D*~B)*~(C*A))"),
    .INIT(16'hb3a0))
    \u2_wrrd/sel2_syn_91  (
    .a(\u2_wrrd/rw_vld ),
    .b(\u2_wrrd/sdr_op_over ),
    .c(\u2_wrrd/state_reg_syn_1 [0]),
    .d(\u2_wrrd/state_reg_syn_1 [1]),
    .o(\u2_wrrd/sel2_syn_1 [1]));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*A)"),
    .INIT(8'h20))
    \u2_wrrd/sel2_syn_92  (
    .a(\u2_wrrd/ref_vld ),
    .b(\u2_wrrd/rw_vld ),
    .c(\u2_wrrd/state_reg_syn_1 [0]),
    .o(\u2_wrrd/sel2_syn_93 ));
  AL_MAP_LUT5 #(
    .EQN("~(~A*~(E*~C)*~(D*B))"),
    .INIT(32'hefafeeaa))
    \u2_wrrd/sel2_syn_94  (
    .a(\u2_wrrd/sel2_syn_93 ),
    .b(\u2_wrrd/mux9_syn_1 [2]),
    .c(\u2_wrrd/ref_over ),
    .d(\u2_wrrd/state_reg_syn_1 [1]),
    .e(\u2_wrrd/state_reg_syn_1 [2]),
    .o(\u2_wrrd/sel2_syn_1 [2]));
  AL_MAP_LUT4 #(
    .EQN("(~(C*~B)*~(D*A))"),
    .INIT(16'h45cf))
    \u2_wrrd/sel2_syn_95  (
    .a(\u2_wrrd/ref_over ),
    .b(\u2_wrrd/ref_vld ),
    .c(\u2_wrrd/sdr_op_over ),
    .d(\u2_wrrd/state_reg_syn_1 [2]),
    .o(\u2_wrrd/sel2_syn_96 ));
  AL_MAP_LUT3 #(
    .EQN("~(~B*~(A)*~(C)+~B*A*~(C)+~(~B)*A*C+~B*A*C)"),
    .INIT(8'h5c))
    \u2_wrrd/sel2_syn_97  (
    .a(\u2_wrrd/ref_over ),
    .b(\u2_wrrd/state_reg_syn_1 [0]),
    .c(\u2_wrrd/state_reg_syn_1 [2]),
    .o(\u2_wrrd/sel2_syn_98 ));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    \u2_wrrd/sel2_syn_99  (
    .a(\u2_wrrd/ref_vld ),
    .b(\u2_wrrd/rw_vld ),
    .o(\u2_wrrd/mux7_syn_2 [0]));
  AL_DFF_X #(
    .INIT(1'b1))
    \u2_wrrd/state_reg[0]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/sel2_syn_1 [0]),
    .en(1'b1),
    .sr(1'b0),
    .ss(Rst_dup_175),
    .q(\u2_wrrd/state_reg_syn_1 [0]));
  AL_DFF_X #(
    .INIT(1'b0))
    \u2_wrrd/state_reg[1]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/sel2_syn_1 [1]),
    .en(1'b1),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u2_wrrd/state_reg_syn_1 [1]));
  AL_DFF_X #(
    .INIT(1'b0))
    \u2_wrrd/state_reg[2]  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/sel2_syn_1 [2]),
    .en(1'b1),
    .sr(Rst_dup_175),
    .ss(1'b0),
    .q(\u2_wrrd/state_reg_syn_1 [2]));
  AL_DFF_X \u2_wrrd/we_reg  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/we_reg_syn_3 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/we ));
  AL_MAP_LUT4 #(
    .EQN("~(D*~C*B*~A)"),
    .INIT(16'hfbff))
    \u2_wrrd/we_reg_syn_4  (
    .a(\u2_wrrd/active_en ),
    .b(\u2_wrrd/col_en ),
    .c(\u2_wrrd/app_rd_en_sft [1]),
    .d(\u2_wrrd/app_wr_en_sft [1]),
    .o(\u2_wrrd/we_reg_syn_3 ));
  AL_DFF_X \u2_wrrd/wrrd_ref_ack_reg  (
    .ar(1'b0),
    .as(1'b0),
    .clk(Sdr_clk_dup_1),
    .d(\u2_wrrd/mux9_syn_1 [2]),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\u2_wrrd/wrrd_ref_ack ));

endmodule 


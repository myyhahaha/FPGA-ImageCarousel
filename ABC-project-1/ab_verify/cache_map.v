// Verilog netlist created by Tang Dynasty v6.2.168116
// Fri Oct 30 15:47:35 2026

`timescale 1ns / 1ps
module ab_image_cache_ctrl  // ../../RTL_1/bridge/abc_hdmi_top.v(211)
  (
  auto_pressed,
  clk,
  fill_done,
  next_pressed,
  prev_pressed,
  rst,
  source_done,
  source_status,
  switch_ack,
  disp_img,
  display_valid,
  load_img,
  load_restart,
  preload_done,
  preview_done,
  switch_base,
  switch_req,
  wr_base
  );

  input auto_pressed;  // ../../RTL_1/bridge/abc_hdmi_top.v(212)
  input clk;  // ../../RTL_1/bridge/abc_hdmi_top.v(212)
  input fill_done;  // ../../RTL_1/bridge/abc_hdmi_top.v(213)
  input next_pressed;  // ../../RTL_1/bridge/abc_hdmi_top.v(212)
  input prev_pressed;  // ../../RTL_1/bridge/abc_hdmi_top.v(212)
  input rst;  // ../../RTL_1/bridge/abc_hdmi_top.v(212)
  input source_done;  // ../../RTL_1/bridge/abc_hdmi_top.v(213)
  input [7:0] source_status;  // ../../RTL_1/bridge/abc_hdmi_top.v(213)
  input switch_ack;  // ../../RTL_1/bridge/abc_hdmi_top.v(215)
  output [3:0] disp_img;  // ../../RTL_1/bridge/abc_hdmi_top.v(216)
  output display_valid;  // ../../RTL_1/bridge/abc_hdmi_top.v(216)
  output [3:0] load_img;  // ../../RTL_1/bridge/abc_hdmi_top.v(214)
  output load_restart;  // ../../RTL_1/bridge/abc_hdmi_top.v(214)
  output preload_done;  // ../../RTL_1/bridge/abc_hdmi_top.v(216)
  output preview_done;  // ../../RTL_1/bridge/abc_hdmi_top.v(216)
  output [20:0] switch_base;  // ../../RTL_1/bridge/abc_hdmi_top.v(215)
  output switch_req;  // ../../RTL_1/bridge/abc_hdmi_top.v(215)
  output [20:0] wr_base;  // ../../RTL_1/bridge/abc_hdmi_top.v(214)

  // localparam FIRST_IMAGE = 4'b0001;
  // localparam L_DONE = 1;
  // localparam L_IDLE = 2;
  // localparam L_LAUNCH = 3;
  // localparam L_LOW = 0;
  wire  display_valid_i_syn_2;  // ../../RTL_1/bridge/abc_hdmi_top.v(284)
  wire [8:0] failed;  // ../../RTL_1/bridge/abc_hdmi_top.v(222)
  wire [5:0] key_count;  // ../../RTL_1/bridge/abc_hdmi_top.v(233)
  wire [5:0] key_count_b1;
  wire [4:0] key_head;  // ../../RTL_1/bridge/abc_hdmi_top.v(232)
  wire [31:0] key_queue;  // ../../RTL_1/bridge/abc_hdmi_top.v(231)
  wire [4:0] key_tail;  // ../../RTL_1/bridge/abc_hdmi_top.v(232)
  wire [3:0] load_img_b;
  wire [3:0] load_state_reg_syn_1;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire  mux0_syn_32;  // ../../RTL_1/bridge/abc_hdmi_top.v(255)
  wire  mux0_syn_39;  // ../../RTL_1/bridge/abc_hdmi_top.v(255)
  wire  mux0_syn_41;  // ../../RTL_1/bridge/abc_hdmi_top.v(255)
  wire [3:0] mux13_syn_2;  // ../../RTL_1/bridge/abc_hdmi_top.v(284)
  wire  preview_done_i_syn_2;  // ../../RTL_1/bridge/abc_hdmi_top.v(284)
  wire [3:0] preview_step;  // ../../RTL_1/bridge/abc_hdmi_top.v(228)
  wire [13:0] sel1_syn_2;  // ../../RTL_1/bridge/abc_hdmi_top.v(243)
  wire [3:0] switch_img;  // ../../RTL_1/bridge/abc_hdmi_top.v(224)
  wire [3:0] target_b2;
  wire [3:0] target_b3;
  wire [7:0] valid;  // ../../RTL_1/bridge/abc_hdmi_top.v(221)
  wire [20:0] wr_base_b;
  wire add1_syn_22;  // ../../RTL_1/bridge/abc_hdmi_top.v(297)
  wire add2_syn_26;  // ../../RTL_1/bridge/abc_hdmi_top.v(299)
  wire add3_syn_31;  // ../../RTL_1/bridge/abc_hdmi_top.v(301)
  wire add3_syn_32;  // ../../RTL_1/bridge/abc_hdmi_top.v(301)
  wire add3_syn_33;  // ../../RTL_1/bridge/abc_hdmi_top.v(301)
  wire add3_syn_34;  // ../../RTL_1/bridge/abc_hdmi_top.v(301)
  wire add3_syn_35;  // ../../RTL_1/bridge/abc_hdmi_top.v(301)
  wire add3_syn_36;  // ../../RTL_1/bridge/abc_hdmi_top.v(301)
  wire auto_pending_reg_syn_3;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire auto_pending_reg_syn_5;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire commit_pending_reg_syn_3;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire display_valid_reg_syn_3;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire mux35_syn_27;  // ../../RTL_1/bridge/abc_hdmi_top.v(308)
  wire mux35_syn_33;  // ../../RTL_1/bridge/abc_hdmi_top.v(308)
  wire mux35_syn_47;  // ../../RTL_1/bridge/abc_hdmi_top.v(308)
  wire mux35_syn_51;  // ../../RTL_1/bridge/abc_hdmi_top.v(308)
  wire mux35_syn_63;  // ../../RTL_1/bridge/abc_hdmi_top.v(308)
  wire mux35_syn_67;  // ../../RTL_1/bridge/abc_hdmi_top.v(308)
  wire mux35_syn_70;  // ../../RTL_1/bridge/abc_hdmi_top.v(308)
  wire mux35_syn_72;  // ../../RTL_1/bridge/abc_hdmi_top.v(308)
  wire mux35_syn_77;  // ../../RTL_1/bridge/abc_hdmi_top.v(308)
  wire mux35_syn_79;  // ../../RTL_1/bridge/abc_hdmi_top.v(308)
  wire mux35_syn_82;  // ../../RTL_1/bridge/abc_hdmi_top.v(308)
  wire mux35_syn_84;  // ../../RTL_1/bridge/abc_hdmi_top.v(308)
  wire mux35_syn_86;  // ../../RTL_1/bridge/abc_hdmi_top.v(308)
  wire mux35_syn_88;  // ../../RTL_1/bridge/abc_hdmi_top.v(308)
  wire mux35_syn_90;  // ../../RTL_1/bridge/abc_hdmi_top.v(308)
  wire mux35_syn_92;  // ../../RTL_1/bridge/abc_hdmi_top.v(308)
  wire mux35_syn_94;  // ../../RTL_1/bridge/abc_hdmi_top.v(308)
  wire mux35_syn_96;  // ../../RTL_1/bridge/abc_hdmi_top.v(308)
  wire mux36_syn_20;  // ../../RTL_1/bridge/abc_hdmi_top.v(308)
  wire mux38_syn_44;  // ../../RTL_1/bridge/abc_hdmi_top.v(308)
  wire mux38_syn_54;  // ../../RTL_1/bridge/abc_hdmi_top.v(308)
  wire mux38_syn_64;  // ../../RTL_1/bridge/abc_hdmi_top.v(308)
  wire mux38_syn_74;  // ../../RTL_1/bridge/abc_hdmi_top.v(308)
  wire mux38_syn_84;  // ../../RTL_1/bridge/abc_hdmi_top.v(308)
  wire mux38_syn_94;  // ../../RTL_1/bridge/abc_hdmi_top.v(308)
  wire mux38_syn_104;  // ../../RTL_1/bridge/abc_hdmi_top.v(308)
  wire mux38_syn_114;  // ../../RTL_1/bridge/abc_hdmi_top.v(308)
  wire preview_done_reg_syn_3;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire preview_done_reg_syn_7;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire sel1_syn_186;  // ../../RTL_1/bridge/abc_hdmi_top.v(243)
  wire sel1_syn_192;  // ../../RTL_1/bridge/abc_hdmi_top.v(243)
  wire switch_req_reg_syn_3;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire auto_pending;  // ../../RTL_1/bridge/abc_hdmi_top.v(225)
  wire auto_pending_n10;
  wire auto_pending_n3;
  wire auto_pressed_dup_1;  // ../../RTL_1/bridge/abc_hdmi_top.v(212)
  wire backwards;  // ../../RTL_1/bridge/abc_hdmi_top.v(255)
  wire clk_dup_1;  // ../../RTL_1/bridge/abc_hdmi_top.v(212)
  wire commit_pending;  // ../../RTL_1/bridge/abc_hdmi_top.v(225)
  wire \disp_img[3]_dup_3 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(216)
  wire \disp_img[2]_dup_3 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(216)
  wire \disp_img[1]_dup_3 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(216)
  wire \disp_img[0]_dup_5 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(216)
  wire display_valid_dup_3;  // ../../RTL_1/bridge/abc_hdmi_top.v(216)
  wire failed_b2_n2;
  wire fill_done_dup_1;  // ../../RTL_1/bridge/abc_hdmi_top.v(213)
  wire key_count_b_n;
  wire key_count_b_n1;
  wire key_queue_b_n32;
  wire launch_switch;  // ../../RTL_1/bridge/abc_hdmi_top.v(259)
  wire launch_switch_n3;
  wire \load_img[3]_dup_3 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(214)
  wire \load_img[2]_dup_3 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(214)
  wire \load_img[1]_dup_3 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(214)
  wire \load_img[0]_dup_3 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(214)
  wire load_img_b1_n_syn_2;
  wire \wr_base_b[16]_syn_2 ;
  wire \wr_base_b[13]_syn_2 ;
  wire \wr_base_b[9]_syn_3 ;
  wire \wr_base_b[9]_syn_6 ;
  wire \wr_base_b[9]_syn_8 ;
  wire \wr_base_b[9]_syn_10 ;
  wire \wr_base_b[9]_syn_12 ;
  wire \wr_base_b[9]_syn_14 ;
  wire \wanted_b[0]_syn_2 ;
  wire next_pressed_dup_1;  // ../../RTL_1/bridge/abc_hdmi_top.v(212)
  wire preload_done_dup_1;  // ../../RTL_1/bridge/abc_hdmi_top.v(216)
  wire preload_done_n2;
  wire prev_pressed_dup_1;  // ../../RTL_1/bridge/abc_hdmi_top.v(212)
  wire preview_done_dup_3;  // ../../RTL_1/bridge/abc_hdmi_top.v(216)
  wire rst_dup_1;  // ../../RTL_1/bridge/abc_hdmi_top.v(212)
  wire source_done_dup_1;  // ../../RTL_1/bridge/abc_hdmi_top.v(213)
  wire \source_status[7]_dup_1 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(213)
  wire \source_status[6]_dup_1 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(213)
  wire \source_status[5]_dup_1 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(213)
  wire \source_status[4]_dup_1 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(213)
  wire \source_status[3]_dup_1 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(213)
  wire \source_status[2]_dup_1 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(213)
  wire \source_status[1]_dup_1 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(213)
  wire \source_status[0]_dup_1 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(213)
  wire switch_ack_dup_1;  // ../../RTL_1/bridge/abc_hdmi_top.v(215)
  wire \switch_base[8]_dup_3 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(215)
  wire switch_req_dup_3;  // ../../RTL_1/bridge/abc_hdmi_top.v(215)
  wire switch_req_n2;
  wire \wanted[2]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(263)
  wire wanted_b3_n3;
  wire \disp_img_reg[0]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \disp_img_reg[1]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \disp_img_reg[2]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \disp_img_reg[3]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \failed_reg[1]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \failed_reg[2]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \failed_reg[2]_syn_4 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \failed_reg[3]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \failed_reg[4]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \failed_reg[4]_syn_4 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \failed_reg[4]_syn_7 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \failed_reg[4]_syn_9 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \failed_reg[5]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \failed_reg[6]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \failed_reg[7]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \failed_reg[8]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_count_reg[0]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_count_reg[1]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_count_reg[2]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_count_reg[3]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_count_reg[3]_syn_4 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_count_reg[3]_syn_7 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_count_reg[3]_syn_9 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_count_reg[3]_syn_11 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_count_reg[3]_syn_13 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_count_reg[3]_syn_15 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_count_reg[3]_syn_17 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_count_reg[3]_syn_19 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_count_reg[3]_syn_21 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_count_reg[3]_syn_23 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_count_reg[3]_syn_25 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_count_reg[3]_syn_27 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_count_reg[3]_syn_29 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_count_reg[3]_syn_31 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_count_reg[3]_syn_33 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_count_reg[3]_syn_35 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_count_reg[3]_syn_38 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_count_reg[3]_syn_41 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_count_reg[3]_syn_44 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_count_reg[3]_syn_46 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_count_reg[3]_syn_52 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_count_reg[3]_syn_54 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_count_reg[3]_syn_56 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_count_reg[3]_syn_58 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_count_reg[3]_syn_60 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_count_reg[3]_syn_62 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_count_reg[3]_syn_64 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_count_reg[3]_syn_66 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_count_reg[3]_syn_68 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_count_reg[3]_syn_71 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_count_reg[3]_syn_73 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_count_reg[3]_syn_75 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_count_reg[3]_syn_77 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_count_reg[3]_syn_79 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_count_reg[3]_syn_81 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_count_reg[3]_syn_83 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_count_reg[3]_syn_85 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_count_reg[3]_syn_87 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_count_reg[3]_syn_89 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_count_reg[3]_syn_92 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_count_reg[3]_syn_95 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_count_reg[4]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_count_reg[5]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_head_reg[0]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_head_reg[1]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_head_reg[2]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_head_reg[3]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_head_reg[4]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_head_reg[4]_syn_4 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_queue_reg[0]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_queue_reg[1]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_queue_reg[2]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_queue_reg[3]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_queue_reg[4]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_queue_reg[5]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_queue_reg[6]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_queue_reg[7]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_queue_reg[7]_syn_4 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_queue_reg[7]_syn_6 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_queue_reg[8]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_queue_reg[9]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_queue_reg[10]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_queue_reg[11]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_queue_reg[12]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_queue_reg[13]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_queue_reg[14]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_queue_reg[15]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_queue_reg[15]_syn_4 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_queue_reg[15]_syn_6 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_queue_reg[16]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_queue_reg[17]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_queue_reg[18]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_queue_reg[19]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_queue_reg[20]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_queue_reg[21]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_queue_reg[22]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_queue_reg[23]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_queue_reg[23]_syn_4 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_queue_reg[23]_syn_6 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_queue_reg[24]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_queue_reg[24]_syn_4 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_queue_reg[25]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_queue_reg[25]_syn_4 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_queue_reg[26]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_queue_reg[26]_syn_4 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_queue_reg[27]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_queue_reg[27]_syn_4 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_queue_reg[28]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_queue_reg[28]_syn_4 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_queue_reg[29]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_queue_reg[29]_syn_4 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_queue_reg[30]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_queue_reg[30]_syn_4 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_queue_reg[31]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_queue_reg[31]_syn_6 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_queue_reg[31]_syn_8 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_tail_reg[0]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_tail_reg[1]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_tail_reg[2]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_tail_reg[2]_syn_4 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_tail_reg[3]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_tail_reg[4]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \key_tail_reg[4]_syn_4 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \load_img_reg[0]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \load_img_reg[1]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \load_img_reg[2]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \load_img_reg[3]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \preview_step_reg[0]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \preview_step_reg[1]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \preview_step_reg[2]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \preview_step_reg[3]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \switch_base_reg[8]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \switch_img_reg[0]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \switch_img_reg[2]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \switch_img_reg[3]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \valid_reg[0]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \valid_reg[1]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \valid_reg[2]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \valid_reg[3]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \valid_reg[4]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \valid_reg[5]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \valid_reg[6]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  wire \valid_reg[7]_syn_2 ;  // ../../RTL_1/bridge/abc_hdmi_top.v(273)

  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    add3_syn_10 (
    .a(key_count[4]),
    .b(1'b0),
    .c(add3_syn_35),
    .o({add3_syn_36,key_count_b1[4]}));  // ../../RTL_1/bridge/abc_hdmi_top.v(301)
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    add3_syn_11 (
    .a(key_count[5]),
    .b(1'b0),
    .c(add3_syn_36),
    .o({open_n0,key_count_b1[5]}));  // ../../RTL_1/bridge/abc_hdmi_top.v(301)
  AL_MAP_ADDER #(
    .ALUTYPE("ADD_CARRY"))
    add3_syn_5 (
    .a(1'b0),
    .o({add3_syn_31,open_n3}));  // ../../RTL_1/bridge/abc_hdmi_top.v(301)
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    add3_syn_6 (
    .a(key_count[0]),
    .b(1'b1),
    .c(add3_syn_31),
    .o({add3_syn_32,open_n4}));  // ../../RTL_1/bridge/abc_hdmi_top.v(301)
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    add3_syn_7 (
    .a(key_count[1]),
    .b(1'b0),
    .c(add3_syn_32),
    .o({add3_syn_33,key_count_b1[1]}));  // ../../RTL_1/bridge/abc_hdmi_top.v(301)
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    add3_syn_8 (
    .a(key_count[2]),
    .b(1'b0),
    .c(add3_syn_33),
    .o({add3_syn_34,key_count_b1[2]}));  // ../../RTL_1/bridge/abc_hdmi_top.v(301)
  AL_MAP_ADDER #(
    .ALUTYPE("ADD"))
    add3_syn_9 (
    .a(key_count[3]),
    .b(1'b0),
    .c(add3_syn_34),
    .o({add3_syn_35,key_count_b1[3]}));  // ../../RTL_1/bridge/abc_hdmi_top.v(301)
  AL_DFF_X #(
    .INIT(1'b0))
    auto_pending_reg (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(auto_pending_reg_syn_3),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(auto_pending));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(~B*~(D*C*A))"),
    .INIT(16'h1333))
    auto_pending_reg_syn_4 (
    .a(auto_pending_n10),
    .b(auto_pending),
    .c(preview_done_dup_3),
    .d(auto_pressed_dup_1),
    .o(auto_pending_reg_syn_5));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(~C*~B*~(D*A))"),
    .INIT(16'h0103))
    auto_pending_reg_syn_6 (
    .a(launch_switch),
    .b(auto_pending_reg_syn_5),
    .c(auto_pending_n3),
    .d(display_valid_dup_3),
    .o(auto_pending_reg_syn_3));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  EG_PHY_PAD #(
    //.HYSTERESIS("OFF"),
    //.PCICLAMP("OFF"),
    .IOTYPE("LVCMOS25"),
    .MODE("IN"),
    .TSMUX("1"))
    auto_pressed_syn_2 (
    .ipad(auto_pressed),
    .di(auto_pressed_dup_1));  // ../../RTL_1/bridge/abc_hdmi_top.v(212)
  EG_PHY_PAD #(
    //.HYSTERESIS("OFF"),
    //.PCICLAMP("OFF"),
    .IOTYPE("LVCMOS25"),
    .MODE("IN"),
    .TSMUX("1"))
    clk_syn_2 (
    .ipad(clk),
    .di(clk_dup_1));  // ../../RTL_1/bridge/abc_hdmi_top.v(212)
  AL_DFF_X #(
    .INIT(1'b0))
    commit_pending_reg (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(commit_pending_reg_syn_3),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(commit_pending));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT3 #(
    .EQN("(A*~(C@B))"),
    .INIT(8'h82))
    commit_pending_reg_syn_4 (
    .a(commit_pending),
    .b(switch_req_dup_3),
    .c(switch_ack_dup_1),
    .o(display_valid_i_syn_2));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT3 #(
    .EQN("(~B*~(~C*~A))"),
    .INIT(8'h32))
    commit_pending_reg_syn_5 (
    .a(launch_switch),
    .b(display_valid_i_syn_2),
    .c(commit_pending),
    .o(commit_pending_reg_syn_3));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  EG_PHY_CONFIG #(
    .DONE_PERSISTN("ENABLE"),
    .INIT_PERSISTN("ENABLE"),
    .JTAG_PERSISTN("DISABLE"),
    .PROGRAMN_PERSISTN("DISABLE"))
    config_inst ();
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DO_DFFMODE("FF"),
    .DO_REGSET("SET"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .ODDRMODE("OFF"),
    .OUTCEMUX("CE"),
    .OUTRSTMUX("RST"),
    .OUTSCLKMUX("CLK"),
    .SRMODE("ASYNC"),
    .TSMUX("0"))
    \disp_img[0]_syn_6  (
    .ce(display_valid_i_syn_2),
    .do({open_n86,open_n87,open_n88,switch_img[0]}),
    .osclk(clk_dup_1),
    .rst(rst_dup_1),
    .opad(disp_img[0]));  // ../../RTL_1/bridge/abc_hdmi_top.v(216)
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
    .SRMODE("ASYNC"),
    .TSMUX("0"))
    \disp_img[1]_syn_4  (
    .ce(display_valid_i_syn_2),
    .do({open_n100,open_n101,open_n102,\switch_base[8]_dup_3 }),
    .osclk(clk_dup_1),
    .rst(rst_dup_1),
    .opad(disp_img[1]));  // ../../RTL_1/bridge/abc_hdmi_top.v(216)
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
    .SRMODE("ASYNC"),
    .TSMUX("0"))
    \disp_img[2]_syn_4  (
    .ce(display_valid_i_syn_2),
    .do({open_n114,open_n115,open_n116,switch_img[2]}),
    .osclk(clk_dup_1),
    .rst(rst_dup_1),
    .opad(disp_img[2]));  // ../../RTL_1/bridge/abc_hdmi_top.v(216)
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
    .SRMODE("ASYNC"),
    .TSMUX("0"))
    \disp_img[3]_syn_4  (
    .ce(display_valid_i_syn_2),
    .do({open_n128,open_n129,open_n130,switch_img[3]}),
    .osclk(clk_dup_1),
    .rst(rst_dup_1),
    .opad(disp_img[3]));  // ../../RTL_1/bridge/abc_hdmi_top.v(216)
  AL_DFF_X #(
    .INIT(1'b1))
    \disp_img_reg[0]  (
    .ar(1'b0),
    .as(rst_dup_1),
    .clk(clk_dup_1),
    .d(\disp_img_reg[0]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\disp_img[0]_dup_5 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    \disp_img_reg[0]_syn_3  (
    .a(display_valid_i_syn_2),
    .b(\disp_img[0]_dup_5 ),
    .c(switch_img[0]),
    .o(\disp_img_reg[0]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \disp_img_reg[1]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\disp_img_reg[1]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\disp_img[1]_dup_3 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    \disp_img_reg[1]_syn_3  (
    .a(display_valid_i_syn_2),
    .b(\disp_img[1]_dup_3 ),
    .c(\switch_base[8]_dup_3 ),
    .o(\disp_img_reg[1]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \disp_img_reg[2]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\disp_img_reg[2]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\disp_img[2]_dup_3 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    \disp_img_reg[2]_syn_3  (
    .a(display_valid_i_syn_2),
    .b(\disp_img[2]_dup_3 ),
    .c(switch_img[2]),
    .o(\disp_img_reg[2]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \disp_img_reg[3]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\disp_img_reg[3]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\disp_img[3]_dup_3 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT3 #(
    .EQN("(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'he4))
    \disp_img_reg[3]_syn_3  (
    .a(display_valid_i_syn_2),
    .b(\disp_img[3]_dup_3 ),
    .c(switch_img[3]),
    .o(\disp_img_reg[3]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    display_valid_reg (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(display_valid_reg_syn_3),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(display_valid_dup_3));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT2 #(
    .EQN("~(~B*~A)"),
    .INIT(4'he))
    display_valid_reg_syn_4 (
    .a(display_valid_i_syn_2),
    .b(display_valid_dup_3),
    .o(display_valid_reg_syn_3));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
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
    .SRMODE("ASYNC"),
    .TSMUX("0"))
    display_valid_syn_4 (
    .ce(display_valid_i_syn_2),
    .do({open_n142,open_n143,open_n144,1'b1}),
    .osclk(clk_dup_1),
    .rst(rst_dup_1),
    .opad(display_valid));  // ../../RTL_1/bridge/abc_hdmi_top.v(216)
  AL_DFF_X #(
    .INIT(1'b0))
    \failed_reg[1]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\failed_reg[1]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(failed[1]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT3 #(
    .EQN("(~C*B*A)"),
    .INIT(8'h08))
    \failed_reg[1]_syn_3  (
    .a(\failed_reg[2]_syn_4 ),
    .b(\load_img[0]_dup_3 ),
    .c(\load_img[1]_dup_3 ),
    .o(mux38_syn_44));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("~(~(D*~C)*~(~B*A))"),
    .INIT(16'h2f22))
    \failed_reg[1]_syn_4  (
    .a(mux38_syn_44),
    .b(\failed_reg[4]_syn_7 ),
    .c(\failed_reg[4]_syn_9 ),
    .d(failed[1]),
    .o(\failed_reg[1]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \failed_reg[2]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\failed_reg[2]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(failed[2]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*A)"),
    .INIT(8'h02))
    \failed_reg[2]_syn_3  (
    .a(mux35_syn_47),
    .b(\load_img[2]_dup_3 ),
    .c(\load_img[3]_dup_3 ),
    .o(\failed_reg[2]_syn_4 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT3 #(
    .EQN("(C*~B*A)"),
    .INIT(8'h20))
    \failed_reg[2]_syn_5  (
    .a(\failed_reg[2]_syn_4 ),
    .b(\load_img[0]_dup_3 ),
    .c(\load_img[1]_dup_3 ),
    .o(mux38_syn_54));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("~(~(D*~C)*~(~B*A))"),
    .INIT(16'h2f22))
    \failed_reg[2]_syn_6  (
    .a(mux38_syn_54),
    .b(\failed_reg[4]_syn_7 ),
    .c(\failed_reg[4]_syn_9 ),
    .d(failed[2]),
    .o(\failed_reg[2]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \failed_reg[3]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\failed_reg[3]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(failed[3]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    \failed_reg[3]_syn_3  (
    .a(\failed_reg[2]_syn_4 ),
    .b(\load_img[0]_dup_3 ),
    .c(\load_img[1]_dup_3 ),
    .o(mux38_syn_64));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("~(~(D*~C)*~(~B*A))"),
    .INIT(16'h2f22))
    \failed_reg[3]_syn_4  (
    .a(mux38_syn_64),
    .b(\failed_reg[4]_syn_7 ),
    .c(\failed_reg[4]_syn_9 ),
    .d(failed[3]),
    .o(\failed_reg[3]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \failed_reg[4]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\failed_reg[4]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(failed[4]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("~(~(D*~C)*~(~B*A))"),
    .INIT(16'h2f22))
    \failed_reg[4]_syn_10  (
    .a(mux38_syn_74),
    .b(\failed_reg[4]_syn_7 ),
    .c(\failed_reg[4]_syn_9 ),
    .d(failed[4]),
    .o(\failed_reg[4]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT3 #(
    .EQN("(~C*B*A)"),
    .INIT(8'h08))
    \failed_reg[4]_syn_3  (
    .a(mux35_syn_47),
    .b(\load_img[2]_dup_3 ),
    .c(\load_img[3]_dup_3 ),
    .o(\failed_reg[4]_syn_4 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*A)"),
    .INIT(8'h02))
    \failed_reg[4]_syn_5  (
    .a(\failed_reg[4]_syn_4 ),
    .b(\load_img[0]_dup_3 ),
    .c(\load_img[1]_dup_3 ),
    .o(mux38_syn_74));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    \failed_reg[4]_syn_6  (
    .a(\source_status[6]_dup_1 ),
    .b(mux35_syn_72),
    .o(\failed_reg[4]_syn_7 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    \failed_reg[4]_syn_8  (
    .a(mux36_syn_20),
    .b(auto_pending_n3),
    .o(\failed_reg[4]_syn_9 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \failed_reg[5]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\failed_reg[5]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(failed[5]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT3 #(
    .EQN("(~C*B*A)"),
    .INIT(8'h08))
    \failed_reg[5]_syn_3  (
    .a(\failed_reg[4]_syn_4 ),
    .b(\load_img[0]_dup_3 ),
    .c(\load_img[1]_dup_3 ),
    .o(mux38_syn_84));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("~(~(D*~C)*~(~B*A))"),
    .INIT(16'h2f22))
    \failed_reg[5]_syn_4  (
    .a(mux38_syn_84),
    .b(\failed_reg[4]_syn_7 ),
    .c(\failed_reg[4]_syn_9 ),
    .d(failed[5]),
    .o(\failed_reg[5]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \failed_reg[6]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\failed_reg[6]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(failed[6]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT3 #(
    .EQN("(C*~B*A)"),
    .INIT(8'h20))
    \failed_reg[6]_syn_3  (
    .a(\failed_reg[4]_syn_4 ),
    .b(\load_img[0]_dup_3 ),
    .c(\load_img[1]_dup_3 ),
    .o(mux38_syn_94));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("~(~(D*~C)*~(~B*A))"),
    .INIT(16'h2f22))
    \failed_reg[6]_syn_4  (
    .a(mux38_syn_94),
    .b(\failed_reg[4]_syn_7 ),
    .c(\failed_reg[4]_syn_9 ),
    .d(failed[6]),
    .o(\failed_reg[6]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \failed_reg[7]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\failed_reg[7]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(failed[7]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    \failed_reg[7]_syn_3  (
    .a(\failed_reg[4]_syn_4 ),
    .b(\load_img[0]_dup_3 ),
    .c(\load_img[1]_dup_3 ),
    .o(mux38_syn_104));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("~(~(D*~C)*~(~B*A))"),
    .INIT(16'h2f22))
    \failed_reg[7]_syn_4  (
    .a(mux38_syn_104),
    .b(\failed_reg[4]_syn_7 ),
    .c(\failed_reg[4]_syn_9 ),
    .d(failed[7]),
    .o(\failed_reg[7]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \failed_reg[8]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\failed_reg[8]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(failed[8]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT5 #(
    .EQN("(E*~D*~C*~B*A)"),
    .INIT(32'h00020000))
    \failed_reg[8]_syn_3  (
    .a(mux35_syn_47),
    .b(\load_img[0]_dup_3 ),
    .c(\load_img[1]_dup_3 ),
    .d(\load_img[2]_dup_3 ),
    .e(\load_img[3]_dup_3 ),
    .o(mux38_syn_114));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("~(~(D*~C)*~(~B*A))"),
    .INIT(16'h2f22))
    \failed_reg[8]_syn_4  (
    .a(mux38_syn_114),
    .b(\failed_reg[4]_syn_7 ),
    .c(\failed_reg[4]_syn_9 ),
    .d(failed[8]),
    .o(\failed_reg[8]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  EG_PHY_PAD #(
    //.HYSTERESIS("OFF"),
    //.PCICLAMP("OFF"),
    .IOTYPE("LVCMOS25"),
    .MODE("IN"),
    .TSMUX("1"))
    fill_done_syn_2 (
    .ipad(fill_done),
    .di(fill_done_dup_1));  // ../../RTL_1/bridge/abc_hdmi_top.v(213)
  AL_DFF_X #(
    .INIT(1'b0))
    \key_count_reg[0]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\key_count_reg[0]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(key_count[0]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    \key_count_reg[0]_syn_3  (
    .a(\key_count_reg[3]_syn_75 ),
    .b(\key_count_reg[3]_syn_87 ),
    .o(launch_switch));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT5 #(
    .EQN("(D@(A*B*~(C)*~(E)+~(A)*~(B)*C*~(E)+A*~(B)*C*~(E)+~(A)*B*C*~(E)+A*B*~(C)*E+A*~(B)*C*E))"),
    .INIT(32'hd7288778))
    \key_count_reg[0]_syn_4  (
    .a(launch_switch),
    .b(\key_count_reg[3]_syn_89 ),
    .c(auto_pending_n3),
    .d(key_count[0]),
    .e(key_count[5]),
    .o(\key_count_reg[0]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \key_count_reg[1]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\key_count_reg[1]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(key_count[1]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(~(A)*B*~(C)*~(D)+A*B*~(C)*~(D)+A*~(B)*C*~(D)+A*B*C*~(D)+~(A)*~(B)*~(C)*D+~(A)*B*~(C)*D+A*B*~(C)*D+~(A)*~(B)*C*D+A*~(B)*C*D+A*B*C*D)"),
    .INIT(16'hbdac))
    \key_count_reg[1]_syn_3  (
    .a(key_count_b_n),
    .b(key_count_b_n1),
    .c(key_count_b1[1]),
    .d(key_count[1]),
    .o(\key_count_reg[1]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \key_count_reg[2]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\key_count_reg[2]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(key_count[2]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT5 #(
    .EQN("(~(A)*B*C*~(D)*~(E)+A*B*C*~(D)*~(E)+A*~(B)*~(C)*D*~(E)+A*B*~(C)*D*~(E)+A*~(B)*C*D*~(E)+~(A)*B*C*D*~(E)+A*B*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+~(A)*B*~(C)*~(D)*E+A*B*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+~(A)*~(B)*~(C)*D*E+A*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+A*B*C*D*E)"),
    .INIT(32'hbf1deac0))
    \key_count_reg[2]_syn_3  (
    .a(key_count_b_n),
    .b(key_count_b_n1),
    .c(\key_count_reg[3]_syn_44 ),
    .d(key_count_b1[2]),
    .e(key_count[2]),
    .o(\key_count_reg[2]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \key_count_reg[3]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\key_count_reg[3]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(key_count[3]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)*~(E)+A*~(B)*~(C)*~(D)*~(E)+~(A)*B*~(C)*~(D)*~(E)+A*B*~(C)*~(D)*~(E)+~(A)*~(B)*C*~(D)*~(E)+~(A)*B*C*~(D)*~(E)+A*B*C*~(D)*~(E)+~(A)*~(B)*~(C)*D*~(E)+A*~(B)*~(C)*D*~(E)+A*B*~(C)*D*~(E)+~(A)*~(B)*C*D*~(E)+A*B*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+A*~(B)*~(C)*~(D)*E+~(A)*B*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+~(A)*B*C*~(D)*E+~(A)*~(B)*~(C)*D*E+A*~(B)*~(C)*D*E+~(A)*~(B)*C*D*E)"),
    .INIT(32'h13579bdf))
    \key_count_reg[3]_syn_10  (
    .a(key_head[0]),
    .b(key_head[1]),
    .c(key_queue[25]),
    .d(key_queue[26]),
    .e(key_queue[27]),
    .o(\key_count_reg[3]_syn_11 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT3 #(
    .EQN("(C*~B*~A)"),
    .INIT(8'h10))
    \key_count_reg[3]_syn_12  (
    .a(key_head[0]),
    .b(key_head[1]),
    .c(key_queue[24]),
    .o(\key_count_reg[3]_syn_13 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~((~C*B))*~(D)*~(E)+A*~((~C*B))*~(D)*~(E)+~(A)*(~C*B)*~(D)*~(E)+A*(~C*B)*~(D)*~(E)+~(A)*~((~C*B))*~(D)*E+A*~((~C*B))*~(D)*E+~(A)*~((~C*B))*D*E+~(A)*(~C*B)*D*E)"),
    .INIT(32'h55f300ff))
    \key_count_reg[3]_syn_14  (
    .a(\key_count_reg[3]_syn_9 ),
    .b(\key_count_reg[3]_syn_11 ),
    .c(\key_count_reg[3]_syn_13 ),
    .d(key_head[2]),
    .e(key_head[3]),
    .o(\key_count_reg[3]_syn_15 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(A*~(B)*~(C)*~(D)+A*~(B)*C*~(D)+~(A)*B*C*~(D)+A*~(B)*~(C)*D+A*B*~(C)*D+A*~(B)*C*D+~(A)*B*C*D+A*B*C*D)"),
    .INIT(16'hea62))
    \key_count_reg[3]_syn_16  (
    .a(key_head[0]),
    .b(key_head[1]),
    .c(key_queue[18]),
    .d(key_queue[19]),
    .o(\key_count_reg[3]_syn_17 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT5 #(
    .EQN("(~C*(~(A)*~(B)*~(D)*~(E)+A*~(B)*~(D)*~(E)+~(A)*B*~(D)*~(E)+A*~(B)*D*~(E)+~(A)*B*D*~(E)+~(A)*~(B)*~(D)*E+~(A)*B*~(D)*E+~(A)*B*D*E))"),
    .INIT(32'h04050607))
    \key_count_reg[3]_syn_18  (
    .a(\key_count_reg[3]_syn_17 ),
    .b(key_head[1]),
    .c(key_head[3]),
    .d(key_queue[16]),
    .e(key_queue[17]),
    .o(\key_count_reg[3]_syn_19 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(A*~(B)*~(C)*~(D)+A*~(B)*C*~(D)+~(A)*B*C*~(D)+A*~(B)*~(C)*D+A*B*~(C)*D+A*~(B)*C*D+~(A)*B*C*D+A*B*C*D)"),
    .INIT(16'hea62))
    \key_count_reg[3]_syn_20  (
    .a(key_head[0]),
    .b(key_head[1]),
    .c(key_queue[22]),
    .d(key_queue[23]),
    .o(\key_count_reg[3]_syn_21 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT5 #(
    .EQN("(~C*(A*B*~(D)*~(E)+~(A)*~(B)*D*~(E)+A*B*D*~(E)+A*~(B)*~(D)*E+A*B*~(D)*E+~(A)*~(B)*D*E+A*~(B)*D*E+A*B*D*E))"),
    .INIT(32'h0b0a0908))
    \key_count_reg[3]_syn_22  (
    .a(\key_count_reg[3]_syn_21 ),
    .b(key_head[1]),
    .c(key_head[3]),
    .d(key_queue[20]),
    .e(key_queue[21]),
    .o(\key_count_reg[3]_syn_23 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT3 #(
    .EQN("(~C*~(B)*~(A)+~C*B*~(A)+~(~C)*B*A+~C*B*A)"),
    .INIT(8'h8d))
    \key_count_reg[3]_syn_24  (
    .a(\key_count_reg[3]_syn_15 ),
    .b(\key_count_reg[3]_syn_19 ),
    .c(\key_count_reg[3]_syn_23 ),
    .o(\key_count_reg[3]_syn_25 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(~(A)*~(B)*C*~(D)+A*~(B)*C*~(D)+~(A)*B*C*~(D)+A*B*C*~(D)+~(A)*B*~(C)*D+A*B*~(C)*D+A*~(B)*C*D+A*B*C*D)"),
    .INIT(16'hacf0))
    \key_count_reg[3]_syn_26  (
    .a(key_queue[3]),
    .b(key_queue[2]),
    .c(key_head[0]),
    .d(key_head[1]),
    .o(\key_count_reg[3]_syn_27 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)+~(A)*B*~(C)*~(D)+~(A)*~(B)*C*~(D)+A*~(B)*C*~(D)+~(A)*~(B)*~(C)*D+A*~(B)*~(C)*D+~(A)*B*~(C)*D+A*B*~(C)*D)"),
    .INIT(16'h0f35))
    \key_count_reg[3]_syn_28  (
    .a(key_queue[0]),
    .b(key_queue[1]),
    .c(\key_count_reg[3]_syn_27 ),
    .d(key_head[1]),
    .o(\key_count_reg[3]_syn_29 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT3 #(
    .EQN("~(C@(B*A))"),
    .INIT(8'h87))
    \key_count_reg[3]_syn_3  (
    .a(preview_step[0]),
    .b(preview_step[1]),
    .c(preview_step[2]),
    .o(\key_count_reg[3]_syn_4 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(~(A)*~(B)*C*~(D)+A*~(B)*C*~(D)+~(A)*B*C*~(D)+A*B*C*~(D)+~(A)*B*~(C)*D+A*B*~(C)*D+A*~(B)*C*D+A*B*C*D)"),
    .INIT(16'hacf0))
    \key_count_reg[3]_syn_30  (
    .a(key_queue[11]),
    .b(key_queue[10]),
    .c(key_head[0]),
    .d(key_head[1]),
    .o(\key_count_reg[3]_syn_31 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)+~(A)*B*~(C)*~(D)+~(A)*~(B)*C*~(D)+A*~(B)*C*~(D)+~(A)*~(B)*~(C)*D+A*~(B)*~(C)*D+~(A)*B*~(C)*D+A*B*~(C)*D)"),
    .INIT(16'h0f35))
    \key_count_reg[3]_syn_32  (
    .a(key_queue[8]),
    .b(key_queue[9]),
    .c(\key_count_reg[3]_syn_31 ),
    .d(key_head[1]),
    .o(\key_count_reg[3]_syn_33 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(~(A)*~(B)*C*~(D)+A*~(B)*C*~(D)+~(A)*B*C*~(D)+A*B*C*~(D)+~(A)*B*~(C)*D+A*B*~(C)*D+A*~(B)*C*D+A*B*C*D)"),
    .INIT(16'hacf0))
    \key_count_reg[3]_syn_34  (
    .a(key_queue[7]),
    .b(key_queue[6]),
    .c(key_head[0]),
    .d(key_head[1]),
    .o(\key_count_reg[3]_syn_35 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(A*~(B)*~(C)*~(D)+A*B*~(C)*~(D)+~(A)*B*C*~(D)+A*B*C*~(D)+~(A)*~(B)*C*D+A*~(B)*C*D+~(A)*B*C*D+A*B*C*D)"),
    .INIT(16'hf0ca))
    \key_count_reg[3]_syn_36  (
    .a(key_queue[4]),
    .b(key_queue[5]),
    .c(\key_count_reg[3]_syn_35 ),
    .d(key_head[1]),
    .o(mux0_syn_39));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(~(A)*~(B)*C*~(D)+A*~(B)*C*~(D)+~(A)*B*C*~(D)+A*B*C*~(D)+~(A)*B*~(C)*D+A*B*~(C)*D+A*~(B)*C*D+A*B*C*D)"),
    .INIT(16'hacf0))
    \key_count_reg[3]_syn_37  (
    .a(key_queue[15]),
    .b(key_queue[14]),
    .c(key_head[0]),
    .d(key_head[1]),
    .o(\key_count_reg[3]_syn_38 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(A*~(B)*~(C)*~(D)+A*B*~(C)*~(D)+~(A)*B*C*~(D)+A*B*C*~(D)+~(A)*~(B)*C*D+A*~(B)*C*D+~(A)*B*C*D+A*B*C*D)"),
    .INIT(16'hf0ca))
    \key_count_reg[3]_syn_39  (
    .a(key_queue[12]),
    .b(key_queue[13]),
    .c(\key_count_reg[3]_syn_38 ),
    .d(key_head[1]),
    .o(mux0_syn_41));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(~(A)*~(B)*C*~(D)+A*~(B)*C*~(D)+~(A)*B*C*~(D)+A*B*C*~(D)+A*~(B)*~(C)*D+A*B*~(C)*D+~(A)*B*C*D+A*B*C*D)"),
    .INIT(16'hcaf0))
    \key_count_reg[3]_syn_40  (
    .a(mux0_syn_39),
    .b(mux0_syn_41),
    .c(key_head[3]),
    .d(key_head[2]),
    .o(\key_count_reg[3]_syn_41 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)+~(A)*B*~(C)*~(D)+~(A)*~(B)*C*~(D)+A*~(B)*C*~(D)+~(A)*~(B)*C*D+A*~(B)*C*D+~(A)*B*C*D+A*B*C*D)"),
    .INIT(16'hf035))
    \key_count_reg[3]_syn_42  (
    .a(\key_count_reg[3]_syn_29 ),
    .b(\key_count_reg[3]_syn_33 ),
    .c(\key_count_reg[3]_syn_41 ),
    .d(key_head[2]),
    .o(mux0_syn_32));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    \key_count_reg[3]_syn_43  (
    .a(key_count[0]),
    .b(key_count[1]),
    .o(\key_count_reg[3]_syn_44 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*A)"),
    .INIT(8'h02))
    \key_count_reg[3]_syn_45  (
    .a(\key_count_reg[3]_syn_44 ),
    .b(key_count[2]),
    .c(key_count[3]),
    .o(\key_count_reg[3]_syn_46 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*A)"),
    .INIT(8'h02))
    \key_count_reg[3]_syn_47  (
    .a(\key_count_reg[3]_syn_46 ),
    .b(key_count[4]),
    .c(key_count[5]),
    .o(auto_pending_n10));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(~C*~(~B*~(A)*~(D)+~B*A*~(D)+~(~B)*A*D+~B*A*D))"),
    .INIT(16'h050c))
    \key_count_reg[3]_syn_48  (
    .a(\key_count_reg[3]_syn_25 ),
    .b(mux0_syn_32),
    .c(auto_pending_n10),
    .d(key_head[4]),
    .o(backwards));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(A*B*C*~(D)+A*~(B)*~(C)*D+~(A)*B*~(C)*D+A*B*~(C)*D+~(A)*~(B)*C*D+A*~(B)*C*D+~(A)*B*C*D)"),
    .INIT(16'h7e80))
    \key_count_reg[3]_syn_49  (
    .a(\disp_img[0]_dup_5 ),
    .b(\disp_img[1]_dup_3 ),
    .c(\disp_img[2]_dup_3 ),
    .d(\disp_img[3]_dup_3 ),
    .o(target_b2[3]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT3 #(
    .EQN("(A*~(~C*~B))"),
    .INIT(8'ha8))
    \key_count_reg[3]_syn_5  (
    .a(preview_done_dup_3),
    .b(next_pressed_dup_1),
    .c(prev_pressed_dup_1),
    .o(auto_pending_n3));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(~(A)*(~C*~B)*~(D)+A*(~C*~B)*~(D)+~(A)*~((~C*~B))*D+A*~((~C*~B))*D+A*(~C*~B)*D)"),
    .INIT(16'hfe03))
    \key_count_reg[3]_syn_50  (
    .a(\disp_img[0]_dup_5 ),
    .b(\disp_img[1]_dup_3 ),
    .c(\disp_img[2]_dup_3 ),
    .d(\disp_img[3]_dup_3 ),
    .o(target_b3[3]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(D*~(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A))"),
    .INIT(16'h1b00))
    \key_count_reg[3]_syn_51  (
    .a(backwards),
    .b(target_b2[3]),
    .c(target_b3[3]),
    .d(preview_done_dup_3),
    .o(\key_count_reg[3]_syn_52 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT5 #(
    .EQN("(~A*(~(B)*~(C)*~(D)*~(E)+B*~(C)*~(D)*~(E)+~(B)*C*~(D)*~(E)+B*C*~(D)*~(E)+~(B)*~(C)*D*~(E)+B*~(C)*D*~(E)+~(B)*C*D*~(E)+~(B)*~(C)*~(D)*E+B*C*D*E))"),
    .INIT(32'h40011555))
    \key_count_reg[3]_syn_53  (
    .a(preview_done_dup_3),
    .b(preview_step[0]),
    .c(preview_step[1]),
    .d(preview_step[2]),
    .e(preview_step[3]),
    .o(\key_count_reg[3]_syn_54 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    \key_count_reg[3]_syn_55  (
    .a(\key_count_reg[3]_syn_52 ),
    .b(\key_count_reg[3]_syn_54 ),
    .o(\key_count_reg[3]_syn_56 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT3 #(
    .EQN("~(C@(B*A))"),
    .INIT(8'h87))
    \key_count_reg[3]_syn_57  (
    .a(\disp_img[0]_dup_5 ),
    .b(\disp_img[1]_dup_3 ),
    .c(\disp_img[2]_dup_3 ),
    .o(\key_count_reg[3]_syn_58 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT2 #(
    .EQN("~(B@A)"),
    .INIT(4'h9))
    \key_count_reg[3]_syn_59  (
    .a(\disp_img[0]_dup_5 ),
    .b(\disp_img[1]_dup_3 ),
    .o(\key_count_reg[3]_syn_60 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(~(A)*~(B)*C*~(D)+A*~(B)*C*~(D)+~(A)*B*C*~(D)+A*B*C*~(D)+~(A)*B*~(C)*D+A*B*~(C)*D+A*~(B)*C*D+A*B*C*D)"),
    .INIT(16'hacf0))
    \key_count_reg[3]_syn_6  (
    .a(key_queue[31]),
    .b(key_queue[30]),
    .c(key_head[0]),
    .d(key_head[1]),
    .o(\key_count_reg[3]_syn_7 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT5 #(
    .EQN("(B*~((C@(E*A)))*~(D)+B*(C@(E*A))*~(D)+~(B)*(C@(E*A))*D+B*(C@(E*A))*D)"),
    .INIT(32'h5accf0cc))
    \key_count_reg[3]_syn_61  (
    .a(backwards),
    .b(\key_count_reg[3]_syn_4 ),
    .c(\key_count_reg[3]_syn_58 ),
    .d(preview_done_dup_3),
    .e(\key_count_reg[3]_syn_60 ),
    .o(\key_count_reg[3]_syn_62 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT2 #(
    .EQN("~(B@A)"),
    .INIT(4'h9))
    \key_count_reg[3]_syn_63  (
    .a(preview_step[0]),
    .b(preview_step[1]),
    .o(\key_count_reg[3]_syn_64 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("~(B*~((D@A))*~(C)+B*(D@A)*~(C)+~(B)*(D@A)*C+B*(D@A)*C)"),
    .INIT(16'ha353))
    \key_count_reg[3]_syn_65  (
    .a(\key_count_reg[3]_syn_60 ),
    .b(\key_count_reg[3]_syn_64 ),
    .c(preview_done_dup_3),
    .d(backwards),
    .o(\key_count_reg[3]_syn_66 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    \key_count_reg[3]_syn_67  (
    .a(preview_done_dup_3),
    .b(\disp_img[0]_dup_5 ),
    .c(preview_step[0]),
    .o(\key_count_reg[3]_syn_68 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT3 #(
    .EQN("(~A*~(C@B))"),
    .INIT(8'h41))
    \key_count_reg[3]_syn_69  (
    .a(commit_pending),
    .b(switch_req_dup_3),
    .c(switch_ack_dup_1),
    .o(launch_switch_n3));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(B*~(D*~C*A))"),
    .INIT(16'hc4cc))
    \key_count_reg[3]_syn_70  (
    .a(auto_pending_n10),
    .b(launch_switch_n3),
    .c(auto_pending),
    .d(preview_done_dup_3),
    .o(\key_count_reg[3]_syn_71 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*A)"),
    .INIT(8'h02))
    \key_count_reg[3]_syn_72  (
    .a(\key_count_reg[3]_syn_62 ),
    .b(\key_count_reg[3]_syn_66 ),
    .c(\key_count_reg[3]_syn_68 ),
    .o(\key_count_reg[3]_syn_73 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(B*~(D@(~C*~A)))"),
    .INIT(16'h04c8))
    \key_count_reg[3]_syn_74  (
    .a(\key_count_reg[3]_syn_52 ),
    .b(\key_count_reg[3]_syn_71 ),
    .c(\key_count_reg[3]_syn_54 ),
    .d(\key_count_reg[3]_syn_73 ),
    .o(\key_count_reg[3]_syn_75 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT3 #(
    .EQN("~(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'h1b))
    \key_count_reg[3]_syn_76  (
    .a(\key_count_reg[3]_syn_68 ),
    .b(valid[5]),
    .c(valid[6]),
    .o(\key_count_reg[3]_syn_77 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT3 #(
    .EQN("~(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'h1b))
    \key_count_reg[3]_syn_78  (
    .a(\key_count_reg[3]_syn_68 ),
    .b(valid[3]),
    .c(valid[4]),
    .o(\key_count_reg[3]_syn_79 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)+~(A)*B*~(C)*~(D)+~(A)*~(B)*C*~(D)+A*~(B)*C*~(D)+~(A)*~(B)*~(C)*D+A*~(B)*~(C)*D+~(A)*B*~(C)*D+A*B*~(C)*D)"),
    .INIT(16'h0f35))
    \key_count_reg[3]_syn_8  (
    .a(key_queue[28]),
    .b(key_queue[29]),
    .c(\key_count_reg[3]_syn_7 ),
    .d(key_head[1]),
    .o(\key_count_reg[3]_syn_9 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT3 #(
    .EQN("~(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'h27))
    \key_count_reg[3]_syn_80  (
    .a(\key_count_reg[3]_syn_68 ),
    .b(valid[0]),
    .c(valid[7]),
    .o(\key_count_reg[3]_syn_81 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT3 #(
    .EQN("~(B*~(C)*~(A)+B*C*~(A)+~(B)*C*A+B*C*A)"),
    .INIT(8'h1b))
    \key_count_reg[3]_syn_82  (
    .a(\key_count_reg[3]_syn_68 ),
    .b(valid[1]),
    .c(valid[2]),
    .o(\key_count_reg[3]_syn_83 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(A*~(B)*~(C)*~(D)+A*B*~(C)*~(D)+A*~(B)*C*~(D)+A*B*C*~(D)+~(A)*B*~(C)*D+A*~(B)*C*D+~(A)*B*C*D+A*B*C*D)"),
    .INIT(16'he4aa))
    \key_count_reg[3]_syn_84  (
    .a(\key_count_reg[3]_syn_66 ),
    .b(\key_count_reg[3]_syn_81 ),
    .c(\key_count_reg[3]_syn_83 ),
    .d(\key_count_reg[3]_syn_62 ),
    .o(\key_count_reg[3]_syn_85 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(~(A)*B*~(C)*~(D)+A*B*~(C)*~(D)+A*~(B)*C*~(D)+A*B*C*~(D)+~(A)*~(B)*C*D+A*~(B)*C*D+~(A)*B*C*D+A*B*C*D)"),
    .INIT(16'hf0ac))
    \key_count_reg[3]_syn_86  (
    .a(\key_count_reg[3]_syn_77 ),
    .b(\key_count_reg[3]_syn_79 ),
    .c(\key_count_reg[3]_syn_85 ),
    .d(\key_count_reg[3]_syn_62 ),
    .o(\key_count_reg[3]_syn_87 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    \key_count_reg[3]_syn_88  (
    .a(auto_pending_n10),
    .b(preview_done_dup_3),
    .o(\key_count_reg[3]_syn_89 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT5 #(
    .EQN("(D*~(E*~(C)*~((~B*A))+E*C*~((~B*A))+~(E)*C*(~B*A)+E*C*(~B*A)))"),
    .INIT(32'h0200df00))
    \key_count_reg[3]_syn_90  (
    .a(\key_count_reg[3]_syn_75 ),
    .b(\key_count_reg[3]_syn_87 ),
    .c(\key_count_reg[3]_syn_89 ),
    .d(auto_pending_n3),
    .e(key_count[5]),
    .o(key_count_b_n));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    \key_count_reg[3]_syn_91  (
    .a(\key_count_reg[3]_syn_89 ),
    .b(auto_pending_n3),
    .o(\key_count_reg[3]_syn_92 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT5 #(
    .EQN("(E*D*~B*~(C@A))"),
    .INIT(32'h21000000))
    \key_count_reg[3]_syn_93  (
    .a(\key_count_reg[3]_syn_56 ),
    .b(\key_count_reg[3]_syn_87 ),
    .c(\key_count_reg[3]_syn_73 ),
    .d(\key_count_reg[3]_syn_92 ),
    .e(\key_count_reg[3]_syn_71 ),
    .o(key_count_b_n1));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    \key_count_reg[3]_syn_94  (
    .a(\key_count_reg[3]_syn_44 ),
    .b(key_count[2]),
    .o(\key_count_reg[3]_syn_95 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT5 #(
    .EQN("(~(A)*B*C*~(D)*~(E)+A*B*C*~(D)*~(E)+A*~(B)*~(C)*D*~(E)+A*B*~(C)*D*~(E)+A*~(B)*C*D*~(E)+~(A)*B*C*D*~(E)+A*B*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+~(A)*B*~(C)*~(D)*E+A*B*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+~(A)*~(B)*~(C)*D*E+A*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+A*B*C*D*E)"),
    .INIT(32'hbf1deac0))
    \key_count_reg[3]_syn_96  (
    .a(key_count_b_n),
    .b(key_count_b_n1),
    .c(\key_count_reg[3]_syn_95 ),
    .d(key_count_b1[3]),
    .e(key_count[3]),
    .o(\key_count_reg[3]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \key_count_reg[4]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\key_count_reg[4]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(key_count[4]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT5 #(
    .EQN("(~(A)*B*C*~(D)*~(E)+A*B*C*~(D)*~(E)+A*~(B)*~(C)*D*~(E)+A*B*~(C)*D*~(E)+A*~(B)*C*D*~(E)+~(A)*B*C*D*~(E)+A*B*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+~(A)*B*~(C)*~(D)*E+A*B*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+~(A)*~(B)*~(C)*D*E+A*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+A*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+A*B*C*D*E)"),
    .INIT(32'hbf1deac0))
    \key_count_reg[4]_syn_3  (
    .a(key_count_b_n),
    .b(key_count_b_n1),
    .c(\key_count_reg[3]_syn_46 ),
    .d(key_count_b1[4]),
    .e(key_count[4]),
    .o(\key_count_reg[4]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \key_count_reg[5]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\key_count_reg[5]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(key_count[5]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT5 #(
    .EQN("(~(A)*~(B)*C*D*~(E)+A*~(B)*C*D*~(E)+~(A)*B*C*D*~(E)+~(A)*~(B)*~(C)*~(D)*E+A*~(B)*~(C)*~(D)*E+~(A)*B*~(C)*~(D)*E+~(A)*~(B)*C*~(D)*E+~(A)*B*C*~(D)*E+A*B*C*~(D)*E+~(A)*~(B)*~(C)*D*E+A*~(B)*~(C)*D*E+~(A)*B*~(C)*D*E+~(A)*~(B)*C*D*E+A*~(B)*C*D*E+~(A)*B*C*D*E+A*B*C*D*E)"),
    .INIT(32'hf7d77000))
    \key_count_reg[5]_syn_3  (
    .a(launch_switch),
    .b(\key_count_reg[3]_syn_89 ),
    .c(auto_pending_n3),
    .d(key_count_b1[5]),
    .e(key_count[5]),
    .o(\key_count_reg[5]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \key_head_reg[0]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\key_head_reg[0]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(key_head[0]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT2 #(
    .EQN("(B@A)"),
    .INIT(4'h6))
    \key_head_reg[0]_syn_3  (
    .a(\key_head_reg[4]_syn_4 ),
    .b(key_head[0]),
    .o(\key_head_reg[0]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \key_head_reg[1]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\key_head_reg[1]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(key_head[1]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT3 #(
    .EQN("(C@(B*A))"),
    .INIT(8'h78))
    \key_head_reg[1]_syn_3  (
    .a(\key_head_reg[4]_syn_4 ),
    .b(key_head[0]),
    .c(key_head[1]),
    .o(\key_head_reg[1]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \key_head_reg[2]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\key_head_reg[2]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(key_head[2]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(D@(C*B*A))"),
    .INIT(16'h7f80))
    \key_head_reg[2]_syn_3  (
    .a(\key_head_reg[4]_syn_4 ),
    .b(key_head[0]),
    .c(key_head[1]),
    .d(key_head[2]),
    .o(\key_head_reg[2]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \key_head_reg[3]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\key_head_reg[3]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(key_head[3]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT5 #(
    .EQN("(E@(D*C*B*A))"),
    .INIT(32'h7fff8000))
    \key_head_reg[3]_syn_3  (
    .a(\key_head_reg[4]_syn_4 ),
    .b(key_head[0]),
    .c(key_head[1]),
    .d(key_head[2]),
    .e(key_head[3]),
    .o(\key_head_reg[3]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \key_head_reg[4]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\key_head_reg[4]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(key_head[4]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT3 #(
    .EQN("(C*~B*A)"),
    .INIT(8'h20))
    \key_head_reg[4]_syn_3  (
    .a(\key_count_reg[3]_syn_75 ),
    .b(\key_count_reg[3]_syn_87 ),
    .c(\key_count_reg[3]_syn_89 ),
    .o(\key_head_reg[4]_syn_4 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    \key_head_reg[4]_syn_5  (
    .a(key_head[0]),
    .b(key_head[1]),
    .c(key_head[2]),
    .d(key_head[3]),
    .o(add2_syn_26));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT3 #(
    .EQN("(C@(B*A))"),
    .INIT(8'h78))
    \key_head_reg[4]_syn_6  (
    .a(\key_head_reg[4]_syn_4 ),
    .b(add2_syn_26),
    .c(key_head[4]),
    .o(\key_head_reg[4]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \key_queue_reg[0]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\key_queue_reg[0]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(key_queue[0]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((B*A))+D*C*~((B*A))+~(D)*C*(B*A)+D*C*(B*A))"),
    .INIT(16'hf780))
    \key_queue_reg[0]_syn_3  (
    .a(\key_queue_reg[7]_syn_6 ),
    .b(\key_queue_reg[24]_syn_4 ),
    .c(key_queue_b_n32),
    .d(key_queue[0]),
    .o(\key_queue_reg[0]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \key_queue_reg[10]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\key_queue_reg[10]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(key_queue[10]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((B*A))+D*C*~((B*A))+~(D)*C*(B*A)+D*C*(B*A))"),
    .INIT(16'hf780))
    \key_queue_reg[10]_syn_3  (
    .a(\key_queue_reg[15]_syn_6 ),
    .b(\key_queue_reg[26]_syn_4 ),
    .c(key_queue_b_n32),
    .d(key_queue[10]),
    .o(\key_queue_reg[10]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \key_queue_reg[11]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\key_queue_reg[11]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(key_queue[11]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((B*A))+D*C*~((B*A))+~(D)*C*(B*A)+D*C*(B*A))"),
    .INIT(16'hf780))
    \key_queue_reg[11]_syn_3  (
    .a(\key_queue_reg[15]_syn_6 ),
    .b(\key_queue_reg[27]_syn_4 ),
    .c(key_queue_b_n32),
    .d(key_queue[11]),
    .o(\key_queue_reg[11]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \key_queue_reg[12]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\key_queue_reg[12]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(key_queue[12]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((B*A))+D*C*~((B*A))+~(D)*C*(B*A)+D*C*(B*A))"),
    .INIT(16'hf780))
    \key_queue_reg[12]_syn_3  (
    .a(\key_queue_reg[15]_syn_6 ),
    .b(\key_queue_reg[28]_syn_4 ),
    .c(key_queue_b_n32),
    .d(key_queue[12]),
    .o(\key_queue_reg[12]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \key_queue_reg[13]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\key_queue_reg[13]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(key_queue[13]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((B*A))+D*C*~((B*A))+~(D)*C*(B*A)+D*C*(B*A))"),
    .INIT(16'hf780))
    \key_queue_reg[13]_syn_3  (
    .a(\key_queue_reg[15]_syn_6 ),
    .b(\key_queue_reg[29]_syn_4 ),
    .c(key_queue_b_n32),
    .d(key_queue[13]),
    .o(\key_queue_reg[13]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \key_queue_reg[14]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\key_queue_reg[14]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(key_queue[14]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((B*A))+D*C*~((B*A))+~(D)*C*(B*A)+D*C*(B*A))"),
    .INIT(16'hf780))
    \key_queue_reg[14]_syn_3  (
    .a(\key_queue_reg[15]_syn_6 ),
    .b(\key_queue_reg[30]_syn_4 ),
    .c(key_queue_b_n32),
    .d(key_queue[14]),
    .o(\key_queue_reg[14]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \key_queue_reg[15]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\key_queue_reg[15]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(key_queue[15]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT3 #(
    .EQN("(~C*B*A)"),
    .INIT(8'h08))
    \key_queue_reg[15]_syn_3  (
    .a(auto_pending_n3),
    .b(key_tail[3]),
    .c(key_tail[4]),
    .o(\key_queue_reg[15]_syn_4 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(C*~(D*~(~B*A)))"),
    .INIT(16'h20f0))
    \key_queue_reg[15]_syn_5  (
    .a(\key_count_reg[3]_syn_75 ),
    .b(\key_count_reg[3]_syn_87 ),
    .c(\key_queue_reg[15]_syn_4 ),
    .d(key_count[5]),
    .o(\key_queue_reg[15]_syn_6 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((B*A))+D*C*~((B*A))+~(D)*C*(B*A)+D*C*(B*A))"),
    .INIT(16'hf780))
    \key_queue_reg[15]_syn_7  (
    .a(\key_queue_reg[15]_syn_6 ),
    .b(add1_syn_22),
    .c(key_queue_b_n32),
    .d(key_queue[15]),
    .o(\key_queue_reg[15]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \key_queue_reg[16]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\key_queue_reg[16]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(key_queue[16]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((B*A))+D*C*~((B*A))+~(D)*C*(B*A)+D*C*(B*A))"),
    .INIT(16'hf780))
    \key_queue_reg[16]_syn_3  (
    .a(\key_queue_reg[23]_syn_6 ),
    .b(\key_queue_reg[24]_syn_4 ),
    .c(key_queue_b_n32),
    .d(key_queue[16]),
    .o(\key_queue_reg[16]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \key_queue_reg[17]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\key_queue_reg[17]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(key_queue[17]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((B*A))+D*C*~((B*A))+~(D)*C*(B*A)+D*C*(B*A))"),
    .INIT(16'hf780))
    \key_queue_reg[17]_syn_3  (
    .a(\key_queue_reg[23]_syn_6 ),
    .b(\key_queue_reg[25]_syn_4 ),
    .c(key_queue_b_n32),
    .d(key_queue[17]),
    .o(\key_queue_reg[17]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \key_queue_reg[18]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\key_queue_reg[18]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(key_queue[18]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((B*A))+D*C*~((B*A))+~(D)*C*(B*A)+D*C*(B*A))"),
    .INIT(16'hf780))
    \key_queue_reg[18]_syn_3  (
    .a(\key_queue_reg[23]_syn_6 ),
    .b(\key_queue_reg[26]_syn_4 ),
    .c(key_queue_b_n32),
    .d(key_queue[18]),
    .o(\key_queue_reg[18]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \key_queue_reg[19]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\key_queue_reg[19]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(key_queue[19]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((B*A))+D*C*~((B*A))+~(D)*C*(B*A)+D*C*(B*A))"),
    .INIT(16'hf780))
    \key_queue_reg[19]_syn_3  (
    .a(\key_queue_reg[23]_syn_6 ),
    .b(\key_queue_reg[27]_syn_4 ),
    .c(key_queue_b_n32),
    .d(key_queue[19]),
    .o(\key_queue_reg[19]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \key_queue_reg[1]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\key_queue_reg[1]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(key_queue[1]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((B*A))+D*C*~((B*A))+~(D)*C*(B*A)+D*C*(B*A))"),
    .INIT(16'hf780))
    \key_queue_reg[1]_syn_3  (
    .a(\key_queue_reg[7]_syn_6 ),
    .b(\key_queue_reg[25]_syn_4 ),
    .c(key_queue_b_n32),
    .d(key_queue[1]),
    .o(\key_queue_reg[1]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \key_queue_reg[20]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\key_queue_reg[20]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(key_queue[20]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((B*A))+D*C*~((B*A))+~(D)*C*(B*A)+D*C*(B*A))"),
    .INIT(16'hf780))
    \key_queue_reg[20]_syn_3  (
    .a(\key_queue_reg[23]_syn_6 ),
    .b(\key_queue_reg[28]_syn_4 ),
    .c(key_queue_b_n32),
    .d(key_queue[20]),
    .o(\key_queue_reg[20]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \key_queue_reg[21]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\key_queue_reg[21]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(key_queue[21]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((B*A))+D*C*~((B*A))+~(D)*C*(B*A)+D*C*(B*A))"),
    .INIT(16'hf780))
    \key_queue_reg[21]_syn_3  (
    .a(\key_queue_reg[23]_syn_6 ),
    .b(\key_queue_reg[29]_syn_4 ),
    .c(key_queue_b_n32),
    .d(key_queue[21]),
    .o(\key_queue_reg[21]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \key_queue_reg[22]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\key_queue_reg[22]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(key_queue[22]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((B*A))+D*C*~((B*A))+~(D)*C*(B*A)+D*C*(B*A))"),
    .INIT(16'hf780))
    \key_queue_reg[22]_syn_3  (
    .a(\key_queue_reg[23]_syn_6 ),
    .b(\key_queue_reg[30]_syn_4 ),
    .c(key_queue_b_n32),
    .d(key_queue[22]),
    .o(\key_queue_reg[22]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \key_queue_reg[23]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\key_queue_reg[23]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(key_queue[23]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT3 #(
    .EQN("(C*~B*A)"),
    .INIT(8'h20))
    \key_queue_reg[23]_syn_3  (
    .a(auto_pending_n3),
    .b(key_tail[3]),
    .c(key_tail[4]),
    .o(\key_queue_reg[23]_syn_4 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(C*~(D*~(~B*A)))"),
    .INIT(16'h20f0))
    \key_queue_reg[23]_syn_5  (
    .a(\key_count_reg[3]_syn_75 ),
    .b(\key_count_reg[3]_syn_87 ),
    .c(\key_queue_reg[23]_syn_4 ),
    .d(key_count[5]),
    .o(\key_queue_reg[23]_syn_6 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((B*A))+D*C*~((B*A))+~(D)*C*(B*A)+D*C*(B*A))"),
    .INIT(16'hf780))
    \key_queue_reg[23]_syn_7  (
    .a(\key_queue_reg[23]_syn_6 ),
    .b(add1_syn_22),
    .c(key_queue_b_n32),
    .d(key_queue[23]),
    .o(\key_queue_reg[23]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \key_queue_reg[24]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\key_queue_reg[24]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(key_queue[24]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*~A)"),
    .INIT(8'h01))
    \key_queue_reg[24]_syn_3  (
    .a(key_tail[0]),
    .b(key_tail[1]),
    .c(key_tail[2]),
    .o(\key_queue_reg[24]_syn_4 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((B*A))+D*C*~((B*A))+~(D)*C*(B*A)+D*C*(B*A))"),
    .INIT(16'hf780))
    \key_queue_reg[24]_syn_5  (
    .a(\key_queue_reg[31]_syn_8 ),
    .b(\key_queue_reg[24]_syn_4 ),
    .c(key_queue_b_n32),
    .d(key_queue[24]),
    .o(\key_queue_reg[24]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \key_queue_reg[25]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\key_queue_reg[25]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(key_queue[25]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*A)"),
    .INIT(8'h02))
    \key_queue_reg[25]_syn_3  (
    .a(key_tail[0]),
    .b(key_tail[1]),
    .c(key_tail[2]),
    .o(\key_queue_reg[25]_syn_4 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((B*A))+D*C*~((B*A))+~(D)*C*(B*A)+D*C*(B*A))"),
    .INIT(16'hf780))
    \key_queue_reg[25]_syn_5  (
    .a(\key_queue_reg[31]_syn_8 ),
    .b(\key_queue_reg[25]_syn_4 ),
    .c(key_queue_b_n32),
    .d(key_queue[25]),
    .o(\key_queue_reg[25]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \key_queue_reg[26]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\key_queue_reg[26]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(key_queue[26]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT3 #(
    .EQN("(~C*B*~A)"),
    .INIT(8'h04))
    \key_queue_reg[26]_syn_3  (
    .a(key_tail[0]),
    .b(key_tail[1]),
    .c(key_tail[2]),
    .o(\key_queue_reg[26]_syn_4 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((B*A))+D*C*~((B*A))+~(D)*C*(B*A)+D*C*(B*A))"),
    .INIT(16'hf780))
    \key_queue_reg[26]_syn_5  (
    .a(\key_queue_reg[31]_syn_8 ),
    .b(\key_queue_reg[26]_syn_4 ),
    .c(key_queue_b_n32),
    .d(key_queue[26]),
    .o(\key_queue_reg[26]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \key_queue_reg[27]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\key_queue_reg[27]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(key_queue[27]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT3 #(
    .EQN("(~C*B*A)"),
    .INIT(8'h08))
    \key_queue_reg[27]_syn_3  (
    .a(key_tail[0]),
    .b(key_tail[1]),
    .c(key_tail[2]),
    .o(\key_queue_reg[27]_syn_4 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((B*A))+D*C*~((B*A))+~(D)*C*(B*A)+D*C*(B*A))"),
    .INIT(16'hf780))
    \key_queue_reg[27]_syn_5  (
    .a(\key_queue_reg[31]_syn_8 ),
    .b(\key_queue_reg[27]_syn_4 ),
    .c(key_queue_b_n32),
    .d(key_queue[27]),
    .o(\key_queue_reg[27]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \key_queue_reg[28]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\key_queue_reg[28]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(key_queue[28]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT3 #(
    .EQN("(C*~B*~A)"),
    .INIT(8'h10))
    \key_queue_reg[28]_syn_3  (
    .a(key_tail[0]),
    .b(key_tail[1]),
    .c(key_tail[2]),
    .o(\key_queue_reg[28]_syn_4 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((B*A))+D*C*~((B*A))+~(D)*C*(B*A)+D*C*(B*A))"),
    .INIT(16'hf780))
    \key_queue_reg[28]_syn_5  (
    .a(\key_queue_reg[31]_syn_8 ),
    .b(\key_queue_reg[28]_syn_4 ),
    .c(key_queue_b_n32),
    .d(key_queue[28]),
    .o(\key_queue_reg[28]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \key_queue_reg[29]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\key_queue_reg[29]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(key_queue[29]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT3 #(
    .EQN("(C*~B*A)"),
    .INIT(8'h20))
    \key_queue_reg[29]_syn_3  (
    .a(key_tail[0]),
    .b(key_tail[1]),
    .c(key_tail[2]),
    .o(\key_queue_reg[29]_syn_4 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((B*A))+D*C*~((B*A))+~(D)*C*(B*A)+D*C*(B*A))"),
    .INIT(16'hf780))
    \key_queue_reg[29]_syn_5  (
    .a(\key_queue_reg[31]_syn_8 ),
    .b(\key_queue_reg[29]_syn_4 ),
    .c(key_queue_b_n32),
    .d(key_queue[29]),
    .o(\key_queue_reg[29]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \key_queue_reg[2]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\key_queue_reg[2]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(key_queue[2]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((B*A))+D*C*~((B*A))+~(D)*C*(B*A)+D*C*(B*A))"),
    .INIT(16'hf780))
    \key_queue_reg[2]_syn_3  (
    .a(\key_queue_reg[7]_syn_6 ),
    .b(\key_queue_reg[26]_syn_4 ),
    .c(key_queue_b_n32),
    .d(key_queue[2]),
    .o(\key_queue_reg[2]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \key_queue_reg[30]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\key_queue_reg[30]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(key_queue[30]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT3 #(
    .EQN("(C*B*~A)"),
    .INIT(8'h40))
    \key_queue_reg[30]_syn_3  (
    .a(key_tail[0]),
    .b(key_tail[1]),
    .c(key_tail[2]),
    .o(\key_queue_reg[30]_syn_4 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((B*A))+D*C*~((B*A))+~(D)*C*(B*A)+D*C*(B*A))"),
    .INIT(16'hf780))
    \key_queue_reg[30]_syn_5  (
    .a(\key_queue_reg[31]_syn_8 ),
    .b(\key_queue_reg[30]_syn_4 ),
    .c(key_queue_b_n32),
    .d(key_queue[30]),
    .o(\key_queue_reg[30]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \key_queue_reg[31]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\key_queue_reg[31]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(key_queue[31]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    \key_queue_reg[31]_syn_3  (
    .a(key_tail[0]),
    .b(key_tail[1]),
    .c(key_tail[2]),
    .o(add1_syn_22));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    \key_queue_reg[31]_syn_4  (
    .a(next_pressed_dup_1),
    .b(prev_pressed_dup_1),
    .o(key_queue_b_n32));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    \key_queue_reg[31]_syn_5  (
    .a(auto_pending_n3),
    .b(key_tail[3]),
    .c(key_tail[4]),
    .o(\key_queue_reg[31]_syn_6 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(C*~(D*~(~B*A)))"),
    .INIT(16'h20f0))
    \key_queue_reg[31]_syn_7  (
    .a(\key_count_reg[3]_syn_75 ),
    .b(\key_count_reg[3]_syn_87 ),
    .c(\key_queue_reg[31]_syn_6 ),
    .d(key_count[5]),
    .o(\key_queue_reg[31]_syn_8 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((B*A))+D*C*~((B*A))+~(D)*C*(B*A)+D*C*(B*A))"),
    .INIT(16'hf780))
    \key_queue_reg[31]_syn_9  (
    .a(\key_queue_reg[31]_syn_8 ),
    .b(add1_syn_22),
    .c(key_queue_b_n32),
    .d(key_queue[31]),
    .o(\key_queue_reg[31]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \key_queue_reg[3]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\key_queue_reg[3]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(key_queue[3]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((B*A))+D*C*~((B*A))+~(D)*C*(B*A)+D*C*(B*A))"),
    .INIT(16'hf780))
    \key_queue_reg[3]_syn_3  (
    .a(\key_queue_reg[7]_syn_6 ),
    .b(\key_queue_reg[27]_syn_4 ),
    .c(key_queue_b_n32),
    .d(key_queue[3]),
    .o(\key_queue_reg[3]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \key_queue_reg[4]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\key_queue_reg[4]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(key_queue[4]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((B*A))+D*C*~((B*A))+~(D)*C*(B*A)+D*C*(B*A))"),
    .INIT(16'hf780))
    \key_queue_reg[4]_syn_3  (
    .a(\key_queue_reg[7]_syn_6 ),
    .b(\key_queue_reg[28]_syn_4 ),
    .c(key_queue_b_n32),
    .d(key_queue[4]),
    .o(\key_queue_reg[4]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \key_queue_reg[5]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\key_queue_reg[5]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(key_queue[5]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((B*A))+D*C*~((B*A))+~(D)*C*(B*A)+D*C*(B*A))"),
    .INIT(16'hf780))
    \key_queue_reg[5]_syn_3  (
    .a(\key_queue_reg[7]_syn_6 ),
    .b(\key_queue_reg[29]_syn_4 ),
    .c(key_queue_b_n32),
    .d(key_queue[5]),
    .o(\key_queue_reg[5]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \key_queue_reg[6]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\key_queue_reg[6]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(key_queue[6]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((B*A))+D*C*~((B*A))+~(D)*C*(B*A)+D*C*(B*A))"),
    .INIT(16'hf780))
    \key_queue_reg[6]_syn_3  (
    .a(\key_queue_reg[7]_syn_6 ),
    .b(\key_queue_reg[30]_syn_4 ),
    .c(key_queue_b_n32),
    .d(key_queue[6]),
    .o(\key_queue_reg[6]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \key_queue_reg[7]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\key_queue_reg[7]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(key_queue[7]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*A)"),
    .INIT(8'h02))
    \key_queue_reg[7]_syn_3  (
    .a(auto_pending_n3),
    .b(key_tail[3]),
    .c(key_tail[4]),
    .o(\key_queue_reg[7]_syn_4 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(C*~(D*~(~B*A)))"),
    .INIT(16'h20f0))
    \key_queue_reg[7]_syn_5  (
    .a(\key_count_reg[3]_syn_75 ),
    .b(\key_count_reg[3]_syn_87 ),
    .c(\key_queue_reg[7]_syn_4 ),
    .d(key_count[5]),
    .o(\key_queue_reg[7]_syn_6 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((B*A))+D*C*~((B*A))+~(D)*C*(B*A)+D*C*(B*A))"),
    .INIT(16'hf780))
    \key_queue_reg[7]_syn_7  (
    .a(\key_queue_reg[7]_syn_6 ),
    .b(add1_syn_22),
    .c(key_queue_b_n32),
    .d(key_queue[7]),
    .o(\key_queue_reg[7]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \key_queue_reg[8]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\key_queue_reg[8]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(key_queue[8]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((B*A))+D*C*~((B*A))+~(D)*C*(B*A)+D*C*(B*A))"),
    .INIT(16'hf780))
    \key_queue_reg[8]_syn_3  (
    .a(\key_queue_reg[15]_syn_6 ),
    .b(\key_queue_reg[24]_syn_4 ),
    .c(key_queue_b_n32),
    .d(key_queue[8]),
    .o(\key_queue_reg[8]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \key_queue_reg[9]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\key_queue_reg[9]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(key_queue[9]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(D*~(C)*~((B*A))+D*C*~((B*A))+~(D)*C*(B*A)+D*C*(B*A))"),
    .INIT(16'hf780))
    \key_queue_reg[9]_syn_3  (
    .a(\key_queue_reg[15]_syn_6 ),
    .b(\key_queue_reg[25]_syn_4 ),
    .c(key_queue_b_n32),
    .d(key_queue[9]),
    .o(\key_queue_reg[9]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \key_tail_reg[0]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\key_tail_reg[0]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(key_tail[0]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(D@(B*~(C*~A)))"),
    .INIT(16'h738c))
    \key_tail_reg[0]_syn_3  (
    .a(launch_switch),
    .b(auto_pending_n3),
    .c(key_count[5]),
    .d(key_tail[0]),
    .o(\key_tail_reg[0]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \key_tail_reg[1]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\key_tail_reg[1]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(key_tail[1]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT5 #(
    .EQN("(E@(D*B*~(C*~A)))"),
    .INIT(32'h73ff8c00))
    \key_tail_reg[1]_syn_3  (
    .a(launch_switch),
    .b(auto_pending_n3),
    .c(key_count[5]),
    .d(key_tail[0]),
    .e(key_tail[1]),
    .o(\key_tail_reg[1]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \key_tail_reg[2]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\key_tail_reg[2]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(key_tail[2]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    \key_tail_reg[2]_syn_3  (
    .a(auto_pending_n3),
    .b(key_tail[0]),
    .c(key_tail[1]),
    .o(\key_tail_reg[2]_syn_4 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(D@(B*~(C*~A)))"),
    .INIT(16'h738c))
    \key_tail_reg[2]_syn_5  (
    .a(launch_switch),
    .b(\key_tail_reg[2]_syn_4 ),
    .c(key_count[5]),
    .d(key_tail[2]),
    .o(\key_tail_reg[2]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \key_tail_reg[3]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\key_tail_reg[3]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(key_tail[3]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT5 #(
    .EQN("(E@(C*B*~(D*~A)))"),
    .INIT(32'h7f3f80c0))
    \key_tail_reg[3]_syn_3  (
    .a(launch_switch),
    .b(auto_pending_n3),
    .c(add1_syn_22),
    .d(key_count[5]),
    .e(key_tail[3]),
    .o(\key_tail_reg[3]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \key_tail_reg[4]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\key_tail_reg[4]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(key_tail[4]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT3 #(
    .EQN("(C*B*A)"),
    .INIT(8'h80))
    \key_tail_reg[4]_syn_3  (
    .a(auto_pending_n3),
    .b(add1_syn_22),
    .c(key_tail[3]),
    .o(\key_tail_reg[4]_syn_4 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(D@(B*~(C*~A)))"),
    .INIT(16'h738c))
    \key_tail_reg[4]_syn_5  (
    .a(launch_switch),
    .b(\key_tail_reg[4]_syn_4 ),
    .c(key_count[5]),
    .d(key_tail[4]),
    .o(\key_tail_reg[4]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DO_DFFMODE("FF"),
    .DO_REGSET("SET"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .ODDRMODE("OFF"),
    .OUTCEMUX("CE"),
    .OUTRSTMUX("RST"),
    .OUTSCLKMUX("CLK"),
    .SRMODE("ASYNC"),
    .TSMUX("0"))
    \load_img[0]_syn_4  (
    .ce(mux35_syn_63),
    .do({open_n173,open_n174,open_n175,load_img_b[0]}),
    .osclk(clk_dup_1),
    .rst(rst_dup_1),
    .opad(load_img[0]));  // ../../RTL_1/bridge/abc_hdmi_top.v(214)
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
    .SRMODE("ASYNC"),
    .TSMUX("0"))
    \load_img[1]_syn_4  (
    .ce(mux35_syn_63),
    .do({open_n187,open_n188,open_n189,load_img_b[1]}),
    .osclk(clk_dup_1),
    .rst(rst_dup_1),
    .opad(load_img[1]));  // ../../RTL_1/bridge/abc_hdmi_top.v(214)
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
    .SRMODE("ASYNC"),
    .TSMUX("0"))
    \load_img[2]_syn_4  (
    .ce(mux35_syn_63),
    .do({open_n201,open_n202,open_n203,load_img_b[2]}),
    .osclk(clk_dup_1),
    .rst(rst_dup_1),
    .opad(load_img[2]));  // ../../RTL_1/bridge/abc_hdmi_top.v(214)
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
    .SRMODE("ASYNC"),
    .TSMUX("0"))
    \load_img[3]_syn_4  (
    .ce(mux35_syn_63),
    .do({open_n215,open_n216,open_n217,load_img_b[3]}),
    .osclk(clk_dup_1),
    .rst(rst_dup_1),
    .opad(load_img[3]));  // ../../RTL_1/bridge/abc_hdmi_top.v(214)
  AL_DFF_X #(
    .INIT(1'b1))
    \load_img_reg[0]  (
    .ar(1'b0),
    .as(rst_dup_1),
    .clk(clk_dup_1),
    .d(\load_img_reg[0]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\load_img[0]_dup_3 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    \load_img_reg[0]_syn_3  (
    .a(\wanted_b[0]_syn_2 ),
    .b(mux36_syn_20),
    .o(load_img_b[0]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    \load_img_reg[0]_syn_4  (
    .a(mux35_syn_63),
    .b(load_img_b[0]),
    .c(\load_img[0]_dup_3 ),
    .o(\load_img_reg[0]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \load_img_reg[1]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\load_img_reg[1]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\load_img[1]_dup_3 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(~(A)*~(B)*C*~(D)+A*~(B)*C*~(D)+~(A)*B*C*~(D)+A*B*C*~(D)+~(A)*~(B)*~(C)*D+~(A)*B*~(C)*D+~(A)*~(B)*C*D+~(A)*B*C*D+A*B*C*D)"),
    .INIT(16'hd5f0))
    \load_img_reg[1]_syn_3  (
    .a(\wr_base_b[16]_syn_2 ),
    .b(load_img_b1_n_syn_2),
    .c(\load_img[1]_dup_3 ),
    .d(load_state_reg_syn_1[2]),
    .o(\load_img_reg[1]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \load_img_reg[2]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\load_img_reg[2]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\load_img[2]_dup_3 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    \load_img_reg[2]_syn_3  (
    .a(\wanted[2]_syn_2 ),
    .b(mux36_syn_20),
    .o(load_img_b[2]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    \load_img_reg[2]_syn_4  (
    .a(load_img_b1_n_syn_2),
    .b(load_state_reg_syn_1[2]),
    .o(mux35_syn_63));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT3 #(
    .EQN("(C*~(A)*~(B)+C*A*~(B)+~(C)*A*B+C*A*B)"),
    .INIT(8'hb8))
    \load_img_reg[2]_syn_5  (
    .a(load_img_b[2]),
    .b(mux35_syn_63),
    .c(\load_img[2]_dup_3 ),
    .o(\load_img_reg[2]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \load_img_reg[3]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\load_img_reg[3]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\load_img[3]_dup_3 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(~(A)*~(B)*C*~(D)+A*~(B)*C*~(D)+~(A)*B*C*~(D)+A*B*C*~(D)+A*~(B)*~(C)*D+A*B*~(C)*D+A*~(B)*C*D+~(A)*B*C*D+A*B*C*D)"),
    .INIT(16'heaf0))
    \load_img_reg[3]_syn_3  (
    .a(\wr_base_b[13]_syn_2 ),
    .b(load_img_b1_n_syn_2),
    .c(\load_img[3]_dup_3 ),
    .d(load_state_reg_syn_1[2]),
    .o(\load_img_reg[3]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
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
    .SRMODE("ASYNC"),
    .TSMUX("0"))
    load_restart_syn_4 (
    .do({open_n230,open_n231,open_n232,load_state_reg_syn_1[3]}),
    .osclk(clk_dup_1),
    .rst(rst_dup_1),
    .opad(load_restart));  // ../../RTL_1/bridge/abc_hdmi_top.v(214)
  AL_DFF_X #(
    .INIT(1'b1))
    \load_state_reg[0]  (
    .ar(1'b0),
    .as(rst_dup_1),
    .clk(clk_dup_1),
    .d(mux35_syn_27),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(load_state_reg_syn_1[0]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \load_state_reg[1]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(mux35_syn_33),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(load_state_reg_syn_1[1]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \load_state_reg[2]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(mux35_syn_51),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(load_state_reg_syn_1[2]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \load_state_reg[3]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(mux35_syn_63),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(load_state_reg_syn_1[3]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*~A)"),
    .INIT(8'h01))
    mux35_syn_66 (
    .a(fill_done_dup_1),
    .b(source_done_dup_1),
    .c(\source_status[7]_dup_1 ),
    .o(mux35_syn_67));  // ../../RTL_1/bridge/abc_hdmi_top.v(308)
  AL_MAP_LUT3 #(
    .EQN("~(~C*~(B*~A))"),
    .INIT(8'hf4))
    mux35_syn_68 (
    .a(mux35_syn_67),
    .b(load_state_reg_syn_1[0]),
    .c(load_state_reg_syn_1[3]),
    .o(mux35_syn_27));  // ../../RTL_1/bridge/abc_hdmi_top.v(308)
  AL_MAP_LUT4 #(
    .EQN("(D*~C*B*~A)"),
    .INIT(16'h0400))
    mux35_syn_69 (
    .a(\source_status[3]_dup_1 ),
    .b(\source_status[2]_dup_1 ),
    .c(\source_status[1]_dup_1 ),
    .d(\source_status[0]_dup_1 ),
    .o(mux35_syn_70));  // ../../RTL_1/bridge/abc_hdmi_top.v(308)
  AL_MAP_LUT3 #(
    .EQN("(~C*B*A)"),
    .INIT(8'h08))
    mux35_syn_71 (
    .a(mux35_syn_70),
    .b(\source_status[5]_dup_1 ),
    .c(\source_status[4]_dup_1 ),
    .o(mux35_syn_72));  // ../../RTL_1/bridge/abc_hdmi_top.v(308)
  AL_MAP_LUT3 #(
    .EQN("(~C*B*A)"),
    .INIT(8'h08))
    mux35_syn_73 (
    .a(mux35_syn_72),
    .b(\source_status[7]_dup_1 ),
    .c(\source_status[6]_dup_1 ),
    .o(failed_b2_n2));  // ../../RTL_1/bridge/abc_hdmi_top.v(308)
  AL_MAP_LUT5 #(
    .EQN("(E*(D*~((C*B))*~(A)+D*(C*B)*~(A)+~(D)*(C*B)*A+D*(C*B)*A))"),
    .INIT(32'hd5800000))
    mux35_syn_74 (
    .a(failed_b2_n2),
    .b(fill_done_dup_1),
    .c(source_done_dup_1),
    .d(\source_status[7]_dup_1 ),
    .e(load_state_reg_syn_1[1]),
    .o(mux35_syn_47));  // ../../RTL_1/bridge/abc_hdmi_top.v(308)
  AL_MAP_LUT4 #(
    .EQN("(~A*~(~D*~(C*B)))"),
    .INIT(16'h5540))
    mux35_syn_75 (
    .a(mux35_syn_47),
    .b(mux35_syn_67),
    .c(load_state_reg_syn_1[0]),
    .d(load_state_reg_syn_1[1]),
    .o(mux35_syn_33));  // ../../RTL_1/bridge/abc_hdmi_top.v(308)
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    mux35_syn_76 (
    .a(failed[1]),
    .b(valid[0]),
    .o(mux35_syn_77));  // ../../RTL_1/bridge/abc_hdmi_top.v(308)
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*~A)"),
    .INIT(8'h01))
    mux35_syn_78 (
    .a(mux35_syn_77),
    .b(failed[2]),
    .c(valid[1]),
    .o(mux35_syn_79));  // ../../RTL_1/bridge/abc_hdmi_top.v(308)
  AL_MAP_LUT4 #(
    .EQN("(~B*~A*~(~D*~C))"),
    .INIT(16'h1110))
    mux35_syn_80 (
    .a(mux35_syn_79),
    .b(mux35_syn_77),
    .c(failed[3]),
    .d(valid[2]),
    .o(wanted_b3_n3));  // ../../RTL_1/bridge/abc_hdmi_top.v(308)
  AL_MAP_LUT4 #(
    .EQN("(~(~D*~B)*~(~C*~A))"),
    .INIT(16'hfac8))
    mux35_syn_81 (
    .a(failed[4]),
    .b(failed[5]),
    .c(valid[3]),
    .d(valid[4]),
    .o(mux35_syn_82));  // ../../RTL_1/bridge/abc_hdmi_top.v(308)
  AL_MAP_LUT4 #(
    .EQN("(A*~(B*~(~D*~C)))"),
    .INIT(16'h222a))
    mux35_syn_83 (
    .a(wanted_b3_n3),
    .b(mux35_syn_82),
    .c(failed[6]),
    .d(valid[5]),
    .o(mux35_syn_84));  // ../../RTL_1/bridge/abc_hdmi_top.v(308)
  AL_MAP_LUT4 #(
    .EQN("(~A*~(~D*~C*~B))"),
    .INIT(16'h5554))
    mux35_syn_85 (
    .a(mux35_syn_79),
    .b(mux35_syn_77),
    .c(failed[3]),
    .d(valid[2]),
    .o(mux35_syn_86));  // ../../RTL_1/bridge/abc_hdmi_top.v(308)
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    mux35_syn_87 (
    .a(mux35_syn_84),
    .b(mux35_syn_86),
    .o(mux35_syn_88));  // ../../RTL_1/bridge/abc_hdmi_top.v(308)
  AL_MAP_LUT4 #(
    .EQN("(~D*~B*~(~C*~A))"),
    .INIT(16'h0032))
    mux35_syn_89 (
    .a(failed[4]),
    .b(failed[5]),
    .c(valid[3]),
    .d(valid[4]),
    .o(mux35_syn_90));  // ../../RTL_1/bridge/abc_hdmi_top.v(308)
  AL_MAP_LUT3 #(
    .EQN("(~C*~(B*A))"),
    .INIT(8'h07))
    mux35_syn_91 (
    .a(mux35_syn_86),
    .b(mux35_syn_90),
    .c(mux35_syn_77),
    .o(mux35_syn_92));  // ../../RTL_1/bridge/abc_hdmi_top.v(308)
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*~A)"),
    .INIT(16'h0001))
    mux35_syn_93 (
    .a(mux35_syn_79),
    .b(mux35_syn_77),
    .c(failed[3]),
    .d(valid[2]),
    .o(mux35_syn_94));  // ../../RTL_1/bridge/abc_hdmi_top.v(308)
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    mux35_syn_95 (
    .a(mux35_syn_92),
    .b(mux35_syn_94),
    .o(mux35_syn_96));  // ../../RTL_1/bridge/abc_hdmi_top.v(308)
  AL_MAP_LUT4 #(
    .EQN("(B*~(~D*~C*A))"),
    .INIT(16'hccc4))
    mux35_syn_97 (
    .a(mux35_syn_88),
    .b(mux35_syn_96),
    .c(failed[7]),
    .d(valid[6]),
    .o(\wanted_b[0]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(308)
  AL_MAP_LUT4 #(
    .EQN("(B*A*~(~D*~C))"),
    .INIT(16'h8880))
    mux35_syn_98 (
    .a(\wanted_b[0]_syn_2 ),
    .b(mux35_syn_88),
    .c(failed[8]),
    .d(valid[7]),
    .o(load_img_b1_n_syn_2));  // ../../RTL_1/bridge/abc_hdmi_top.v(308)
  AL_MAP_LUT3 #(
    .EQN("~(~B*~(C*A))"),
    .INIT(8'hec))
    mux35_syn_99 (
    .a(load_img_b1_n_syn_2),
    .b(mux35_syn_47),
    .c(load_state_reg_syn_1[2]),
    .o(mux35_syn_51));  // ../../RTL_1/bridge/abc_hdmi_top.v(308)
  EG_PHY_PAD #(
    //.HYSTERESIS("OFF"),
    //.PCICLAMP("OFF"),
    .IOTYPE("LVCMOS25"),
    .MODE("IN"),
    .TSMUX("1"))
    next_pressed_syn_2 (
    .ipad(next_pressed),
    .di(next_pressed_dup_1));  // ../../RTL_1/bridge/abc_hdmi_top.v(212)
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .TSMUX("0"))
    preload_done_syn_2 (
    .do({open_n262,open_n263,open_n264,preload_done_dup_1}),
    .opad(preload_done));  // ../../RTL_1/bridge/abc_hdmi_top.v(216)
  EG_PHY_PAD #(
    //.HYSTERESIS("OFF"),
    //.PCICLAMP("OFF"),
    .IOTYPE("LVCMOS25"),
    .MODE("IN"),
    .TSMUX("1"))
    prev_pressed_syn_2 (
    .ipad(prev_pressed),
    .di(prev_pressed_dup_1));  // ../../RTL_1/bridge/abc_hdmi_top.v(212)
  AL_DFF_X #(
    .INIT(1'b0))
    preview_done_reg (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(preview_done_reg_syn_3),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(preview_done_dup_3));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(D*C*B*A)"),
    .INIT(16'h8000))
    preview_done_reg_syn_4 (
    .a(valid[4]),
    .b(valid[5]),
    .c(valid[6]),
    .d(valid[7]),
    .o(preload_done_n2));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT5 #(
    .EQN("(E*D*C*B*A)"),
    .INIT(32'h80000000))
    preview_done_reg_syn_5 (
    .a(preload_done_n2),
    .b(valid[0]),
    .c(valid[1]),
    .d(valid[2]),
    .e(valid[3]),
    .o(preload_done_dup_1));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*B*A)"),
    .INIT(16'h0008))
    preview_done_reg_syn_6 (
    .a(display_valid_i_syn_2),
    .b(switch_img[0]),
    .c(switch_img[2]),
    .d(switch_img[3]),
    .o(preview_done_reg_syn_7));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT4 #(
    .EQN("(~D*C*B*A)"),
    .INIT(16'h0080))
    preview_done_reg_syn_8 (
    .a(preload_done_dup_1),
    .b(preview_done_reg_syn_7),
    .c(preview_step[3]),
    .d(\switch_base[8]_dup_3 ),
    .o(preview_done_i_syn_2));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT2 #(
    .EQN("~(~B*~A)"),
    .INIT(4'he))
    preview_done_reg_syn_9 (
    .a(preview_done_i_syn_2),
    .b(preview_done_dup_3),
    .o(preview_done_reg_syn_3));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
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
    .SRMODE("ASYNC"),
    .TSMUX("0"))
    preview_done_syn_4 (
    .ce(preview_done_i_syn_2),
    .do({open_n295,open_n296,open_n297,1'b1}),
    .osclk(clk_dup_1),
    .rst(rst_dup_1),
    .opad(preview_done));  // ../../RTL_1/bridge/abc_hdmi_top.v(216)
  AL_DFF_X #(
    .INIT(1'b0))
    \preview_step_reg[0]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\preview_step_reg[0]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(preview_step[0]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT2 #(
    .EQN("(B@A)"),
    .INIT(4'h6))
    \preview_step_reg[0]_syn_3  (
    .a(mux13_syn_2[3]),
    .b(preview_step[0]),
    .o(\preview_step_reg[0]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \preview_step_reg[1]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\preview_step_reg[1]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(preview_step[1]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT3 #(
    .EQN("(C@(B*A))"),
    .INIT(8'h78))
    \preview_step_reg[1]_syn_3  (
    .a(mux13_syn_2[3]),
    .b(preview_step[0]),
    .c(preview_step[1]),
    .o(\preview_step_reg[1]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \preview_step_reg[2]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\preview_step_reg[2]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(preview_step[2]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*A)"),
    .INIT(8'h02))
    \preview_step_reg[2]_syn_3  (
    .a(display_valid_i_syn_2),
    .b(preview_done_dup_3),
    .c(preview_step[3]),
    .o(mux13_syn_2[3]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT3 #(
    .EQN("~(~C*~(B)*~(A)+~C*B*~(A)+~(~C)*B*A+~C*B*A)"),
    .INIT(8'h72))
    \preview_step_reg[2]_syn_4  (
    .a(mux13_syn_2[3]),
    .b(\key_count_reg[3]_syn_4 ),
    .c(preview_step[2]),
    .o(\preview_step_reg[2]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \preview_step_reg[3]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\preview_step_reg[3]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(preview_step[3]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT5 #(
    .EQN("~(~E*~(D*C*B*A))"),
    .INIT(32'hffff8000))
    \preview_step_reg[3]_syn_3  (
    .a(mux13_syn_2[3]),
    .b(preview_step[0]),
    .c(preview_step[1]),
    .d(preview_step[2]),
    .e(preview_step[3]),
    .o(\preview_step_reg[3]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  EG_PHY_PAD #(
    //.HYSTERESIS("OFF"),
    //.PCICLAMP("OFF"),
    .IOTYPE("LVCMOS25"),
    .MODE("IN"),
    .TSMUX("1"))
    rst_syn_2 (
    .ipad(rst),
    .di(rst_dup_1));  // ../../RTL_1/bridge/abc_hdmi_top.v(212)
  AL_MAP_LUT4 #(
    .EQN("(A*B*~(C)*~(D)+~(A)*~(B)*C*~(D)+~(A)*~(B)*C*D)"),
    .INIT(16'h1018))
    sel1_syn_309 (
    .a(\key_count_reg[3]_syn_56 ),
    .b(\key_count_reg[3]_syn_62 ),
    .c(\key_count_reg[3]_syn_66 ),
    .d(\key_count_reg[3]_syn_68 ),
    .o(sel1_syn_2[13]));  // ../../RTL_1/bridge/abc_hdmi_top.v(243)
  AL_MAP_LUT4 #(
    .EQN("(~D*~(A@(~C*B)))"),
    .INIT(16'h0059))
    sel1_syn_310 (
    .a(\key_count_reg[3]_syn_56 ),
    .b(\key_count_reg[3]_syn_62 ),
    .c(\key_count_reg[3]_syn_66 ),
    .d(\key_count_reg[3]_syn_68 ),
    .o(sel1_syn_2[0]));  // ../../RTL_1/bridge/abc_hdmi_top.v(243)
  AL_MAP_LUT4 #(
    .EQN("(A*B*~(C)*~(D)+~(A)*~(B)*C*~(D)+~(A)*~(B)*~(C)*D+~(A)*B*C*D)"),
    .INIT(16'h4118))
    sel1_syn_311 (
    .a(\key_count_reg[3]_syn_56 ),
    .b(\key_count_reg[3]_syn_62 ),
    .c(\key_count_reg[3]_syn_66 ),
    .d(\key_count_reg[3]_syn_68 ),
    .o(sel1_syn_2[2]));  // ../../RTL_1/bridge/abc_hdmi_top.v(243)
  AL_MAP_LUT4 #(
    .EQN("(~(A)*~(B)*~(C)*~(D)+A*B*~(C)*~(D)+~(A)*B*C*~(D)+~(A)*~(B)*~(C)*D+~(A)*~(B)*C*D)"),
    .INIT(16'h1149))
    sel1_syn_312 (
    .a(\key_count_reg[3]_syn_56 ),
    .b(\key_count_reg[3]_syn_62 ),
    .c(\key_count_reg[3]_syn_66 ),
    .d(\key_count_reg[3]_syn_68 ),
    .o(sel1_syn_2[6]));  // ../../RTL_1/bridge/abc_hdmi_top.v(243)
  AL_MAP_LUT4 #(
    .EQN("(~C*(~(A)*~(B)*~(D)+A*B*~(D)+~(A)*~(B)*D))"),
    .INIT(16'h0109))
    sel1_syn_313 (
    .a(\key_count_reg[3]_syn_56 ),
    .b(\key_count_reg[3]_syn_62 ),
    .c(\key_count_reg[3]_syn_66 ),
    .d(\key_count_reg[3]_syn_68 ),
    .o(sel1_syn_2[12]));  // ../../RTL_1/bridge/abc_hdmi_top.v(243)
  AL_MAP_LUT4 #(
    .EQN("(~A*(~(B)*~(C)*~(D)+~(B)*C*~(D)+B*C*~(D)+~(B)*~(C)*D+B*C*D))"),
    .INIT(16'h4151))
    sel1_syn_314 (
    .a(\key_count_reg[3]_syn_56 ),
    .b(\key_count_reg[3]_syn_62 ),
    .c(\key_count_reg[3]_syn_66 ),
    .d(\key_count_reg[3]_syn_68 ),
    .o(sel1_syn_2[10]));  // ../../RTL_1/bridge/abc_hdmi_top.v(243)
  AL_MAP_LUT4 #(
    .EQN("(~A*(~(B)*~(C)*~(D)+~(B)*C*~(D)+B*C*~(D)+~(B)*C*D))"),
    .INIT(16'h1051))
    sel1_syn_315 (
    .a(\key_count_reg[3]_syn_56 ),
    .b(\key_count_reg[3]_syn_62 ),
    .c(\key_count_reg[3]_syn_66 ),
    .d(\key_count_reg[3]_syn_68 ),
    .o(sel1_syn_2[4]));  // ../../RTL_1/bridge/abc_hdmi_top.v(243)
  AL_MAP_LUT4 #(
    .EQN("(A*B*~(C)*~(D)+~(A)*B*C*~(D)+~(A)*~(B)*C*D+~(A)*B*C*D)"),
    .INIT(16'h5048))
    sel1_syn_316 (
    .a(\key_count_reg[3]_syn_56 ),
    .b(\key_count_reg[3]_syn_62 ),
    .c(\key_count_reg[3]_syn_66 ),
    .d(\key_count_reg[3]_syn_68 ),
    .o(sel1_syn_2[9]));  // ../../RTL_1/bridge/abc_hdmi_top.v(243)
  AL_MAP_LUT2 #(
    .EQN("(B*A)"),
    .INIT(4'h8))
    sel1_syn_317 (
    .a(\key_count_reg[3]_syn_66 ),
    .b(\key_count_reg[3]_syn_68 ),
    .o(sel1_syn_186));  // ../../RTL_1/bridge/abc_hdmi_top.v(243)
  AL_MAP_LUT4 #(
    .EQN("(~A*~(~B*~(~D*~C)))"),
    .INIT(16'h4445))
    sel1_syn_318 (
    .a(\key_count_reg[3]_syn_56 ),
    .b(sel1_syn_186),
    .c(\key_count_reg[3]_syn_62 ),
    .d(\key_count_reg[3]_syn_68 ),
    .o(sel1_syn_2[7]));  // ../../RTL_1/bridge/abc_hdmi_top.v(243)
  AL_MAP_LUT4 #(
    .EQN("(~A*(~(B)*~(C)*~(D)+~(B)*C*D+B*C*D))"),
    .INIT(16'h5001))
    sel1_syn_319 (
    .a(\key_count_reg[3]_syn_56 ),
    .b(\key_count_reg[3]_syn_62 ),
    .c(\key_count_reg[3]_syn_66 ),
    .d(\key_count_reg[3]_syn_68 ),
    .o(sel1_syn_2[5]));  // ../../RTL_1/bridge/abc_hdmi_top.v(243)
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    sel1_syn_320 (
    .a(\key_count_reg[3]_syn_56 ),
    .b(\key_count_reg[3]_syn_62 ),
    .o(sel1_syn_192));  // ../../RTL_1/bridge/abc_hdmi_top.v(243)
  AL_MAP_LUT3 #(
    .EQN("(C*~(~B*~A))"),
    .INIT(8'he0))
    sel1_syn_321 (
    .a(sel1_syn_192),
    .b(sel1_syn_2[1]),
    .c(\key_count_reg[3]_syn_68 ),
    .o(sel1_syn_2[11]));  // ../../RTL_1/bridge/abc_hdmi_top.v(243)
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    sel1_syn_322 (
    .a(sel1_syn_192),
    .b(sel1_syn_186),
    .o(sel1_syn_2[3]));  // ../../RTL_1/bridge/abc_hdmi_top.v(243)
  EG_PHY_PAD #(
    //.HYSTERESIS("OFF"),
    //.PCICLAMP("OFF"),
    .IOTYPE("LVCMOS25"),
    .MODE("IN"),
    .TSMUX("1"))
    source_done_syn_2 (
    .ipad(source_done),
    .di(source_done_dup_1));  // ../../RTL_1/bridge/abc_hdmi_top.v(213)
  EG_PHY_PAD #(
    //.HYSTERESIS("OFF"),
    //.PCICLAMP("OFF"),
    .IOTYPE("LVCMOS25"),
    .MODE("IN"),
    .TSMUX("1"))
    \source_status[0]_syn_2  (
    .ipad(source_status[0]),
    .di(\source_status[0]_dup_1 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(213)
  EG_PHY_PAD #(
    //.HYSTERESIS("OFF"),
    //.PCICLAMP("OFF"),
    .IOTYPE("LVCMOS25"),
    .MODE("IN"),
    .TSMUX("1"))
    \source_status[1]_syn_2  (
    .ipad(source_status[1]),
    .di(\source_status[1]_dup_1 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(213)
  EG_PHY_PAD #(
    //.HYSTERESIS("OFF"),
    //.PCICLAMP("OFF"),
    .IOTYPE("LVCMOS25"),
    .MODE("IN"),
    .TSMUX("1"))
    \source_status[2]_syn_2  (
    .ipad(source_status[2]),
    .di(\source_status[2]_dup_1 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(213)
  EG_PHY_PAD #(
    //.HYSTERESIS("OFF"),
    //.PCICLAMP("OFF"),
    .IOTYPE("LVCMOS25"),
    .MODE("IN"),
    .TSMUX("1"))
    \source_status[3]_syn_2  (
    .ipad(source_status[3]),
    .di(\source_status[3]_dup_1 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(213)
  EG_PHY_PAD #(
    //.HYSTERESIS("OFF"),
    //.PCICLAMP("OFF"),
    .IOTYPE("LVCMOS25"),
    .MODE("IN"),
    .TSMUX("1"))
    \source_status[4]_syn_2  (
    .ipad(source_status[4]),
    .di(\source_status[4]_dup_1 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(213)
  EG_PHY_PAD #(
    //.HYSTERESIS("OFF"),
    //.PCICLAMP("OFF"),
    .IOTYPE("LVCMOS25"),
    .MODE("IN"),
    .TSMUX("1"))
    \source_status[5]_syn_2  (
    .ipad(source_status[5]),
    .di(\source_status[5]_dup_1 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(213)
  EG_PHY_PAD #(
    //.HYSTERESIS("OFF"),
    //.PCICLAMP("OFF"),
    .IOTYPE("LVCMOS25"),
    .MODE("IN"),
    .TSMUX("1"))
    \source_status[6]_syn_2  (
    .ipad(source_status[6]),
    .di(\source_status[6]_dup_1 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(213)
  EG_PHY_PAD #(
    //.HYSTERESIS("OFF"),
    //.PCICLAMP("OFF"),
    .IOTYPE("LVCMOS25"),
    .MODE("IN"),
    .TSMUX("1"))
    \source_status[7]_syn_2  (
    .ipad(source_status[7]),
    .di(\source_status[7]_dup_1 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(213)
  EG_PHY_PAD #(
    //.HYSTERESIS("OFF"),
    //.PCICLAMP("OFF"),
    .IOTYPE("LVCMOS25"),
    .MODE("IN"),
    .TSMUX("1"))
    switch_ack_syn_2 (
    .ipad(switch_ack),
    .di(switch_ack_dup_1));  // ../../RTL_1/bridge/abc_hdmi_top.v(215)
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .TSMUX("0"))
    \switch_base[0]_syn_1  (
    .do({open_n497,open_n498,open_n499,1'b0}),
    .opad(switch_base[0]));  // ../../RTL_1/bridge/abc_hdmi_top.v(215)
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
    .SRMODE("ASYNC"),
    .TSMUX("0"))
    \switch_base[10]_syn_4  (
    .ce(launch_switch),
    .do({open_n513,open_n514,open_n515,sel1_syn_2[3]}),
    .osclk(clk_dup_1),
    .rst(rst_dup_1),
    .opad(switch_base[10]));  // ../../RTL_1/bridge/abc_hdmi_top.v(215)
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
    .SRMODE("ASYNC"),
    .TSMUX("0"))
    \switch_base[11]_syn_4  (
    .ce(launch_switch),
    .do({open_n527,open_n528,open_n529,sel1_syn_2[4]}),
    .osclk(clk_dup_1),
    .rst(rst_dup_1),
    .opad(switch_base[11]));  // ../../RTL_1/bridge/abc_hdmi_top.v(215)
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
    .SRMODE("ASYNC"),
    .TSMUX("0"))
    \switch_base[12]_syn_4  (
    .ce(launch_switch),
    .do({open_n541,open_n542,open_n543,sel1_syn_2[5]}),
    .osclk(clk_dup_1),
    .rst(rst_dup_1),
    .opad(switch_base[12]));  // ../../RTL_1/bridge/abc_hdmi_top.v(215)
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
    .SRMODE("ASYNC"),
    .TSMUX("0"))
    \switch_base[13]_syn_4  (
    .ce(launch_switch),
    .do({open_n555,open_n556,open_n557,sel1_syn_2[6]}),
    .osclk(clk_dup_1),
    .rst(rst_dup_1),
    .opad(switch_base[13]));  // ../../RTL_1/bridge/abc_hdmi_top.v(215)
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
    .SRMODE("ASYNC"),
    .TSMUX("0"))
    \switch_base[14]_syn_4  (
    .ce(launch_switch),
    .do({open_n569,open_n570,open_n571,sel1_syn_2[7]}),
    .osclk(clk_dup_1),
    .rst(rst_dup_1),
    .opad(switch_base[14]));  // ../../RTL_1/bridge/abc_hdmi_top.v(215)
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
    .SRMODE("ASYNC"),
    .TSMUX("0"))
    \switch_base[15]_syn_1  (
    .ce(launch_switch),
    .do({open_n583,open_n584,open_n585,sel1_syn_2[6]}),
    .osclk(clk_dup_1),
    .rst(rst_dup_1),
    .opad(switch_base[15]));  // ../../RTL_1/bridge/abc_hdmi_top.v(215)
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
    .SRMODE("ASYNC"),
    .TSMUX("0"))
    \switch_base[16]_syn_4  (
    .ce(launch_switch),
    .do({open_n597,open_n598,open_n599,sel1_syn_2[9]}),
    .osclk(clk_dup_1),
    .rst(rst_dup_1),
    .opad(switch_base[16]));  // ../../RTL_1/bridge/abc_hdmi_top.v(215)
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
    .SRMODE("ASYNC"),
    .TSMUX("0"))
    \switch_base[17]_syn_4  (
    .ce(launch_switch),
    .do({open_n611,open_n612,open_n613,sel1_syn_2[10]}),
    .osclk(clk_dup_1),
    .rst(rst_dup_1),
    .opad(switch_base[17]));  // ../../RTL_1/bridge/abc_hdmi_top.v(215)
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
    .SRMODE("ASYNC"),
    .TSMUX("0"))
    \switch_base[18]_syn_4  (
    .ce(launch_switch),
    .do({open_n625,open_n626,open_n627,sel1_syn_2[11]}),
    .osclk(clk_dup_1),
    .rst(rst_dup_1),
    .opad(switch_base[18]));  // ../../RTL_1/bridge/abc_hdmi_top.v(215)
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
    .SRMODE("ASYNC"),
    .TSMUX("0"))
    \switch_base[19]_syn_4  (
    .ce(launch_switch),
    .do({open_n639,open_n640,open_n641,sel1_syn_2[12]}),
    .osclk(clk_dup_1),
    .rst(rst_dup_1),
    .opad(switch_base[19]));  // ../../RTL_1/bridge/abc_hdmi_top.v(215)
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .TSMUX("0"))
    \switch_base[1]_syn_1  (
    .do({open_n654,open_n655,open_n656,1'b0}),
    .opad(switch_base[1]));  // ../../RTL_1/bridge/abc_hdmi_top.v(215)
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
    .SRMODE("ASYNC"),
    .TSMUX("0"))
    \switch_base[20]_syn_4  (
    .ce(launch_switch),
    .do({open_n670,open_n671,open_n672,sel1_syn_2[13]}),
    .osclk(clk_dup_1),
    .rst(rst_dup_1),
    .opad(switch_base[20]));  // ../../RTL_1/bridge/abc_hdmi_top.v(215)
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .TSMUX("0"))
    \switch_base[2]_syn_1  (
    .do({open_n685,open_n686,open_n687,1'b0}),
    .opad(switch_base[2]));  // ../../RTL_1/bridge/abc_hdmi_top.v(215)
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .TSMUX("0"))
    \switch_base[3]_syn_1  (
    .do({open_n702,open_n703,open_n704,1'b0}),
    .opad(switch_base[3]));  // ../../RTL_1/bridge/abc_hdmi_top.v(215)
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .TSMUX("0"))
    \switch_base[4]_syn_1  (
    .do({open_n719,open_n720,open_n721,1'b0}),
    .opad(switch_base[4]));  // ../../RTL_1/bridge/abc_hdmi_top.v(215)
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .TSMUX("0"))
    \switch_base[5]_syn_1  (
    .do({open_n736,open_n737,open_n738,1'b0}),
    .opad(switch_base[5]));  // ../../RTL_1/bridge/abc_hdmi_top.v(215)
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .TSMUX("0"))
    \switch_base[6]_syn_1  (
    .do({open_n753,open_n754,open_n755,1'b0}),
    .opad(switch_base[6]));  // ../../RTL_1/bridge/abc_hdmi_top.v(215)
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
    .SRMODE("ASYNC"),
    .TSMUX("0"))
    \switch_base[7]_syn_4  (
    .ce(launch_switch),
    .do({open_n769,open_n770,open_n771,sel1_syn_2[0]}),
    .osclk(clk_dup_1),
    .rst(rst_dup_1),
    .opad(switch_base[7]));  // ../../RTL_1/bridge/abc_hdmi_top.v(215)
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
    .SRMODE("ASYNC"),
    .TSMUX("0"))
    \switch_base[8]_syn_4  (
    .ce(launch_switch),
    .do({open_n783,open_n784,open_n785,sel1_syn_2[1]}),
    .osclk(clk_dup_1),
    .rst(rst_dup_1),
    .opad(switch_base[8]));  // ../../RTL_1/bridge/abc_hdmi_top.v(215)
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
    .SRMODE("ASYNC"),
    .TSMUX("0"))
    \switch_base[9]_syn_4  (
    .ce(launch_switch),
    .do({open_n797,open_n798,open_n799,sel1_syn_2[2]}),
    .osclk(clk_dup_1),
    .rst(rst_dup_1),
    .opad(switch_base[9]));  // ../../RTL_1/bridge/abc_hdmi_top.v(215)
  AL_DFF_X #(
    .INIT(1'b0))
    \switch_base_reg[8]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\switch_base_reg[8]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(\switch_base[8]_dup_3 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    \switch_base_reg[8]_syn_3  (
    .a(\key_count_reg[3]_syn_56 ),
    .b(\key_count_reg[3]_syn_66 ),
    .o(sel1_syn_2[1]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    \switch_base_reg[8]_syn_4  (
    .a(launch_switch),
    .b(sel1_syn_2[1]),
    .c(\switch_base[8]_dup_3 ),
    .o(\switch_base_reg[8]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b1))
    \switch_img_reg[0]  (
    .ar(1'b0),
    .as(rst_dup_1),
    .clk(clk_dup_1),
    .d(\switch_img_reg[0]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(switch_img[0]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    \switch_img_reg[0]_syn_3  (
    .a(launch_switch),
    .b(\key_count_reg[3]_syn_68 ),
    .c(switch_img[0]),
    .o(\switch_img_reg[0]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \switch_img_reg[2]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\switch_img_reg[2]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(switch_img[2]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT3 #(
    .EQN("~(~C*~(B)*~(A)+~C*B*~(A)+~(~C)*B*A+~C*B*A)"),
    .INIT(8'h72))
    \switch_img_reg[2]_syn_3  (
    .a(launch_switch),
    .b(\key_count_reg[3]_syn_62 ),
    .c(switch_img[2]),
    .o(\switch_img_reg[2]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \switch_img_reg[3]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\switch_img_reg[3]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(switch_img[3]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    \switch_img_reg[3]_syn_3  (
    .a(launch_switch),
    .b(\key_count_reg[3]_syn_56 ),
    .c(switch_img[3]),
    .o(\switch_img_reg[3]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT1 #(
    .EQN("(~A)"),
    .INIT(2'h1))
    switch_req_n2_syn_1 (
    .a(switch_req_dup_3),
    .o(switch_req_n2));
  AL_DFF_X #(
    .INIT(1'b0))
    switch_req_reg (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(switch_req_reg_syn_3),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(switch_req_dup_3));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT2 #(
    .EQN("(B@A)"),
    .INIT(4'h6))
    switch_req_reg_syn_4 (
    .a(launch_switch),
    .b(switch_req_dup_3),
    .o(switch_req_reg_syn_3));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
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
    .SRMODE("ASYNC"),
    .TSMUX("0"))
    switch_req_syn_4 (
    .ce(launch_switch),
    .do({open_n811,open_n812,open_n813,switch_req_n2}),
    .osclk(clk_dup_1),
    .rst(rst_dup_1),
    .opad(switch_req));  // ../../RTL_1/bridge/abc_hdmi_top.v(215)
  AL_DFF_X #(
    .INIT(1'b0))
    \valid_reg[0]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\valid_reg[0]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(valid[0]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    \valid_reg[0]_syn_3  (
    .a(mux38_syn_44),
    .b(failed_b2_n2),
    .c(valid[0]),
    .o(\valid_reg[0]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \valid_reg[1]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\valid_reg[1]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(valid[1]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    \valid_reg[1]_syn_3  (
    .a(mux38_syn_54),
    .b(failed_b2_n2),
    .c(valid[1]),
    .o(\valid_reg[1]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \valid_reg[2]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\valid_reg[2]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(valid[2]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    \valid_reg[2]_syn_3  (
    .a(mux38_syn_64),
    .b(failed_b2_n2),
    .c(valid[2]),
    .o(\valid_reg[2]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \valid_reg[3]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\valid_reg[3]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(valid[3]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    \valid_reg[3]_syn_3  (
    .a(mux38_syn_74),
    .b(failed_b2_n2),
    .c(valid[3]),
    .o(\valid_reg[3]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \valid_reg[4]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\valid_reg[4]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(valid[4]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    \valid_reg[4]_syn_3  (
    .a(mux38_syn_84),
    .b(failed_b2_n2),
    .c(valid[4]),
    .o(\valid_reg[4]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \valid_reg[5]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\valid_reg[5]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(valid[5]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    \valid_reg[5]_syn_3  (
    .a(mux38_syn_94),
    .b(failed_b2_n2),
    .c(valid[5]),
    .o(\valid_reg[5]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \valid_reg[6]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\valid_reg[6]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(valid[6]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    \valid_reg[6]_syn_3  (
    .a(mux38_syn_104),
    .b(failed_b2_n2),
    .c(valid[6]),
    .o(\valid_reg[6]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_DFF_X #(
    .INIT(1'b0))
    \valid_reg[7]  (
    .ar(rst_dup_1),
    .as(1'b0),
    .clk(clk_dup_1),
    .d(\valid_reg[7]_syn_2 ),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(valid[7]));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  AL_MAP_LUT3 #(
    .EQN("(C*~(B)*~(A)+C*B*~(A)+~(C)*B*A+C*B*A)"),
    .INIT(8'hd8))
    \valid_reg[7]_syn_3  (
    .a(mux38_syn_114),
    .b(failed_b2_n2),
    .c(valid[7]),
    .o(\valid_reg[7]_syn_2 ));  // ../../RTL_1/bridge/abc_hdmi_top.v(273)
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .TSMUX("0"))
    \wr_base[0]_syn_1  (
    .do({open_n826,open_n827,open_n828,1'b0}),
    .opad(wr_base[0]));  // ../../RTL_1/bridge/abc_hdmi_top.v(214)
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
    .SRMODE("ASYNC"),
    .TSMUX("0"))
    \wr_base[10]_syn_4  (
    .ce(mux35_syn_63),
    .do({open_n842,open_n843,open_n844,wr_base_b[10]}),
    .osclk(clk_dup_1),
    .rst(rst_dup_1),
    .opad(wr_base[10]));  // ../../RTL_1/bridge/abc_hdmi_top.v(214)
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
    .SRMODE("ASYNC"),
    .TSMUX("0"))
    \wr_base[11]_syn_4  (
    .ce(mux35_syn_63),
    .do({open_n856,open_n857,open_n858,wr_base_b[11]}),
    .osclk(clk_dup_1),
    .rst(rst_dup_1),
    .opad(wr_base[11]));  // ../../RTL_1/bridge/abc_hdmi_top.v(214)
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
    .SRMODE("ASYNC"),
    .TSMUX("0"))
    \wr_base[12]_syn_4  (
    .ce(mux35_syn_63),
    .do({open_n870,open_n871,open_n872,wr_base_b[12]}),
    .osclk(clk_dup_1),
    .rst(rst_dup_1),
    .opad(wr_base[12]));  // ../../RTL_1/bridge/abc_hdmi_top.v(214)
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
    .SRMODE("ASYNC"),
    .TSMUX("0"))
    \wr_base[13]_syn_4  (
    .ce(mux35_syn_63),
    .do({open_n884,open_n885,open_n886,wr_base_b[13]}),
    .osclk(clk_dup_1),
    .rst(rst_dup_1),
    .opad(wr_base[13]));  // ../../RTL_1/bridge/abc_hdmi_top.v(214)
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
    .SRMODE("ASYNC"),
    .TSMUX("0"))
    \wr_base[14]_syn_4  (
    .ce(mux35_syn_63),
    .do({open_n898,open_n899,open_n900,wr_base_b[14]}),
    .osclk(clk_dup_1),
    .rst(rst_dup_1),
    .opad(wr_base[14]));  // ../../RTL_1/bridge/abc_hdmi_top.v(214)
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
    .SRMODE("ASYNC"),
    .TSMUX("0"))
    \wr_base[15]_syn_1  (
    .ce(mux35_syn_63),
    .do({open_n912,open_n913,open_n914,wr_base_b[13]}),
    .osclk(clk_dup_1),
    .rst(rst_dup_1),
    .opad(wr_base[15]));  // ../../RTL_1/bridge/abc_hdmi_top.v(214)
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
    .SRMODE("ASYNC"),
    .TSMUX("0"))
    \wr_base[16]_syn_4  (
    .ce(mux35_syn_63),
    .do({open_n926,open_n927,open_n928,wr_base_b[16]}),
    .osclk(clk_dup_1),
    .rst(rst_dup_1),
    .opad(wr_base[16]));  // ../../RTL_1/bridge/abc_hdmi_top.v(214)
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
    .SRMODE("ASYNC"),
    .TSMUX("0"))
    \wr_base[17]_syn_4  (
    .ce(mux35_syn_63),
    .do({open_n940,open_n941,open_n942,wr_base_b[17]}),
    .osclk(clk_dup_1),
    .rst(rst_dup_1),
    .opad(wr_base[17]));  // ../../RTL_1/bridge/abc_hdmi_top.v(214)
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
    .SRMODE("ASYNC"),
    .TSMUX("0"))
    \wr_base[18]_syn_4  (
    .ce(mux35_syn_63),
    .do({open_n954,open_n955,open_n956,wr_base_b[18]}),
    .osclk(clk_dup_1),
    .rst(rst_dup_1),
    .opad(wr_base[18]));  // ../../RTL_1/bridge/abc_hdmi_top.v(214)
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
    .SRMODE("ASYNC"),
    .TSMUX("0"))
    \wr_base[19]_syn_4  (
    .ce(mux35_syn_63),
    .do({open_n968,open_n969,open_n970,wr_base_b[19]}),
    .osclk(clk_dup_1),
    .rst(rst_dup_1),
    .opad(wr_base[19]));  // ../../RTL_1/bridge/abc_hdmi_top.v(214)
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .TSMUX("0"))
    \wr_base[1]_syn_1  (
    .do({open_n983,open_n984,open_n985,1'b0}),
    .opad(wr_base[1]));  // ../../RTL_1/bridge/abc_hdmi_top.v(214)
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
    .SRMODE("ASYNC"),
    .TSMUX("0"))
    \wr_base[20]_syn_4  (
    .ce(mux35_syn_63),
    .do({open_n999,open_n1000,open_n1001,wr_base_b[20]}),
    .osclk(clk_dup_1),
    .rst(rst_dup_1),
    .opad(wr_base[20]));  // ../../RTL_1/bridge/abc_hdmi_top.v(214)
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .TSMUX("0"))
    \wr_base[2]_syn_1  (
    .do({open_n1014,open_n1015,open_n1016,1'b0}),
    .opad(wr_base[2]));  // ../../RTL_1/bridge/abc_hdmi_top.v(214)
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .TSMUX("0"))
    \wr_base[3]_syn_1  (
    .do({open_n1031,open_n1032,open_n1033,1'b0}),
    .opad(wr_base[3]));  // ../../RTL_1/bridge/abc_hdmi_top.v(214)
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .TSMUX("0"))
    \wr_base[4]_syn_1  (
    .do({open_n1048,open_n1049,open_n1050,1'b0}),
    .opad(wr_base[4]));  // ../../RTL_1/bridge/abc_hdmi_top.v(214)
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .TSMUX("0"))
    \wr_base[5]_syn_1  (
    .do({open_n1065,open_n1066,open_n1067,1'b0}),
    .opad(wr_base[5]));  // ../../RTL_1/bridge/abc_hdmi_top.v(214)
  EG_PHY_PAD #(
    //.SLEWRATE("SLOW"),
    .DRIVE("8"),
    .IOTYPE("LVCMOS25"),
    .MODE("OUT"),
    .TSMUX("0"))
    \wr_base[6]_syn_1  (
    .do({open_n1082,open_n1083,open_n1084,1'b0}),
    .opad(wr_base[6]));  // ../../RTL_1/bridge/abc_hdmi_top.v(214)
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
    .SRMODE("ASYNC"),
    .TSMUX("0"))
    \wr_base[7]_syn_4  (
    .ce(mux35_syn_63),
    .do({open_n1098,open_n1099,open_n1100,wr_base_b[7]}),
    .osclk(clk_dup_1),
    .rst(rst_dup_1),
    .opad(wr_base[7]));  // ../../RTL_1/bridge/abc_hdmi_top.v(214)
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
    .SRMODE("ASYNC"),
    .TSMUX("0"))
    \wr_base[8]_syn_1  (
    .ce(mux35_syn_63),
    .do({open_n1112,open_n1113,open_n1114,load_img_b[1]}),
    .osclk(clk_dup_1),
    .rst(rst_dup_1),
    .opad(wr_base[8]));  // ../../RTL_1/bridge/abc_hdmi_top.v(214)
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
    .SRMODE("ASYNC"),
    .TSMUX("0"))
    \wr_base[9]_syn_4  (
    .ce(mux35_syn_63),
    .do({open_n1126,open_n1127,open_n1128,wr_base_b[9]}),
    .osclk(clk_dup_1),
    .rst(rst_dup_1),
    .opad(wr_base[9]));  // ../../RTL_1/bridge/abc_hdmi_top.v(214)
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    \wr_base_b[10]_syn_1  (
    .a(mux35_syn_84),
    .b(mux36_syn_20),
    .o(wr_base_b[10]));
  AL_MAP_LUT4 #(
    .EQN("(~D*~(~C*~(B*~A)))"),
    .INIT(16'h00f4))
    \wr_base_b[11]_syn_1  (
    .a(\wanted[2]_syn_2 ),
    .b(mux35_syn_92),
    .c(mux35_syn_79),
    .d(mux36_syn_20),
    .o(wr_base_b[11]));
  AL_MAP_LUT3 #(
    .EQN("(~C*~(~B*~A))"),
    .INIT(8'h0e))
    \wr_base_b[12]_syn_1  (
    .a(\wr_base_b[9]_syn_10 ),
    .b(mux35_syn_94),
    .c(mux36_syn_20),
    .o(wr_base_b[12]));
  AL_MAP_LUT3 #(
    .EQN("(~C*B*A)"),
    .INIT(8'h08))
    \wr_base_b[13]_syn_1  (
    .a(\wanted_b[0]_syn_2 ),
    .b(\wr_base_b[9]_syn_12 ),
    .c(mux35_syn_84),
    .o(\wr_base_b[13]_syn_2 ));
  AL_MAP_LUT4 #(
    .EQN("(~D*(~(A)*~(B)*~(C)+~(A)*B*~(C)+A*B*~(C)+A*~(B)*C+A*B*C))"),
    .INIT(16'h00ad))
    \wr_base_b[13]_syn_3  (
    .a(\wanted[2]_syn_2 ),
    .b(\wr_base_b[13]_syn_2 ),
    .c(\wr_base_b[9]_syn_8 ),
    .d(mux36_syn_20),
    .o(wr_base_b[13]));
  AL_MAP_LUT4 #(
    .EQN("(~D*C*~(~B*A))"),
    .INIT(16'h00d0))
    \wr_base_b[14]_syn_1  (
    .a(\wanted_b[0]_syn_2 ),
    .b(mux35_syn_84),
    .c(mux35_syn_92),
    .d(mux36_syn_20),
    .o(wr_base_b[14]));
  AL_MAP_LUT2 #(
    .EQN("(B*~A)"),
    .INIT(4'h4))
    \wr_base_b[16]_syn_1  (
    .a(\wr_base_b[9]_syn_3 ),
    .b(\wr_base_b[9]_syn_6 ),
    .o(\wr_base_b[16]_syn_2 ));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    \wr_base_b[16]_syn_3  (
    .a(\wr_base_b[16]_syn_2 ),
    .b(mux36_syn_20),
    .o(load_img_b[1]));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    \wr_base_b[16]_syn_4  (
    .a(\wr_base_b[13]_syn_2 ),
    .b(mux36_syn_20),
    .o(load_img_b[3]));
  AL_MAP_LUT3 #(
    .EQN("~(~B*~(~C*A))"),
    .INIT(8'hce))
    \wr_base_b[16]_syn_5  (
    .a(load_img_b[1]),
    .b(load_img_b[3]),
    .c(mux35_syn_84),
    .o(wr_base_b[16]));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    \wr_base_b[17]_syn_1  (
    .a(mux35_syn_88),
    .b(mux36_syn_20),
    .o(wr_base_b[17]));
  AL_MAP_LUT3 #(
    .EQN("(B*~(~C*A))"),
    .INIT(8'hc4))
    \wr_base_b[18]_syn_1  (
    .a(\wanted[2]_syn_2 ),
    .b(load_img_b[0]),
    .c(mux35_syn_94),
    .o(wr_base_b[18]));
  AL_MAP_LUT4 #(
    .EQN("(~C*~(~A*~(~D*B)))"),
    .INIT(16'h0a0e))
    \wr_base_b[19]_syn_1  (
    .a(\wr_base_b[13]_syn_2 ),
    .b(wanted_b3_n3),
    .c(mux36_syn_20),
    .d(mux35_syn_82),
    .o(wr_base_b[19]));
  AL_MAP_LUT3 #(
    .EQN("~(~B*~(~C*A))"),
    .INIT(8'hce))
    \wr_base_b[20]_syn_1  (
    .a(load_img_b[2]),
    .b(load_img_b[3]),
    .c(\wr_base_b[16]_syn_2 ),
    .o(wr_base_b[20]));
  AL_MAP_LUT5 #(
    .EQN("(~E*~(~D*~A*~(C*B)))"),
    .INIT(32'h0000ffea))
    \wr_base_b[7]_syn_1  (
    .a(\wr_base_b[13]_syn_2 ),
    .b(mux35_syn_96),
    .c(mux35_syn_84),
    .d(mux35_syn_79),
    .e(mux36_syn_20),
    .o(wr_base_b[7]));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*~B*~A)"),
    .INIT(16'h0001))
    \wr_base_b[9]_syn_1  (
    .a(load_state_reg_syn_1[0]),
    .b(load_state_reg_syn_1[1]),
    .c(load_state_reg_syn_1[2]),
    .d(load_state_reg_syn_1[3]),
    .o(mux36_syn_20));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*A)"),
    .INIT(8'h02))
    \wr_base_b[9]_syn_11  (
    .a(\wr_base_b[9]_syn_6 ),
    .b(failed[8]),
    .c(valid[7]),
    .o(\wr_base_b[9]_syn_12 ));
  AL_MAP_LUT4 #(
    .EQN("(~C*~(D*~(~B*A)))"),
    .INIT(16'h020f))
    \wr_base_b[9]_syn_13  (
    .a(\wanted_b[0]_syn_2 ),
    .b(\wr_base_b[9]_syn_12 ),
    .c(mux35_syn_84),
    .d(mux35_syn_92),
    .o(\wr_base_b[9]_syn_14 ));
  AL_MAP_LUT3 #(
    .EQN("(~C*~B*~A)"),
    .INIT(8'h01))
    \wr_base_b[9]_syn_15  (
    .a(\wr_base_b[9]_syn_10 ),
    .b(\wr_base_b[9]_syn_14 ),
    .c(mux36_syn_20),
    .o(wr_base_b[9]));
  AL_MAP_LUT4 #(
    .EQN("(~D*~C*B*A)"),
    .INIT(16'h0008))
    \wr_base_b[9]_syn_2  (
    .a(mux35_syn_88),
    .b(mux35_syn_96),
    .c(failed[7]),
    .d(valid[6]),
    .o(\wr_base_b[9]_syn_3 ));
  AL_MAP_LUT2 #(
    .EQN("(~B*~A)"),
    .INIT(4'h1))
    \wr_base_b[9]_syn_4  (
    .a(\wr_base_b[9]_syn_3 ),
    .b(mux35_syn_84),
    .o(\wanted[2]_syn_2 ));
  AL_MAP_LUT5 #(
    .EQN("(A*~(~E*~D*~C*B))"),
    .INIT(32'haaaaaaa2))
    \wr_base_b[9]_syn_5  (
    .a(mux35_syn_86),
    .b(mux35_syn_82),
    .c(mux35_syn_77),
    .d(failed[6]),
    .e(valid[5]),
    .o(\wr_base_b[9]_syn_6 ));
  AL_MAP_LUT2 #(
    .EQN("(~B*A)"),
    .INIT(4'h2))
    \wr_base_b[9]_syn_7  (
    .a(mux35_syn_96),
    .b(\wr_base_b[9]_syn_6 ),
    .o(\wr_base_b[9]_syn_8 ));
  AL_MAP_LUT3 #(
    .EQN("(C*~B*~A)"),
    .INIT(8'h10))
    \wr_base_b[9]_syn_9  (
    .a(\wanted[2]_syn_2 ),
    .b(\wr_base_b[9]_syn_8 ),
    .c(mux35_syn_92),
    .o(\wr_base_b[9]_syn_10 ));

endmodule 


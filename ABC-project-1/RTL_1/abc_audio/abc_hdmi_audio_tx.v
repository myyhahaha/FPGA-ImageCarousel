// HDMI audio/data-island path from the user-supplied C reference project.
// Static 800x600 / RGB / VIC 0 / 48 kHz; no mode switching or EDID dependency.
module abc_hdmi_audio_tx(
 input PXLCLK_I,PXLCLK_5X_I,RST_N,input VGA_HS,VGA_VS,VGA_DE,input[23:0]VGA_RGB,
 input AUDIO_VALID,input[23:0]AUDIO_LEFT,AUDIO_RIGHT,
 output HDMI_CLK_P,HDMI_D2_P,HDMI_D1_P,HDMI_D0_P,
 output HDMI_DDC_SCL,inout HDMI_DDC_SDA
);
 wire user,valid,last,ready,queued_valid;wire[23:0]data;wire[25:0]queued_data;wire overflow;
 wire acr_valid;wire[19:0]cts,n;wire[9:0]ch0,ch1,ch2,clk_word;
 abc_video_rgb_to_axis #(.HACTIVE(800))u_axis(.I_clk(PXLCLK_I),.I_rst(!RST_N),.I_vs(VGA_VS),.I_de(VGA_DE),.I_rgb(VGA_RGB),
  .O_video_user(user),.O_video_valid(valid),.O_video_last(last),.O_video_data(data));
 abc_video_axis_fifo u_queue(.clk(PXLCLK_I),.rst(!RST_N),.in_valid(valid),.in_data({user,last,data}),
  .out_valid(queued_valid),.out_data(queued_data),.out_ready(ready),.overflow(overflow));
 abc_acr_calc u_acr(.I_clk(PXLCLK_I),.I_rst(!RST_N),.I_audio_valid(AUDIO_VALID),.O_acr_valid(acr_valid),.O_acr_cts(cts),.O_acr_n(n));
 hdmi_1_4b_transmitter_core_wrapper #(.DEVICE("EG"),
  .HTOTAL(1056),.HSA(128),.HFP(40),.HBP(88),.HACTIVE(800),.VTOTAL(628),.VSA(4),.VFP(1),.VBP(23),.VACTIVE(600),
  .VIDEO_TPG("Disable"),.VIDEO_FORMAT("RGB"),.VIDEO_VIC(0),.AUDIO_SAMPLE_RATE("48K"),.IIC_SCL_DIV(250))u_core(
  .I_pixel_clk(PXLCLK_I),.I_rst(!RST_N),.I_edid_read_trig(1'b0),.O_edid_read_valid(),.O_edid_read_data(),
  .I_axis_s_user(queued_data[25]),.I_axis_s_valid(queued_valid),.I_axis_s_last(queued_data[24]),.I_axis_s_data(queued_data[23:0]),.O_axis_s_ready(ready),
  .I_audio_valid(AUDIO_VALID),.I_audio_left_data(AUDIO_LEFT),.I_audio_right_data(AUDIO_RIGHT),
  .I_acr_valid(acr_valid),.I_acr_cts(cts),.I_acr_n(n),.O_video_locked(),.O_ddc_scl(HDMI_DDC_SCL),.IO_ddc_sda(HDMI_DDC_SDA),
  .O_ch0_tmds_data(ch0),.O_ch1_tmds_data(ch1),.O_ch2_tmds_data(ch2),.O_clk_tmds_data(clk_word));
 abc_hdmi_phy_wrapper #(.DEVICE("EG"))u_phy(.I_pixel_clk(PXLCLK_I),.I_serial_clk(PXLCLK_5X_I),.I_rst(!RST_N),
  .I_tmds_channel_0(ch0),.I_tmds_channel_1(ch1),.I_tmds_channel_2(ch2),.I_tmds_channel_clk(clk_word),
  .O_tmds_ch0_p(HDMI_D0_P),.O_tmds_ch1_p(HDMI_D1_P),.O_tmds_ch2_p(HDMI_D2_P),.O_tmds_clk_p(HDMI_CLK_P));
endmodule

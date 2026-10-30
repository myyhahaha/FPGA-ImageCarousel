`timescale 1ns/1ps
// Board isolation pattern. The TF card, SDRAM, read packets and FIFO are
// bypassed. Keep the normal 40/200 MHz PLL, TMDS encoder and pin assignments.
module ab_video_diag_top(
 input sys_clk,key_next,key_prev,sw1_n,sw2_n,sw3_n,
 output SD_nCS,SD_DCLK,SD_MOSI,input SD_MISO,
 output HDMI_CLK_P,HDMI_D2_P,HDMI_D1_P,HDMI_D0_P,
 output HDMI_CLK_P1,HDMI_D2_P1,HDMI_D1_P1,HDMI_D0_P1,
 output[3:0]led,output VGA_HS,VGA_VS,output[7:0]VGA_R,VGA_G,VGA_B
);
 wire pixel_clk,pixel_clk_5x;
 clk_wize u_clk_wize(.refclk(sys_clk),.reset(1'b0),.clk0_out(pixel_clk_5x),.clk1_out(pixel_clk));
 reg[22:0]por_cnt=0;reg por=1;
 always @(posedge sys_clk)if(por_cnt==8388607)por<=0;else por_cnt<=por_cnt+1'b1;
 wire kn,kp;
 img_switch_ctrl u_keys(.clk(sys_clk),.rst(por),.key_next_n(key_next),.key_prev_n(key_prev),
 .sw1_n(1'b1),.sw2_n(1'b1),.sw3_n(1'b1),.display_valid(1'b1),.switch_done(1'b1),
 .disp_img(4'd1),.next_pressed(kn),.prev_pressed(kp),.auto_pressed());
 reg[1:0]requested_mode=0;
 always @(posedge sys_clk)if(por)requested_mode<=0;
 else if(kn)requested_mode<=requested_mode+1'b1;
 else if(kp)requested_mode<=requested_mode-1'b1;
 reg[1:0]mode_s1=0,mode_s2=0,mode=0;
 reg[10:0]h=0,v=0;
 always @(posedge pixel_clk)begin
  mode_s1<=requested_mode;mode_s2<=mode_s1;
  if(por)begin h<=0;v<=0;mode<=0;end
  else begin
   if(h==1055)begin h<=0;if(v==627)v<=0;else v<=v+1'b1;end else h<=h+1'b1;
   if(h==0 && v==601)mode<=mode_s2;
  end
 end
 function[11:0]pattern;
 input[1:0]which;input integer sx,sy;
 integer x,y,index;reg[3:0]gray;
 begin
  pattern=0;x=sx-80;y=sy-60;
  if(sx>=8 && sx<32 && sy>=8 && sy<32)
   case(which)0:pattern=12'hff0;1:pattern=12'h0ff;2:pattern=12'hf0f;default:pattern=12'h0f0;endcase
  else if(x>=0 && x<640 && y>=0 && y<480)case(which)
   0,3:begin
    // Exact source IMAGE5 color-bar coordinates, plus thin white geometry.
    if(y>=290 && y<430)begin
     if(x>=48 && x<112)pattern=12'hf00;
     else if(x>=126 && x<190)pattern=12'h0f0;
     else if(x>=204 && x<268)pattern=12'h00f;
     else if(x>=282 && x<346)pattern=12'hff0;
     else if(x>=360 && x<424)pattern=12'hf0f;
     else if(x>=438 && x<502)pattern=12'h0ff;
     else if(x>=516 && x<580)pattern=12'hfff;
    end
    if(x>=48 && x<=580 && (y==80 || y==120 || y==160 || y==200))pattern=12'hfff;
    if(y>=60 && y<=220 && (x==48 || x==112 || x==192 || x==320 || x==448 || x==580))pattern=12'hfff;
   end
   1:pattern=(x[5]^y[5]) ? 12'h000:12'hfff;
   default:begin
    gray=0;
    for(index=1;index<16;index=index+1)if(x>=index*40-1)gray=index;
    pattern={gray,gray,gray};
   end
  endcase
 end
 endfunction
 reg de=0,hs=0,vs=0;reg[11:0]rgb=0;
 always @(posedge pixel_clk)begin
  if(por)begin de<=0;hs<=0;vs<=0;rgb<=0;end
  else begin
   de<=h<800 && v<600;hs<=h>=840 && h<968;vs<=v>=601 && v<605;
   rgb<=h<800 && v<600 ? pattern(mode,h,v):12'd0;
  end
 end
 // Fourth pattern repeats the same bars with full 0..255 channel range.
 // Compare it with mode 0 to isolate color-level / output-link behavior.
 assign VGA_R=mode==3 ? {rgb[11:8],rgb[11:8]}:{rgb[11:8],4'b0};
 assign VGA_G=mode==3 ? {rgb[7:4],rgb[7:4]}:{rgb[7:4],4'b0};
 assign VGA_B=mode==3 ? {rgb[3:0],rgb[3:0]}:{rgb[3:0],4'b0};
 assign VGA_HS=hs;assign VGA_VS=vs;
 hdmi_tx #(.FAMILY("EG4")) u_tx(.PXLCLK_I(pixel_clk),.PXLCLK_5X_I(pixel_clk_5x),.RST_N(!por),
 .VGA_HS(hs),.VGA_VS(vs),.VGA_DE(de),.VGA_RGB({VGA_R,VGA_G,VGA_B}),
 .HDMI_CLK_P(HDMI_CLK_P),.HDMI_D2_P(HDMI_D2_P),.HDMI_D1_P(HDMI_D1_P),.HDMI_D0_P(HDMI_D0_P));
 assign HDMI_CLK_P1=HDMI_CLK_P;assign HDMI_D2_P1=HDMI_D2_P;assign HDMI_D1_P1=HDMI_D1_P;assign HDMI_D0_P1=HDMI_D0_P;
 assign {SD_nCS,SD_DCLK,SD_MOSI}=3'b101;
 assign led={2'b10,requested_mode};
endmodule

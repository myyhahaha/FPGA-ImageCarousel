`timescale 1ns/1ps
// Power-on elapsed time plus frame-atomic fractional-pixel ticker state.
module ab_osd_clock #(parameter CLK_HZ=40000000,SCROLL_STEP_Q2=2)(
 input clk,reset_n,frame_blank,enable,output reg[10:0]scroll_q2,output reg[27:0]frame_bcd
);
 localparam CW=$clog2(CLK_HZ);
 reg[CW-1:0]subsecond;
 reg[27:0]elapsed_bcd;
 always @(posedge clk or negedge reset_n)begin
  if(!reset_n)begin subsecond<=0;elapsed_bcd<=0;scroll_q2<=0;frame_bcd<=0;end
  else if(!enable)begin subsecond<=0;elapsed_bcd<=0;scroll_q2<=0;frame_bcd<=0;end
  else begin
   if(subsecond==CLK_HZ-1)begin
    subsecond<=0;
    // HHH:MM:SS, saturating after 999:59:59 rather than wrapping to zero.
    if(elapsed_bcd!=28'h9995959)begin
     if(elapsed_bcd[3:0]!=9)elapsed_bcd[3:0]<=elapsed_bcd[3:0]+1'b1;
     else begin elapsed_bcd[3:0]<=0;
      if(elapsed_bcd[7:4]!=5)elapsed_bcd[7:4]<=elapsed_bcd[7:4]+1'b1;
      else begin elapsed_bcd[7:4]<=0;
       if(elapsed_bcd[11:8]!=9)elapsed_bcd[11:8]<=elapsed_bcd[11:8]+1'b1;
       else begin elapsed_bcd[11:8]<=0;
        if(elapsed_bcd[15:12]!=5)elapsed_bcd[15:12]<=elapsed_bcd[15:12]+1'b1;
        else begin elapsed_bcd[15:12]<=0;
         if(elapsed_bcd[19:16]!=9)elapsed_bcd[19:16]<=elapsed_bcd[19:16]+1'b1;
         else begin elapsed_bcd[19:16]<=0;
          if(elapsed_bcd[23:20]!=9)elapsed_bcd[23:20]<=elapsed_bcd[23:20]+1'b1;
          else begin elapsed_bcd[23:20]<=0;elapsed_bcd[27:24]<=elapsed_bcd[27:24]+1'b1;end
         end
        end
       end
      end
     end
    end
   end else subsecond<=subsecond+1'b1;
   if(frame_blank)begin
    frame_bcd<=elapsed_bcd;
    if(scroll_q2+SCROLL_STEP_Q2>=1728)scroll_q2<=scroll_q2+SCROLL_STEP_Q2-1728;
    else scroll_q2<=scroll_q2+SCROLL_STEP_Q2;
   end
  end
 end
endmodule

// Synchronize the committed-image flag and release the presentation only at
// the first pixel of a complete frame. Once started, loading later images
// cannot hide the OSD or restart its clock.
module ab_video_start(input clk,reset_n,image_ready_async,frame_begin,output presenting);
 reg ready_s1,ready_s2,started;
 always @(posedge clk or negedge reset_n)begin
  if(!reset_n)begin ready_s1<=0;ready_s2<=0;started<=0;end
  else begin
   ready_s1<=image_ready_async;ready_s2<=ready_s1;
   if(ready_s2 && frame_begin)started<=1;
  end
 end
 assign presenting=started || (ready_s2 && frame_begin);
endmodule

// Three ordered alpha layers: translucent panel, accents, antialiased text.
// Coverage ROM reads and three blending stages give four clocks of latency.
module ab_osd_engine(
 input clk,reset_n,visible,input[23:0]in_rgb,input in_de,in_hs,in_vs,input[10:0]in_x,in_y,
 input[10:0]scroll_q2,input[27:0]frame_bcd,input[9:0]wave_levels,
 output reg[23:0]out_rgb,output out_de,out_hs,out_vs,output[10:0]out_x,out_y
);
 function[7:0]mix8;
 input[7:0]bg,fg;input[4:0]a;
 reg signed[8:0]delta;reg signed[14:0]product,total;
 begin
  delta=$signed({1'b0,fg})-$signed({1'b0,bg});
  product=delta*$signed({1'b0,a});
  total=$signed({3'b0,bg,4'b0})+product+15'sd8;
  mix8=total[11:4];
 end endfunction
 function[23:0]blend;
 input[23:0]bg,fg;input[4:0]a;
 begin blend={mix8(bg[23:16],fg[23:16],a),mix8(bg[15:8],fg[15:8],a),mix8(bg[7:0],fg[7:0],a)};end endfunction
 function[4:0]coverage;input[3:0]v;
 begin coverage=v==15 ? 5'd16:{1'b0,v};end endfunction
 function caption_bit;
 input[3:0]letter;input[2:0]row,col;reg[34:0]bits;
 begin
  case(letter)
   0:bits={5'b11111,5'b00100,5'b00100,5'b00100,5'b00100,5'b00100,5'b00100}; // T
   1:bits={5'b11111,5'b10000,5'b10000,5'b11110,5'b10000,5'b10000,5'b11111}; // E
   2:bits={5'b01110,5'b10001,5'b10001,5'b11111,5'b10001,5'b10001,5'b10001}; // A
   3:bits={5'b10001,5'b11011,5'b10101,5'b10101,5'b10001,5'b10001,5'b10001}; // M
   4:bits={5'b11110,5'b10001,5'b10001,5'b11110,5'b10100,5'b10010,5'b10001}; // R
   5:bits={5'b10001,5'b10001,5'b10001,5'b10001,5'b10001,5'b10001,5'b01110}; // U
   6:bits={5'b10001,5'b11001,5'b11001,5'b10101,5'b10011,5'b10011,5'b10001}; // N
   7:bits={5'b11111,5'b00100,5'b00100,5'b00100,5'b00100,5'b00100,5'b11111}; // I
   8:bits={5'b10000,5'b10000,5'b10000,5'b10000,5'b10000,5'b10000,5'b11111}; // L
   default:bits=0;
  endcase
  caption_bit=bits[34-row*5-col];
 end endfunction
 function[3:0]left_letter;input integer slot;
 begin case(slot)0:left_letter=0;1:left_letter=7;2:left_letter=0;3:left_letter=8;default:left_letter=1;endcase end endfunction
 function[3:0]right_letter;input integer slot;
 begin case(slot)0:right_letter=4;1:right_letter=5;2:right_letter=6;3:right_letter=15;
 4:right_letter=0;5:right_letter=7;6:right_letter=3;default:right_letter=1;endcase end endfunction
 function[3:0]time_glyph;input integer slot;input[27:0]value;
 begin case(slot)
 0:time_glyph=value[27:24];1:time_glyph=value[23:20];2:time_glyph=value[19:16];3:time_glyph=10;
 4:time_glyph=value[15:12];5:time_glyph=value[11:8];6:time_glyph=10;7:time_glyph=value[7:4];default:time_glyph=value[3:0];endcase end endfunction
 reg[8:0]zh_address;reg[7:0]digit_address;
 wire[99:0]zh_row;wire[47:0]digit_row;
 ab_osd_font_zh u_zh(.clk(clk),.address(zh_address),.row(zh_row));
 ab_osd_font_digits u_digits(.clk(clk),.address(digit_address),.row(digit_row));
 integer x,y,ty,source_a,source_b,i,chosen_address,fade_distance;
 reg panel;reg[4:0]dec_alpha,simple_alpha,fade_factor;
 reg[23:0]dec_color,ink_color,matte_color;
 reg[2:0]kind;reg va,vb,dot_a,dot_b,digit_valid;
 reg[4:0]col_a,col_b;reg[3:0]digit_col;
 always @* begin
  x=in_x;y=in_y;ty=y+540;zh_address=0;digit_address=0;panel=0;dec_alpha=0;dec_color=0;
  kind=0;va=0;vb=0;dot_a=0;dot_b=0;digit_valid=0;col_a=0;col_b=0;digit_col=0;
  simple_alpha=0;fade_factor=16;ink_color=24'hd8dedb;
  matte_color=24'h16191b;
  if(y<44)matte_color=24'h1d2023;else if(y<48)matte_color=24'h1b1e21;else if(y<52)matte_color=24'h191c1f;else if(y<56)matte_color=24'h171a1d;
  if(y>=544)matte_color=24'h171a1d;
  if(y>=548)matte_color=24'h191c1f;
  if(y>=552)matte_color=24'h1b1e21;
  if(y>=556)matte_color=24'h1d2023;
  source_a=0;source_b=0;chosen_address=0;fade_distance=0;
  if(in_de)begin
   // One neutral matte surrounds the image on all four sides. The
   // footer lifts by only a few luminance levels, without a boxed panel.
   panel=x<80 || x>=720 || y<60 || y>=540;
   if(y==52 && x>=100 && x<680)begin dec_color=24'h718080;dec_alpha=2;end
   if(x==520 && y>=17 && y<45)begin dec_color=24'h8d9394;dec_alpha=3;end
   if(x>=702 && x<=706 && y>=32 && y<=36 && !((x==702 || x==706)&&(y==32 || y==36)))begin
    dec_color=24'h9bafa5;dec_alpha=frame_bcd[0] ? 8:12;
   end
   if(y==574 && x>=80 && x<720)begin dec_color=24'h657275;dec_alpha=3;end
   if(y<60)begin
   if(ty>=551 && ty<558)begin
    ink_color=24'h8f999e;kind=3;
    for(i=0;i<5;i=i+1)if(x>=100+i*6 && x<105+i*6)
     if(caption_bit(left_letter(i),ty-551,x-100-i*6))simple_alpha=10;
    for(i=0;i<8;i=i+1)if(x>=552+i*6 && x<557+i*6)
     if(caption_bit(right_letter(i),ty-551,x-552-i*6))simple_alpha=10;
   end
   if(x>=100 && x<496 && ty>=563 && ty<587)begin
    kind=1;source_a=x-100+scroll_q2[10:2];
    if(source_a>=432)source_a=source_a-432;
    // Each 25-pixel ROM row holds 24 pixels plus the first pixel of
    // the next tile, preserving smooth fractional scrolling at seams.
    for(i=0;i<18;i=i+1)begin
     if(source_a>=i*24 && source_a<i*24+24)begin
      va=1;vb=1;col_a=source_a-i*24;col_b=source_a-i*24+1;
      chosen_address=i*24+ty-563;
     end
    end
    zh_address=chosen_address;
    source_b=source_a==431 ? 0:source_a+1;
    dot_a=source_a>=390 && source_a<=394 && ty>=573 && ty<=577 && !((source_a==390 || source_a==394)&&(ty==573 || ty==577));
    dot_b=source_b>=390 && source_b<=394 && ty>=573 && ty<=577 && !((source_b==390 || source_b==394)&&(ty==573 || ty==577));
    if(dot_a || dot_b)ink_color=24'ha8b6af;
    fade_distance=x-100;if(495-x<fade_distance)fade_distance=495-x;
    fade_factor=fade_distance>=16 ? 16:fade_distance;
   end
   if(ty>=565 && ty<585)for(i=0;i<9;i=i+1)if(x>=552+i*14 && x<564+i*14)begin
    kind=2;ink_color=24'hbac3c4;digit_valid=1;digit_col=x-552-i*14;
    digit_address=time_glyph(i,frame_bcd)*20+ty-565;
   end
   end
   if(x>=80 && x<720 && y>=552 && y<592)begin kind=4;ink_color=24'h91b4ad;end

  end
 end
 reg[23:0]rgb0,panel_rgb,decor_rgb,dc0,dc1,ic0,ic1,ic2,matte0;
 reg p0,va0,vb0,da0,db0,dv0;reg[2:0]kind0;reg[1:0]frac0;reg signed[6:0]wave_dy0;
 reg[4:0]ca0,cb0,fade0,sa0,dec0,dec1,ink1,ink2;reg[3:0]dcol0;
 reg[3:0]de_pipe,hs_pipe,vs_pipe,visible_pipe;reg[10:0]xp[0:3],yp[0:3];
 integer wave_y,wave_upper,wave_lower;
 reg[4:0]cov_a,cov_b,cov_mix,ink_alpha;reg[7:0]interpolation;reg[9:0]fade_product;
 always @* begin
  cov_a=da0 ? 16:(va0 ? coverage(zh_row[ca0*4+:4]):5'd0);
  cov_b=db0 ? 16:(vb0 ? coverage(zh_row[cb0*4+:4]):5'd0);
  interpolation=cov_a*(3'd4-{1'b0,frac0})+cov_b*{1'b0,frac0}+8'd2;
  cov_mix=interpolation>>2;fade_product=cov_mix*fade0+10'd8;
  wave_y=$signed(wave_dy0);wave_upper=wave_levels[9:5];wave_lower=wave_levels[4:0];
  ink_alpha=0;
  case(kind0)
   1:ink_alpha=fade_product>>4;
   2:ink_alpha=dv0 ? coverage(digit_row[dcol0*4+:4]):5'd0;
   3:ink_alpha=sa0;
   4:if(wave_levels!=0 && wave_y>=-wave_upper && wave_y<=wave_lower)
      ink_alpha=(wave_y==-wave_upper || wave_y==wave_lower) ? 14:5;
   default:ink_alpha=0;
  endcase
 end
 integer n;
 always @(posedge clk or negedge reset_n)begin
  if(!reset_n)begin
   wave_dy0<=0;rgb0<=0;panel_rgb<=0;decor_rgb<=0;out_rgb<=0;matte0<=0;dc0<=0;dc1<=0;ic0<=0;ic1<=0;ic2<=0;
   p0<=0;va0<=0;vb0<=0;da0<=0;db0<=0;dv0<=0;kind0<=0;frac0<=0;ca0<=0;cb0<=0;dcol0<=0;
   fade0<=0;sa0<=0;dec0<=0;dec1<=0;ink1<=0;ink2<=0;de_pipe<=0;hs_pipe<=0;vs_pipe<=0;visible_pipe<=0;
   for(n=0;n<4;n=n+1)begin xp[n]<=0;yp[n]<=0;end
  end else begin
   wave_dy0<=$signed({1'b0,in_y})-12'sd574;rgb0<=in_rgb;p0<=panel;matte0<=matte_color;dc0<=dec_color;dec0<=dec_alpha;ic0<=ink_color;
   kind0<=kind;va0<=va;vb0<=vb;da0<=dot_a;db0<=dot_b;dv0<=digit_valid;
   ca0<=col_a;cb0<=col_b;dcol0<=digit_col;fade0<=fade_factor;sa0<=simple_alpha;frac0<=scroll_q2[1:0];
   panel_rgb<=blend(rgb0,matte0,p0 ? 5'd12:5'd0);
   ink1<=ink_alpha;ic1<=ic0;dc1<=dc0;dec1<=dec0;
   decor_rgb<=blend(panel_rgb,dc1,dec1);ink2<=ink1;ic2<=ic1;
   out_rgb<=(de_pipe[2] && visible_pipe[2]) ? blend(decor_rgb,ic2,ink2):24'd0;
   visible_pipe<={visible_pipe[2:0],visible};
   de_pipe<={de_pipe[2:0],in_de};hs_pipe<={hs_pipe[2:0],in_hs};vs_pipe<={vs_pipe[2:0],in_vs};
   xp[0]<=in_x;yp[0]<=in_y;
   for(n=1;n<4;n=n+1)begin xp[n]<=xp[n-1];yp[n]<=yp[n-1];end
  end
 end
 assign out_de=de_pipe[3];assign out_hs=hs_pipe[3];assign out_vs=vs_pipe[3];
 assign out_x=xp[3];assign out_y=yp[3];
endmodule

module ab_osd_overlay #(parameter CLK_HZ=40000000)(
 input clk,reset_n,frame_blank,enable,audio_valid,input[15:0]audio_pcm,input[23:0]in_rgb,input in_de,in_hs,in_vs,input[10:0]in_x,in_y,
 output[23:0]out_rgb,output out_de,out_hs,out_vs,output[10:0]out_x,out_y
);
 wire[10:0]scroll_q2;wire[27:0]frame_bcd;
 wire[9:0]wave_levels;wire[9:0]wave_column=(in_x>=80 && in_x<720)?in_x-80:0;
 abc_audio_waveform u_wave(.clk(clk),.rst(!reset_n),.frame_blank(frame_blank),.sample_valid(audio_valid),.sample(audio_pcm),.read_column(wave_column),.levels(wave_levels));
 ab_osd_clock #(.CLK_HZ(CLK_HZ))u_time(.clk(clk),.reset_n(reset_n),.frame_blank(frame_blank),.enable(enable),.scroll_q2(scroll_q2),.frame_bcd(frame_bcd));
 ab_osd_engine u_engine(.clk(clk),.reset_n(reset_n),.visible(enable),.in_rgb(in_rgb),.in_de(in_de),.in_hs(in_hs),.in_vs(in_vs),
 .in_x(in_x),.in_y(in_y),.scroll_q2(scroll_q2),.frame_bcd(frame_bcd),.wave_levels(wave_levels),.out_rgb(out_rgb),.out_de(out_de),.out_hs(out_hs),.out_vs(out_vs),.out_x(out_x),.out_y(out_y));
endmodule

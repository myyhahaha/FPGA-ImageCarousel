`timescale 1ns/1ps
// Synthesized HDMI netlist including all three encoders and vendor serializers.
// Only pad DDR behavior is a functional model; receive the actual serial pins.
module tb_hdmi_output;
 `include "ab_verify/osd_golden.svh"
 `include "ab_verify/brightness_golden.svh"
 reg clk=0,clk5=0,rst=0,brup=1,brdown=1;always #12.5 clk=~clk;always #2.5 clk5=~clk5;
 wire pcm_read;integer pcm_pos=0;wire[15:0]pcm_value=(pcm_pos*7919)^16'ha53c;
 always @(posedge clk)if(pcm_read)pcm_pos<=pcm_pos+1;
 wire rd,fs,ck,dr,dg,db,hs,vs;wire[7:0]r,g,b;
 integer index=0,image_id=1,cycle=0,frames=0,checked_vga=0,checked_serial=0,checked_control=0,j;
 reg [11:0] pixels[0:8*307200-1];
 initial $readmemh("ab_verify/results/bmp_pixels.hex",pixels);
 function [11:0] pixel;input integer img,n;integer x,y;
 begin x=n%800;y=n/800;pixel=0;
  if(x>=80 && x<720 && y>=60 && y<540)pixel=pixels[(img-1)*307200+(539-y)*640+x-80];
 end
 endfunction
 wire[23:0]data={pixel(image_id,index*2+1),pixel(image_id,index*2)};
 hdmi_top dut(.PXLCLK_I(clk),.PXLCLK_5X_I(clk5),.RST_I(rst),.DISPLAY_READY(1'b1),.CONTROLS_READY(1'b1),.KEY_BRIGHTER_N(brup),.KEY_DIMMER_N(brdown),
 .PCM_DOUT(pcm_value),.PCM_EMPTY(1'b0),.PCM_LEVEL(13'd4096),.PCM_RD_EN(pcm_read),.FIFO_DOUT(data),.FIFO_EMPTY(1'b0),.DBG_PIX(12'd0),.DBG_VAL(20'd0),.FIFO_RD_EN(rd),.FRAME_START(fs),
 .VGA_R(r),.VGA_G(g),.VGA_B(b),.VGA_HS(hs),.VGA_VS(vs),
 .HDMI_CLK_P(ck),.HDMI_D2_P(dr),.HDMI_D1_P(dg),.HDMI_D0_P(db));
 reg[23:0]hist[0:31];reg de_hist[0:31];reg[1:0]ctl_hist[0:31];
 integer bright_pixels=0,restored_pixels=0;
 integer x,y,p,reference_x=0,reference_y=0,reference_frame=0,shown_vga=0,hidden_vga=0;reg[11:0]e;reg[23:0]expected_rgb;
 reg[11:0]base_history[0:4];integer x_history[0:4],y_history[0:4];reg valid_history[0:4];integer frame_history[0:4];
 initial for(p=0;p<5;p=p+1)begin base_history[p]=0;x_history[p]=0;y_history[p]=0;valid_history[p]=0;frame_history[p]=0;end
 always @(posedge clk)begin
   // Synthesis may merge individual counter bits into differently named
   // coordinate registers. Count the 1056x628 raster independently instead
   // of observing a partially optimized internal hcnt/vcnt net.
   x=reference_x;y=reference_y;
   if(!rst)begin reference_x=0;reference_y=0;reference_frame=0;end
   else if(reference_x==1055)begin reference_x=0;if(reference_y==627)begin reference_y=0;reference_frame=reference_frame+1;end else reference_y=reference_y+1;end
   else reference_x=reference_x+1;
   if(rst && rd!==(x<800 && y<600 && x%2==1))$fatal(1,"FIFO read phase changed");
   if(!rst)index<=0;
   else if(fs)begin
    index<=0;
    if(reference_frame>0)begin
     if(image_id<8)image_id<=image_id+1;
     frames<=frames+1;
    end
   end
   else if(rd)index<=index+1;
   for(p=4;p>0;p=p-1)begin base_history[p]=base_history[p-1];x_history[p]=x_history[p-1];y_history[p]=y_history[p-1];valid_history[p]=valid_history[p-1];frame_history[p]=frame_history[p-1];end
   base_history[0]=pixel(image_id,y*800+x);x_history[0]=x;y_history[0]=y;valid_history[0]=rst;frame_history[0]=reference_frame;
   #1;
   e=base_history[4];x=x_history[4];y=y_history[4];
   if(valid_history[4] && x<800 && y<600)begin
    expected_rgb=gold_osd(x,y,gold_brightness(e,(frame_history[4]>=3 && frame_history[4]<7)?5:4),dut.\u_osd/u_time/scroll_q2 ,dut.\u_osd/u_time/frame_bcd ,1'b1);
    if(frame_history[4]==0)begin expected_rgb=0;hidden_vga=hidden_vga+1;end else shown_vga=shown_vga+1;
    if(!(x>=80 && x<720 && y>=552 && y<592) && {r,g,b}!==expected_rgb)$fatal(1,"mapped VGA+OSD pixel img=%0d x=%0d y=%0d got=%h expected=%h",image_id,x,y,{r,g,b},expected_rgb);
    if(x>=80 && x<720 && y>=60 && y<540)begin
     if(frame_history[4]>=3 && frame_history[4]<7)bright_pixels=bright_pixels+1;
     if(frame_history[4]>=7)restored_pixels=restored_pixels+1;
    end
    checked_vga=checked_vga+1;
   end
   for(j=31;j>0;j=j-1)begin hist[j]=hist[j-1];de_hist[j]=de_hist[j-1];ctl_hist[j]=ctl_hist[j-1];end
   hist[0]={r,g,b};de_hist[0]=valid_history[4] && x<800 && y<600;ctl_hist[0]={vs,hs};cycle=cycle+1;
 end

 function[9:0]reverse10;input[9:0]a;integer n;begin for(n=0;n<10;n=n+1)reverse10[n]=a[9-n];end endfunction
 wire[9:0]c0=reverse10(dut.\u3_hdmi_tx/u_phy/u0_lane_lvds_8_1/I_data_in );
 wire[9:0]c1=reverse10(dut.\u3_hdmi_tx/u_phy/u1_lane_lvds_8_1/I_data_in );
 wire[9:0]c2=reverse10(dut.\u3_hdmi_tx/u_phy/u2_lane_lvds_8_1/I_data_in );
 reg[29:0]word_hist[0:7];integer h;
 reg[23:0]video_queue[0:4999999];integer video_in=0,video_out=0,video_compared=0,video_skip=0;
 reg in_video=0,in_island=0;integer vg=0,ig=0,pre=0,part=0,packets=0,audio_packets=0,acr_packets=0,info_packets=0,sample_out=0,audio_in=0;
 reg[23:0]input_sample=0;reg[23:0]audio_queue[0:19999];reg[31:0]header=0;reg[63:0]sub[0:3];integer tc0,tc1,tc2,q,n,ec,checksum,cts_value,n_value;
 reg[23:0]decoded;reg[23:0]expected_sample;
 function[7:0]decode;input[9:0]q;reg[7:0]m;integer n;begin m=q[7:0]^{8{q[9]}};decode[0]=m[0];for(n=1;n<8;n=n+1)decode[n]=m[n]^m[n-1]^~q[8];end endfunction
 function integer terc;input[9:0]q;begin case(q)
  10'h29c:terc=0;10'h263:terc=1;10'h2e4:terc=2;10'h2e2:terc=3;
  10'h171:terc=4;10'h11e:terc=5;10'h18e:terc=6;10'h13c:terc=7;
  10'h2cc:terc=8;10'h139:terc=9;10'h19c:terc=10;10'h2c6:terc=11;
  10'h28e:terc=12;10'h271:terc=13;10'h163:terc=14;10'h2c3:terc=15;default:terc=-1;endcase end endfunction
 function ctrl;input[9:0]q;begin ctrl=(q==10'h354 || q==10'h0ab || q==10'h154 || q==10'h2ab);end endfunction
 function[7:0]ecc;input[63:0]v;input integer bits;integer n;reg[7:0]c;begin c=0;for(n=0;n<bits;n=n+1)c=(c>>1)^((c[0]^v[n])?8'h83:8'h00);ecc=c;end endfunction
 always @(posedge clk)begin
  if(rst && dut.\u3_hdmi_tx/AUDIO_VALID )begin
   audio_queue[audio_in]=input_sample;audio_in=audio_in+1;
  end
  if(pcm_read)input_sample={pcm_value,8'd0};
  #1.2;
  if(rst && de_hist[0])begin video_queue[video_in]={r,g,b};video_in=video_in+1;end
  for(h=7;h>0;h=h-1)word_hist[h]=word_hist[h-1];word_hist[0]={c2,c1,c0};
  if(rst && cycle>30)begin
   if(in_video)begin
    if(ctrl(c0))in_video=0;
    else begin
     decoded={decode(c2),decode(c1),decode(c0)};
     // The core may discard initial input frames while acquiring SOF. Once
     // a nonblack frame is aligned, every subsequent active pixel is exact.
     if(video_compared==0 && decoded!=video_queue[video_out])begin
      video_skip=0;
      while(video_out<video_in && decoded!=video_queue[video_out] && video_skip<960000)begin video_out=video_out+1;video_skip=video_skip+1;end
     end
     if(video_out>=video_in || decoded!==video_queue[video_out])$fatal(1,"HDMI video order out=%0d in=%0d got%h exp%h",video_out,video_in,decoded,video_queue[video_out]);
     video_out=video_out+1;video_compared=video_compared+1;
    end
   end else if(in_island)begin
    if(c1==10'h133 && c2==10'h133)begin
     if(part!=0)$fatal(1,"truncated HDMI packet %0d",part);in_island=0;
    end else begin
     tc0=terc(c0);tc1=terc(c1);tc2=terc(c2);
     if(tc0<0 || tc1<0 || tc2<0)$fatal(1,"invalid TERC4");
     header[part]=(tc0>>2)&1;
     for(q=0;q<4;q=q+1)begin sub[q][part*2]=(tc1>>q)&1;sub[q][part*2+1]=(tc2>>q)&1;end
     if(part==31)begin
      if(ecc({32'd0,header},32)!=0)$fatal(1,"header BCH error %h",header);
      for(q=0;q<4;q=q+1)if(ecc(sub[q],64)!=0)$fatal(1,"payload BCH error");
      packets=packets+1;
      if(header[7:0]==2)begin
       audio_packets=audio_packets+1;
       for(q=0;q<4;q=q+1)if(header[8+q])begin
        expected_sample=audio_queue[sample_out];
        if(sub[q][23:0]!==expected_sample || sub[q][47:24]!==expected_sample)$fatal(1,"HDMI PCM %0d block%0d got%h/%h expected%h head%h",sample_out,q,sub[q][23:0],sub[q][47:24],expected_sample,header);
        if(^{sub[q][23:0],sub[q][51:48]} || ^{sub[q][47:24],sub[q][55:52]})$fatal(1,"IEC60958 parity");
        sample_out=sample_out+1;
       end
      end else if(header[7:0]==1)begin
       acr_packets=acr_packets+1;
       n_value={sub[0][35:32],sub[0][47:40],sub[0][55:48]};
       cts_value={sub[0][11:8],sub[0][23:16],sub[0][31:24]};
       if(n_value!=6144 || (cts_value!=40000 && cts_value!=40001))$fatal(1,"ACR N%0d CTS%0d",n_value,cts_value);
       for(q=1;q<4;q=q+1)if(sub[q]!==sub[0])$fatal(1,"ACR repeated subpacket");
      end else if(header[7:0]==8'h82 || header[7:0]==8'h84)begin
       info_packets=info_packets+1;checksum=header[7:0]+header[15:8]+header[23:16];
       for(n=0;n<=header[23:16];n=n+1)checksum=checksum+sub[n/7][(n%7)*8+:8];
       if(checksum%256!=0)$fatal(1,"HDMI InfoFrame checksum %h",header);
      end
      part=0;
     end else part=part+1;
    end
   end else begin
    if(c0==10'h2cc && c1==10'h133 && c2==10'h2cc)begin
     vg=vg+1;if(vg==2)begin in_video=1;vg=0;end
    end else vg=0;
    if(ctrl(c0) && c1==10'h0ab && c2==10'h0ab)pre=pre+1;
    else if(c1==10'h133 && c2==10'h133 && pre>=8)begin
     ig=ig+1;if(ig==2)begin in_island=1;part=0;ig=0;pre=0;end
    end else begin pre=0;ig=0;end
   end
  end
 end


 reg[9:0]cw=0,rw=0,gw=0,bw=0;integer serial_ok=0,serial_bad=0,d,edge_number=0,phase,good[0:79],bad[0:79],chosen=-1,best=0;
 initial for(d=0;d<80;d=d+1)begin good[d]=0;bad[d]=0;end
 always @(clk5)begin
  #0.2;cw={ck,cw[9:1]};rw={dr,rw[9:1]};gw={dg,gw[9:1]};bw={db,bw[9:1]};
  edge_number=edge_number+1;phase=edge_number%10;
  if(cycle>100 && chosen<0)begin
   for(d=0;d<8;d=d+1)begin
    if({rw,gw,bw}===word_hist[d])good[phase*8+d]=good[phase*8+d]+1;else bad[phase*8+d]=bad[phase*8+d]+1;
   end
   if(cycle>=100000)begin
    for(d=0;d<80;d=d+1)if(good[d]>best)begin chosen=d;best=good[d];end
    if(chosen<0 || bad[chosen]!=0)$fatal(1,"No exact serial phase/delay calibration");
    serial_ok=good[chosen];
   end
  end else if(chosen>=0 && phase==chosen/8)begin
   if({rw,gw,bw}!==word_hist[chosen%8])$fatal(1,"fixed serial word alignment changed");
   serial_ok=serial_ok+1;
  end
 end
 initial begin
  wait(rst);wait(reference_frame==1);@(negedge clk);brup=0;
  repeat(1200000)@(negedge clk);brup=1;
  wait(reference_frame==5);@(negedge clk);brdown=0;
  repeat(1200000)@(negedge clk);brdown=1;
 end
 initial begin
  for(j=0;j<640;j=j+1)gold_wave[j]=0;
  #100;rst=1;wait(frames==9);repeat(20)@(posedge clk);
  if(video_compared<6*480000 || sample_out<5000 || audio_packets<1000 || acr_packets<50 || info_packets<5 || serial_bad>5 || serial_ok<4000000)$fatal(1,"HDMI coverage video%0d samples%0d ASP%0d ACR%0d info%0d serial%0d/%0d packets%0d",video_compared,sample_out,audio_packets,acr_packets,info_packets,serial_ok,serial_bad,packets);
  if(bright_pixels<4*307200 || restored_pixels<3*307200)$fatal(1,"mapped brightness coverage %0d/%0d",bright_pixels,restored_pixels);
  $display("PASS mapped K3/K4: real 20ms debounce, %0d brightened picture pixels and %0d restored picture pixels; OSD and serialized HDMI checked",bright_pixels,restored_pixels);
  $display("PASS HDMI music output: %0d exact regenerated RGB pixels, %0d ordered 24-bit stereo PCM samples, %0d audio packets, %0d ACR packets, %0d infoframes, %0d packet BCH blocks, %0d pin serializer words",video_compared,sample_out,audio_packets,acr_packets,info_packets,packets*5,serial_ok);$finish;
 end
 initial begin #220000000;$fatal(1,"HDMI test timeout");end
endmodule

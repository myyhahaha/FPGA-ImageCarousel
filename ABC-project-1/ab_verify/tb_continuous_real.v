`timescale 1ns/1ps
module tb_continuous_real;
 `include "ab_verify/osd_golden.svh"
 `include "ab_verify/brightness_golden.svh"
 `include "ab_verify/startup_monitor.svh"
 // Deliberately hold all keys and enable automatic mode throughout startup.
 reg sys_clk=0,kn=0,kp=0,sw1=0,brup=0,brdown=0;
 always #10 sys_clk=~sys_clk;
 wire [7:0] r,g,b;
 abc_hdmi_top #(.POR_CYCLES(10),.DEBOUNCE_CYCLES(3),.BRIGHTNESS_DEBOUNCE_CYCLES(4)) dut(
 .sys_clk(sys_clk),.key_next(kn),.key_prev(kp),.key_brighter(brup),.key_dimmer(brdown),.sw1_n(sw1),.sw2_n(1'b1),.sw3_n(1'b1),.sw4_n(1'b1),
 .SD_MISO(1'b1),.VGA_R(r),.VGA_G(g),.VGA_B(b));
 integer pcm_checked=0;reg signed[15:0]file_pcm[0:11198084];
 initial $readmemh("ab_verify/results/music_pcm.hex",file_pcm);
 always @(posedge dut.pixel_clk)begin
  if(dut.u_hdmi_top.u_player.fifo_read)begin
   if(dut.pcm_fifo_data!==file_pcm[pcm_checked%11198085])$fatal(1,"actual music sequence mismatch %0d",pcm_checked);
   pcm_checked=pcm_checked+1;
  end
  if(dut.u_hdmi_top.u_player.underrun)$fatal(1,"music underflow");
 end
 integer wi,load_restarts=0,warm_load_restarts=0;
 always @(posedge sys_clk)if(dut.sd_restart_50)load_restarts=load_restarts+1;
 integer screen_x,screen_y,bx,yb,old_img,new_img,frame_alpha=0;
 integer frame_bright=4;reg[8:0]seen_brightness=0;
 integer target_image;reg[8:1] seen_images=0;
 integer checked_frames=0,checked_pixels=0,mixed_frames=0,auto_events=0,k,total;
 reg [31:0] seen_alpha=0;
 reg [11:0] expected,old_rgb,new_rgb;
 reg[23:0]expected_rgb;
 reg checking=0;
 reg [11:0] original_pixels[0:8*307200-1];
 initial $readmemh("ab_verify/results/bmp_pixels.hex",original_pixels);
 function [11:0] pixel;
 input integer img,x,y;
 begin pixel=original_pixels[(img-1)*307200+y*640+x];end
 endfunction
 // Every output pixel is checked against the mathematical blend. All three
 // channels differ between images and contain position-dependent signatures.
 always @(posedge dut.pixel_clk) begin
   if(dut.display_active_sdr && dut.u_hdmi_top.u_vga_disp.hcnt<800 && dut.u_hdmi_top.u_vga_disp.vcnt<600 && dut.fifo_empty)
     $fatal(1,"visible FIFO underflow before OSD");
   #1;
   screen_x=dut.u_hdmi_top.display_x;
   screen_y=dut.u_hdmi_top.display_y;
   if(screen_x==0 && screen_y==0) begin
     for(wi=0;wi<640;wi=wi+1)gold_wave[wi]=dut.u_hdmi_top.u_osd.u_wave.snapshot[wi];
     if(checking) checked_frames=checked_frames+1;
     checking=visible_history[3];
     frame_bright=dut.u_hdmi_top.brightness_level;
     if(frame_bright>8)$fatal(1,"invalid brightness level");
     if(checking)seen_brightness[frame_bright]=1;
     if(checking)seen_images[dut.disp_img]=1;
     old_img=(dut.rd_base/240000)+1;
     new_img=(dut.fade_target_base/240000)+1;
     frame_alpha=dut.fade_active ? dut.fade_alpha:0;
     if(checking && frame_alpha!=0) begin mixed_frames=mixed_frames+1;seen_alpha[frame_alpha]=1;end
   end
   if(checking && screen_x<800 && screen_y<600) begin
     expected=0;
     if(screen_x>=80 && screen_x<720 && screen_y>=60 && screen_y<540) begin
       bx=screen_x-80;yb=539-screen_y;
       old_rgb=pixel(old_img,bx,yb);new_rgb=pixel(new_img,bx,yb);
       for(k=0;k<3;k=k+1) begin
         total=old_rgb[k*4+:4]*(32-frame_alpha)+new_rgb[k*4+:4]*frame_alpha;
         expected[k*4+:4]=(total+16)/32;
       end
     end
     expected_rgb=gold_osd(screen_x,screen_y,gold_brightness(expected,frame_bright),dut.u_hdmi_top.u_osd.scroll_q2,dut.u_hdmi_top.u_osd.frame_bcd,1'b1);
     if({r,g,b}!==expected_rgb)
       $fatal(1,"fade/OSD pixel mismatch (%0d,%0d) old=%0d new=%0d alpha=%0d got=%h expected=%h",screen_x,screen_y,old_img,new_img,frame_alpha,{r,g,b},expected_rgb);
     checked_pixels=checked_pixels+1;
   end
 end
 reg [20:0] old_base=0,target_base=0;reg[5:0]old_alpha=0;reg old_blending=0;
 always @(posedge dut.sdr_clk) begin
   if(dut.sdr_app_wr_en && dut.display_active_sdr &&
      (dut.sdr_app_wr_addr/240000==dut.rd_base/240000 ||
       (dut.fade_active && dut.sdr_app_wr_addr/240000==dut.fade_target_base/240000)))
       $fatal(1,"displayed/blending slot overwritten");
   #0.001;
   if({dut.rd_base,dut.fade_target_base,dut.fade_alpha,dut.fade_active}!={old_base,target_base,old_alpha,old_blending}) begin
     if(dut.u_hdmi_top.u_vga_disp.vcnt<600) $fatal(1,"fade changed outside vertical blank");
     old_base=dut.rd_base;target_base=dut.fade_target_base;old_alpha=dut.fade_alpha;old_blending=dut.fade_active;
   end
 end
 always @(posedge sys_clk) if(dut.auto_pressed) auto_events=auto_events+1;
 task press;
 input backwards;
 begin
   @(negedge sys_clk);if(backwards) kp=0;else kn=0;
   repeat(12) @(negedge sys_clk);kn=1;kp=1;repeat(12) @(negedge sys_clk);
 end
 endtask
 task brightness_key;
 input brighter;
 begin
   @(negedge sys_clk);if(brighter)brup=0;else brdown=0;
   repeat(20)@(negedge sys_clk);brup=1;brdown=1;repeat(20)@(negedge sys_clk);
 end
 endtask
 integer preview_count=0,preview_last=0;
 reg preview_finished=0;
 always @(posedge sys_clk)begin
   #1;
   if(!dut.por_rst && !preview_finished && dut.display_valid)begin
     if(dut.disp_img!=preview_last)begin
       if(dut.disp_img!=(preview_count==8?1:preview_count+1))
         $fatal(1,"startup preview order count=%0d got=%0d",preview_count,dut.disp_img);
       preview_count=preview_count+1;preview_last=dut.disp_img;
       $display("preview commit %0d: image=%0d cached=%h",preview_count,dut.disp_img,dut.u_cache.valid);
     end
     if(dut.preview_done)begin
       if(preview_count!=9 || dut.disp_img!=1 || !dut.preload_done || dut.fade_active)
         $fatal(1,"preview unlocked before 1..8..1 final fade commit");
       preview_finished=1;
     end
   end
 end
 integer last_bright=4;
 always @(posedge dut.pixel_clk)begin
   #1;
   if(dut.u_hdmi_top.brightness_level!=last_bright && dut.u_hdmi_top.presenting &&
      dut.u_hdmi_top.u_vga_disp.hcnt<800 && dut.u_hdmi_top.u_vga_disp.vcnt<600)
     $fatal(1,"brightness tore an active frame");
   last_bright=dut.u_hdmi_top.brightness_level;
 end
 initial begin
   wait(dut.display_valid);$display("startup image=%0d",dut.disp_img);
   if(dut.disp_img!=1 || dut.preload_done || dut.preview_done)
     $fatal(1,"first image must precede complete eight-image preload");
   wait(dut.preview_done);repeat(2)@(posedge dut.frame_start);
   if(!preview_finished || preview_count!=9 || dut.disp_img!=1 || dut.u_cache.key_count!=0 ||
      dut.u_hdmi_top.brightness_level!=4 || auto_events!=0)
     $fatal(1,"held preview inputs leaked at handover");
   $display("PASS startup preview: 1..8..1 complete, first image early, all inputs ignored, final fade committed before unlock");
   @(negedge sys_clk);kn=1;kp=1;brup=1;brdown=1;sw1=1;
   repeat(20)@(negedge sys_clk);warm_load_restarts=load_restarts;
   press(0);wait(dut.fade_active && dut.fade_alpha==8);brightness_key(1);press(1);
   wait(dut.disp_img==2);$display("K1 fade: 1 -> 2; reverse key queued during fade");
   wait(dut.disp_img==1);$display("queued K2 fade: 2 -> 1");
   brightness_key(0);brightness_key(0);repeat(2)@(posedge dut.frame_start);
   if(dut.u_hdmi_top.brightness_level!=3)$fatal(1,"K3/K4 did not retain 87.5 percent");
   press(0);wait(dut.fade_active && dut.fade_alpha==8);brightness_key(1);
   wait(dut.disp_img==2);repeat(2)@(posedge dut.frame_start);
   if(dut.u_hdmi_top.brightness_level!=4)$fatal(1,"K3 did not restore 100 percent");
   sw1=0;wait(dut.fade_active && dut.fade_alpha==8);brightness_key(1);
   wait(dut.disp_img==3);sw1=1;repeat(2)@(posedge dut.frame_start);
   if(load_restarts!=warm_load_restarts || warm_load_restarts!=7)
     $fatal(1,"warm cache reread pictures: restarts %0d -> %0d",warm_load_restarts,load_restarts);
   $display("PASS resident cache integration: eight source loads including reset; preview 1..8..1; zero picture reloads during manual/queued/automatic switches");
   if(!seen_brightness[3] || !seen_brightness[4] || !seen_brightness[5])$fatal(1,"brightness integration coverage %b",seen_brightness);
   $display("PASS integrated K3/K4 brightness: 87.5/100/112.5 percent across cached switches and crossfades, frame-atomic, OSD and music preserved");
   if(seen_alpha[31:1]!=31'h7fffffff || mixed_frames<372 || seen_images!=8'hff || auto_events==0)
     $fatal(1,"insufficient fade coverage weights=%h frames=%0d auto=%0d",seen_alpha,mixed_frames,auto_events);
   if(!saw_presentation || hidden_pixel_checks<10000)$fatal(1,"startup waiting phase not exercised");
   if(pcm_checked<200000)$fatal(1,"insufficient actual music frames %0d",pcm_checked);
   $display("PASS integrated music: %0d ordered reference-song PCM frames, zero playback underruns, frame-stable waveform compositing",pcm_checked);
   $display("PASS startup alignment: %0d initial loading pixels held black; first preview image, OSD and audio started together; elapsed time continuous across preview return and all switches, %0d displayed clocks",hidden_pixel_checks,presentation_ticks);
   $display("PASS continuous ORIGINAL BMP fade + OSD: eight untouched user files + real FAT32/BMP + writer + dual-frame reader + FIFO + VGA + alpha/ROM/ticker/timer, %0d frames, %0d exact RGB888 active pixels, %0d mixed frames, all 31 intermediate weights; preview/manual/queued/automatic, no underflow/tearing/protected-slot write",checked_frames,checked_pixels,mixed_frames);$finish;
 end

 initial begin
   forever begin #100000000;$display("progress t=%0t load=%0d display=%0d alpha=%0d source=%h checked=%0d",$time,dut.load_img,dut.disp_img,dut.fade_alpha,dut.b_status,checked_pixels);end
 end
 initial begin #16000000000;$fatal(1,"fade integration timeout");end
endmodule

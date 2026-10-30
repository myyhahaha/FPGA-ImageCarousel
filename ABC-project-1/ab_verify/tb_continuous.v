`timescale 1ns/1ps
module tb_continuous;
 `include "ab_verify/osd_golden.svh"
 `include "ab_verify/startup_monitor.svh"
 reg sys_clk=0,kn=1,kp=1,sw1=1;
 always #10 sys_clk=~sys_clk;
 wire [7:0] r,g,b;
 abc_hdmi_top #(.POR_CYCLES(10),.DEBOUNCE_CYCLES(3)) dut(
 .sys_clk(sys_clk),.key_next(kn),.key_prev(kp),.key_brighter(1'b1),.key_dimmer(1'b1),.sw1_n(sw1),.sw2_n(1'b1),.sw3_n(1'b1),.sw4_n(1'b1),
 .SD_MISO(1'b1),.VGA_R(r),.VGA_G(g),.VGA_B(b));
 integer screen_x,screen_y,bx,yb,old_img,new_img,frame_alpha=0;
 integer checked_frames=0,checked_pixels=0,mixed_frames=0,auto_events=0,k,total;
 reg [31:0] seen_alpha=0;
 reg [11:0] expected,old_rgb,new_rgb;
 reg[23:0]expected_rgb;
 reg checking=0;
 function [11:0] pixel;
 input integer img,x,y;
 reg [3:0] rr,gg,bb;
 begin rr=(img+x/16+y/16)%16;gg=(x+img*5)%16;bb=(y+img*3)%16;pixel={rr,gg,bb};end
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
     if(checking) checked_frames=checked_frames+1;
     checking=visible_history[3];
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
     expected_rgb=gold_osd(screen_x,screen_y,{expected[11:8],4'b0,expected[7:4],4'b0,expected[3:0],4'b0},dut.u_hdmi_top.u_osd.scroll_q2,dut.u_hdmi_top.u_osd.frame_bcd,1'b1);
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
 initial begin
   wait(dut.display_valid);$display("startup image=%0d",dut.disp_img);
   if(dut.disp_img!=1)$fatal(1,"startup must present IMAGE1.BMP");
   if(dut.preload_done || dut.preview_done)$fatal(1,"first preview image was delayed until full cache");
   wait(dut.preview_done);repeat(2)@(posedge dut.frame_start);
   if(dut.disp_img!=1 || !dut.preload_done || dut.fade_active)$fatal(1,"preview must return to 1 before operations");
   $display("startup preview returned to 1; all eight images resident");
   press(0);wait(dut.fade_active && dut.fade_alpha==8);press(1);
   wait(dut.disp_img==2);$display("K1 fade: 1 -> 2; reverse key queued during fade");
   wait(dut.disp_img==1);$display("queued K2 fade: 2 -> 1 during refill");
   press(1);wait(dut.disp_img==8);$display("K2 pending target fade: 1 -> 8");
   sw1=0;wait(dut.disp_img==1);sw1=1;$display("automatic fade: 8 -> 1");
   repeat(2) @(posedge dut.frame_start);
   if(seen_alpha[31:1]!=31'h7fffffff || mixed_frames<124 || auto_events==0)
     $fatal(1,"insufficient fade coverage weights=%h frames=%0d auto=%0d",seen_alpha,mixed_frames,auto_events);
   if(!saw_presentation || hidden_pixel_checks<10000)$fatal(1,"startup waiting phase not exercised");
   $display("PASS startup alignment: %0d loading pixels held black; image and OSD released at frame origin; timer stayed zero before first image and counted %0d displayed clocks across all switches",hidden_pixel_checks,presentation_ticks);
   $display("PASS continuous fade: real FAT32/BMP + writer + dual-frame reader + FIFO + VGA, %0d frames, %0d exact active pixels, %0d mixed frames, all 31 intermediate weights; manual/queued/automatic, no underflow/tearing/protected-slot write",checked_frames,checked_pixels,mixed_frames);$finish;
 end
 initial begin
   forever begin #100000000;$display("progress t=%0t load=%0d display=%0d alpha=%0d source=%h checked=%0d",$time,dut.load_img,dut.disp_img,dut.fade_alpha,dut.b_status,checked_pixels);end
 end
 initial begin #12000000000;$fatal(1,"fade integration timeout");end
endmodule

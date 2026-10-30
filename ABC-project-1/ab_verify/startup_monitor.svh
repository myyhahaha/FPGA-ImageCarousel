// Real end-to-end first-image/OSD start and elapsed-clock scoreboard.
 reg[3:0]visible_history=0;
 reg saw_presentation=0;
 integer presentation_ticks=0,hidden_pixel_checks=0;
 function[27:0]startup_bcd;input integer seconds;integer hh,mm,ss;
 begin
  hh=seconds/3600;mm=seconds/60%60;ss=seconds%60;
  startup_bcd=(hh/100<<24)|(hh/10%10<<20)|(hh%10<<16)|(mm/10<<12)|(mm%10<<8)|(ss/10<<4)|(ss%10);
 end endfunction
 always @(posedge dut.pixel_clk)begin
  if(dut.por_rst)begin visible_history=0;saw_presentation=0;presentation_ticks=0;end
  else begin
   if(!dut.preview_done && (dut.auto_pressed || dut.u_switch.count!=0 || dut.u_cache.key_count!=0))
     $fatal(1,"manual/automatic navigation released during mandatory preview");
   if(!dut.preview_done && dut.u_hdmi_top.brightness_level!=4)
     $fatal(1,"brightness changed during mandatory preview");
   if(dut.pcm_fifo_read && !dut.u_hdmi_top.presenting)
     $fatal(1,"audio started before the first preview image");
   if(!saw_presentation && dut.u_hdmi_top.presenting)begin
    if(!dut.u_cache.valid[0] || dut.disp_img!=1 || dut.preload_done || dut.preview_done)
     $fatal(1,"first preview image must be complete, start at 1 and precede full preload");
    if(!dut.display_active_sdr || !dut.u_hdmi_top.raw_de || dut.u_hdmi_top.raw_x!=0 || dut.u_hdmi_top.raw_y!=0)
     $fatal(1,"first image and OSD were not released together at frame origin");
    if(dut.u_hdmi_top.u_osd.u_time.elapsed_bcd!=0 || dut.u_hdmi_top.u_osd.u_time.subsecond!=0 || dut.u_hdmi_top.u_osd.scroll_q2!=0)
     $fatal(1,"clock/ticker already advanced before first image");
    saw_presentation=1;
   end
   if(saw_presentation && !dut.u_hdmi_top.presenting)$fatal(1,"presentation restarted while switching/loading");
   if(dut.u_hdmi_top.presenting)presentation_ticks=presentation_ticks+1;
   visible_history={visible_history[2:0],dut.u_hdmi_top.presenting};
  end
  #1;
  if(!dut.por_rst)begin
   if(dut.u_hdmi_top.u_osd.u_time.elapsed_bcd!==startup_bcd(presentation_ticks/40000000) ||
      dut.u_hdmi_top.u_osd.u_time.subsecond!==(presentation_ticks%40000000))
     $fatal(1,"elapsed time differs from first-image presentation clock");
   if(!visible_history[3] && dut.u_hdmi_top.VGA_DE)begin
    if({r,g,b}!==24'd0)$fatal(1,"picture/matte/text leaked before complete first frame");
    hidden_pixel_checks=hidden_pixel_checks+1;
   end
  end
 end

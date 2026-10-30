`timescale 1ns/1ps
// Preview images 1..8 as each complete frame becomes available; stream music through its separate PCM FIFO.
module abc_hdmi_top #(
 parameter [28:0] T_C1=29'd50000000,T_C3=29'd150000000,T_C5=29'd250000000,T_C8=29'd400000000,
 parameter integer DEBOUNCE_CYCLES=1000000,
 parameter integer POR_CYCLES=8388608,
 parameter integer BRIGHTNESS_DEBOUNCE_CYCLES=800000
)(
 input sys_clk,key_next,key_prev,key_brighter,key_dimmer,sw1_n,sw2_n,sw3_n,sw4_n,
 output SD_nCS,SD_DCLK,SD_MOSI,input SD_MISO,
 output HDMI_CLK_P,HDMI_D2_P,HDMI_D1_P,HDMI_D0_P,
 output HDMI_CLK_P1,HDMI_D2_P1,HDMI_D1_P1,HDMI_D0_P1,
 output HDMI_DDC_SCL,inout HDMI_DDC_SDA,
 output [3:0] led,output VGA_HS,VGA_VS,
 output [7:0] VGA_R,VGA_G,VGA_B
);
 wire pixel_clk,pixel_clk_5x,sdr_clk,sdr_clk_sft,sdr_lock;
 reg [22:0] por_cnt=0;
 reg por_rst=1;
 always @(posedge sys_clk) begin
   if(por_cnt==POR_CYCLES-1) por_rst<=0;
   else begin por_cnt<=por_cnt+1'b1;por_rst<=1;end
 end
 clk_wize u_clk_wize(.refclk(sys_clk),.reset(1'b0),
   .clk0_out(pixel_clk_5x),.clk1_out(pixel_clk));
 clk_sdr u_clk_sdr(.refclk(sys_clk),.reset(1'b0),.extlock(sdr_lock),
   .clk0_out(sdr_clk),.clk1_out(sdr_clk_sft));
 wire sdr_init_done,sdr_init_ref_vld,sdr_busy,refresh_req;
 ab_sdram_refresh_ctrl u_refresh(.clk(sdr_clk),.rst(por_rst || !sdr_lock),
   .init_done(sdr_init_done),.refresh_active(sdr_init_ref_vld),.req(refresh_req));
 wire sdr_app_wr_en,sdr_app_rd_en,sdr_rd_en;
 wire [20:0] sdr_app_wr_addr,sdr_app_rd_addr;
 wire [31:0] sdr_app_wr_din,sdr_rd_dout;
 wire [3:0] sdr_app_wr_dm;
 wire sdram_clk,sdr_ras,sdr_cas,sdr_we;
 wire [1:0] sdr_ba;
 wire [10:0] sdr_addr;
 wire [3:0] sdr_dm;
 wire [31:0] sdr_dq;
 sdr_as_ram #(.self_refresh_open(1'b1)) u_sdr_as_ram(
   .Sdr_clk(sdr_clk),.Sdr_clk_sft(sdr_clk_sft),.Rst(~sdr_lock),
   .Sdr_init_done(sdr_init_done),.Sdr_init_ref_vld(sdr_init_ref_vld),
   .Sdr_busy(sdr_busy),.App_ref_req(refresh_req),
   .App_wr_en(sdr_app_wr_en),.App_wr_addr(sdr_app_wr_addr),
   .App_wr_dm(sdr_app_wr_dm),.App_wr_din(sdr_app_wr_din),
   .App_rd_en(sdr_app_rd_en),.App_rd_addr(sdr_app_rd_addr),
   .Sdr_rd_en(sdr_rd_en),.Sdr_rd_dout(sdr_rd_dout),
   .SDRAM_CLK(sdram_clk),.SDR_RAS(sdr_ras),.SDR_CAS(sdr_cas),.SDR_WE(sdr_we),
   .SDR_BA(sdr_ba),.SDR_ADDR(sdr_addr),.SDR_DM(sdr_dm),.SDR_DQ(sdr_dq));
 EG_PHY_SDRAM_2M_32 u_sdram(.clk(sdram_clk),.ras_n(sdr_ras),.cas_n(sdr_cas),
   .we_n(sdr_we),.addr(sdr_addr),.ba(sdr_ba),.dq(sdr_dq),.cs_n(1'b0),
   .dm0(sdr_dm[0]),.dm1(sdr_dm[1]),.dm2(sdr_dm[2]),.dm3(sdr_dm[3]),.cke(1'b1));
 wire[15:0]pcm_fifo_data;wire pcm_fifo_empty,pcm_fifo_read;wire[12:0]pcm_fifo_level;wire[7:0]audio_status;
 wire [23:0] b_rgb;
 wire [9:0] b_x;
 wire [8:0] b_y;
 wire b_valid,b_done,b_busy;
 wire [7:0] b_status;
 wire [3:0] load_img,disp_img;
 wire [20:0] wr_base,switch_base;
 wire sd_restart_50,switch_req,display_valid,writer_blocked,preload_done,preview_done;
 wire switch_ack;
 wire next_pressed,prev_pressed,auto_pressed,fill_done;
 reg fd_s1,fd_s2,ack_s1,ack_s2;
 always @(posedge sys_clk or posedge por_rst) begin
   if(por_rst) begin fd_s1<=0;fd_s2<=0;ack_s1<=0;ack_s2<=0;end
   else begin fd_s1<=fill_done;fd_s2<=fd_s1;ack_s1<=switch_ack;ack_s2<=ack_s1;end
 end
 img_switch_ctrl #(.T_C1(T_C1),.T_C3(T_C3),.T_C5(T_C5),.T_C8(T_C8),
   .DEBOUNCE_CYCLES(DEBOUNCE_CYCLES)) u_switch(
   .clk(sys_clk),.rst(por_rst),.key_next_n(key_next),.key_prev_n(key_prev),
   .sw1_n(sw1_n),.sw2_n(sw2_n),.sw3_n(sw3_n),.sw4_n(sw4_n),.display_valid(display_valid && preview_done),
   .switch_done(switch_req==ack_s2),.disp_img(disp_img),
   .next_pressed(next_pressed),.prev_pressed(prev_pressed),.auto_pressed(auto_pressed));
 ab_image_cache_ctrl u_cache(.clk(sys_clk),.rst(por_rst),
   .next_pressed(next_pressed),.prev_pressed(prev_pressed),.auto_pressed(auto_pressed),
   .source_done(b_done),.source_status(b_status),.fill_done(fd_s2),
   .load_img(load_img),.wr_base(wr_base),.load_restart(sd_restart_50),
   .switch_base(switch_base),.switch_req(switch_req),.switch_ack(ack_s2),
   .display_valid(display_valid),.disp_img(disp_img),.preload_done(preload_done),.preview_done(preview_done));

 // SD restart crosses only into the writer, never into frame_read or video.
 wire reload_sdr;
 ab_reload_cdc u_reload(.src_clk(sys_clk),.dst_clk(sdr_clk),.rst(por_rst),
   .src_pulse(sd_restart_50),.dst_pulse(reload_sdr));
 reg [23:0] mb_data;
 reg mb_req,mb_ack,req_s1,req_s2;
 reg [1:0] ack_s;
 wire mb_ready=!por_rst && (mb_req==ack_s[1]);
 wire pix_avail=(req_s2!=mb_ack);
 wire pix_take;
 // Successful loads finish with an empty mailbox. Keeping its toggle phase
 // across loads avoids unsynchronised resets of a live handshake.
 always @(posedge sys_clk or posedge por_rst) begin
   if(por_rst) begin mb_req<=0;mb_data<=0;ack_s<=0;end
   else begin
     ack_s<={ack_s[0],mb_ack};
     if(b_valid && mb_ready && !sd_restart_50) begin mb_data<=b_rgb;mb_req<=~mb_req;end
   end
 end
 always @(posedge sdr_clk or posedge por_rst) begin
   if(por_rst) begin req_s1<=0;req_s2<=0;mb_ack<=0;end
   else begin
     req_s1<=mb_req;req_s2<=req_s1;
     if(reload_sdr || pix_take) mb_ack<=req_s2; // discard any failed-load residue
   end
 end
 abc_sd_media u_b_stream(.clk(sys_clk),.rst_n(~por_rst),
   .file_idx(load_img),.restart(sd_restart_50),.busy(b_busy),
   .SD_nCS(SD_nCS),.SD_DCLK(SD_DCLK),.SD_MOSI(SD_MOSI),.SD_MISO(SD_MISO),
   .fifo_full(~mb_ready),.fifo_din(b_rgb),.fifo_wr_en(b_valid),
   .pixel_x(b_x),.pixel_y_bottom(b_y),.frame_done(b_done),.status(b_status),
   .audio_clk(pixel_clk),.audio_read(pcm_fifo_read),.audio_data(pcm_fifo_data),.audio_empty(pcm_fifo_empty),.audio_level(pcm_fifo_level),.audio_status(audio_status));
 wire [19:0] accepted;
 wire [2:0] w_state;
 ab_bmp_sdram_writer u_writer(.clk(sdr_clk),.rst(por_rst),.restart(reload_sdr),
   .wr_base(wr_base),.enable(sdr_init_done),.busy(writer_blocked),.refresh(sdr_init_ref_vld),
   .pix_avail(pix_avail),.pix_data(mb_data),.pix_take(pix_take),.src_done(b_done),
   .app_wr_en(sdr_app_wr_en),.app_wr_addr(sdr_app_wr_addr),
   .app_wr_din(sdr_app_wr_din),.app_wr_dm(sdr_app_wr_dm),
   .accepted(accepted),.fill_done(fill_done),.dbg_state(w_state));

 // Keep both slots protected until the final fade frame has committed.
 wire frame_start,display_active_sdr,fade_active;
 wire [20:0] rd_base,fade_target_base;
 wire [5:0] fade_alpha;
 reg fs_s1,fs_s2,fs_s3,frame_sync,sr_s1,sr_s2;
 wire frame_blank_sdr=fs_s2 & ~fs_s3;
 always @(posedge sdr_clk or posedge por_rst) begin
   if(por_rst) begin fs_s1<=0;fs_s2<=0;fs_s3<=0;frame_sync<=0;sr_s1<=0;sr_s2<=0;end
   else begin
     fs_s1<=frame_start;fs_s2<=fs_s1;fs_s3<=fs_s2;
     sr_s1<=switch_req;sr_s2<=sr_s1;
     frame_sync<=frame_blank_sdr && (display_active_sdr || (sr_s2!=switch_ack));
   end
 end
 ab_fade_ctrl u_fade(.clk(sdr_clk),.rst(por_rst),.frame_blank(frame_blank_sdr),
   .request(sr_s2),.switch_base(switch_base),.ack(switch_ack),
   .display_active(display_active_sdr),.old_base(rd_base),.new_base(fade_target_base),
   .blending(fade_active),.alpha(fade_alpha));
 wire fr_wr_en,fifo_full,fifo_empty,fifo_rd_en,reader_reserved;
 wire [10:0] fifo_level;
 // Give scanout priority whenever its FIFO needs data. Do not submit reads
 // and writes together to the opaque vendor controller. A guard drains read
 // responses before the writer resumes. Reserve both reads of a blend packet.
 reg [4:0] rd_guard,wr_guard;
 always @(posedge sdr_clk or posedge por_rst) begin
   if(por_rst) wr_guard<=0;
   else if(sdr_app_wr_en) wr_guard<=16;
   else if(wr_guard!=0) wr_guard<=wr_guard-1'b1;
 end
 reg rd_draining;
 always @(posedge sdr_clk or posedge por_rst) begin
   if(por_rst) rd_draining<=0;
   else rd_draining<=sdr_app_rd_en || sdr_rd_en || (rd_guard!=0);
 end
 reg display_read_urgent;
 always @(posedge sdr_clk or posedge por_rst) begin
   if(por_rst) display_read_urgent<=0;
   else display_read_urgent<=display_active_sdr && (fifo_level<512);
 end
 always @(posedge sdr_clk or posedge por_rst) begin
   if(por_rst) rd_guard<=0;
   else if(sdr_app_rd_en || sdr_rd_en) rd_guard<=31;
   else if(rd_guard!=0) rd_guard<=rd_guard-1'b1;
 end
 assign writer_blocked=reader_reserved || refresh_req || sdr_busy || sdr_app_rd_en || rd_draining ||
                     display_read_urgent;
 wire [23:0] fr_wr_din,fifo_dout;
 // Put every read restart in the 80-pixel black margin of a scan line.
 // A complete 400-word line also keeps controller turnarounds away from
 // interior color edges, while fitting below the FIFO's 512-word headroom.
 frame_read #(.TOTAL(800*600/2),.FIFO_DEPTH(1024),.BURST(400)) u_read(
   .Clk(sdr_clk),.Rst(por_rst),.Sdr_init_done(sdr_init_done),
   .Sdr_init_ref_vld(sdr_init_ref_vld),.Start(1'b0),.Frame_sync(frame_sync),.rd_base(rd_base),
   .rd_base_next(fade_target_base),.Blend_enable(fade_active),.Blend_alpha(fade_alpha),.Read_busy(reader_reserved),
   // A new burst requires the registered read grant. The same grant blocks
   // the writer, so both registered requests cannot start on the same edge.
   .Fifo_full(fifo_full || !display_read_urgent),.Fifo_level(fifo_level),.Sdr_busy(refresh_req || sdr_busy || sdr_app_wr_en || (wr_guard!=0)),
   .App_rd_en(sdr_app_rd_en),.App_rd_addr(sdr_app_rd_addr),
   .Sdr_rd_en(sdr_rd_en),.Sdr_rd_dout(sdr_rd_dout),
   .Fifo_wr_en(fr_wr_en),.Fifo_wr_din(fr_wr_din));
 // Both FIFO pointers reset every vertical blank, before pre-filling a frame.
 // Background SD loading has no connection to these resets.
 afifo_24x1024 u_fifo(.wr_clk(sdr_clk),.wr_rst(por_rst || frame_blank_sdr),
   .wr_en(fr_wr_en && !frame_blank_sdr),.din(fr_wr_din),.full(fifo_full),.wr_level(fifo_level),
   .rd_clk(pixel_clk),.rd_rst(por_rst || frame_start),
   .rd_en(fifo_rd_en),.dout(fifo_dout),.empty(fifo_empty));
 hdmi_top #(.BRIGHTNESS_DEBOUNCE_CYCLES(BRIGHTNESS_DEBOUNCE_CYCLES)) u_hdmi_top(.PXLCLK_I(pixel_clk),.PXLCLK_5X_I(pixel_clk_5x),.RST_I(~por_rst),
   .DISPLAY_READY(display_active_sdr),.CONTROLS_READY(preview_done),.KEY_BRIGHTER_N(key_brighter),.KEY_DIMMER_N(key_dimmer),
   .PCM_DOUT(pcm_fifo_data),.PCM_EMPTY(pcm_fifo_empty),.PCM_LEVEL(pcm_fifo_level),.PCM_RD_EN(pcm_fifo_read),
   .HDMI_DDC_SCL(HDMI_DDC_SCL),.HDMI_DDC_SDA(HDMI_DDC_SDA),
   .FIFO_DOUT(fifo_dout),.FIFO_EMPTY(fifo_empty),.FIFO_RD_EN(fifo_rd_en),
   .DBG_PIX({mb_data[23:20],mb_data[15:12],mb_data[7:4]}),.DBG_VAL(accepted),
   .FRAME_START(frame_start),.HDMI_CLK_P(HDMI_CLK_P),.HDMI_D2_P(HDMI_D2_P),
   .HDMI_D1_P(HDMI_D1_P),.HDMI_D0_P(HDMI_D0_P),
   .VGA_HS(VGA_HS),.VGA_VS(VGA_VS),.VGA_R(VGA_R),.VGA_G(VGA_G),.VGA_B(VGA_B));
 assign HDMI_CLK_P1=HDMI_CLK_P;
 assign HDMI_D2_P1=HDMI_D2_P;
 assign HDMI_D1_P1=HDMI_D1_P;
 assign HDMI_D0_P1=HDMI_D0_P;
 assign led={preview_done,~fifo_empty,display_valid,sdr_init_done};
endmodule

// Eight fixed, non-evicting slots: IMAGE1..8 occupy 0..1919999 32-bit words
// (7,680,000 bytes) of the 8 MiB SDRAM. Each slot includes the black margins.
// Present each next complete image during a mandatory 1..8 startup preview.
// Controls unlock only after preview 1..8 returns to image 1 completely.
// A slot is valid only after complete source AND SDRAM writes. Scanout/fade
// can only select valid slots, so background loading never overwrites either.
module ab_image_cache_ctrl(
 input clk,rst,next_pressed,prev_pressed,auto_pressed,
 input source_done,input [7:0] source_status,input fill_done,
 output reg [3:0] load_img,output reg [20:0] wr_base,output reg load_restart,
 output reg [20:0] switch_base,output reg switch_req,input switch_ack,
 output reg display_valid,output reg [3:0] disp_img,output preload_done,output reg preview_done
);
 localparam L_LOW=0,L_DONE=1,L_IDLE=2,L_LAUNCH=3;
 localparam [3:0] FIRST_IMAGE=4'd1;
 reg [1:0] load_state;
 reg [7:0] valid;
 reg [8:0] failed;
 assign preload_done=&valid;
 reg [3:0] switch_img;
 reg commit_pending,auto_pending;
 // 0..7 present IMAGE1..8; step 8 is a separate, mandatory return to IMAGE1.
 // The preview target never depends on a key event or the normal display index.
 reg [3:0] preview_step;
 // Preserve up to 32 individual key presses, including reversals during a
 // fade/load. Automatic expiry is coalesced and yields to manual input.
 reg [31:0] key_queue;
 reg [4:0] key_head,key_tail;
 reg [5:0] key_count;
 wire switching=(switch_req!=switch_ack);
 function [3:0] after_img;
   input [3:0] n;begin after_img=(n==8)?4'd1:n+4'd1;end
 endfunction
 function [3:0] before_img;
   input [3:0] n;begin before_img=(n==1)?4'd8:n-4'd1;end
 endfunction
 function [20:0] base;
   input [3:0] image_id;
   begin case(image_id)
     1:base=0;2:base=240000;3:base=480000;4:base=720000;
     5:base=960000;6:base=1200000;7:base=1440000;8:base=1680000;
     default:base=0;
   endcase end
 endfunction
 function cached;
   input [3:0] n;
   input [7:0] mask;
   begin cached=(n>=1 && n<=8) ? mask[n-1'b1]:1'b0;end
 endfunction
 wire pending=(key_count!=0) || auto_pending;
 wire backwards=(key_count!=0) && key_queue[key_head];
 wire [3:0] preview_target=(preview_step==8)?FIRST_IMAGE:preview_step+4'd1;
 wire [3:0] target=!preview_done?preview_target:
                    (backwards?before_img(disp_img):after_img(disp_img));
 wire launch_switch=!switching && !commit_pending && cached(target,valid) &&
                    (!preview_done || pending);
 wire dequeue=launch_switch && preview_done && key_count!=0;
 wire enqueue=preview_done && (next_pressed || prev_pressed) && (key_count<32 || dequeue);
 reg [3:0] wanted;
 integer j;
 always @(*) begin
   wanted=0;
   // Fill immutable slots in order while preview scanout/music are active.
   // Never publish an incomplete frame or skip a failed preview image.
   for(j=1;j<=8;j=j+1)
     if(wanted==0 && !cached(j,valid) && !failed[j]) wanted=j;
 end
 always @(posedge clk or posedge rst) begin
   if(rst) begin
     valid<=0;failed<=0;
     load_state<=L_LOW;load_img<=FIRST_IMAGE;wr_base<=0;load_restart<=0;
     disp_img<=FIRST_IMAGE;display_valid<=0;preview_done<=0;
     switch_base<=0;switch_req<=0;switch_img<=FIRST_IMAGE;
     auto_pending<=0;commit_pending<=0;preview_step<=0;
     key_queue<=0;key_head<=0;key_tail<=0;key_count<=0;
   end else begin
     load_restart<=0;
     // Arm the acknowledgement wait on the very edge that launches a command.
     // Do not rely on observing a later request/ack mismatch to remember it.
     if(commit_pending) begin
       if(!switching)begin
         disp_img<=switch_img;display_valid<=1;commit_pending<=0;
         if(!preview_done)begin
           if(preview_step<8)preview_step<=preview_step+4'd1;
           else if(switch_img==FIRST_IMAGE && preload_done)preview_done<=1;
         end
       end
     end else if(launch_switch) begin
       switch_img<=target;switch_base<=base(target);
       switch_req<=~switch_req;commit_pending<=1;
     end
     if(enqueue) begin
       key_queue[key_tail]<=prev_pressed && !next_pressed;key_tail<=key_tail+1'b1;
     end
     if(dequeue) key_head<=key_head+1'b1;
     case({enqueue,dequeue})
       2'b10:key_count<=key_count+1'b1;
       2'b01:key_count<=key_count-1'b1;
       default:begin end
     endcase
     if(preview_done && (next_pressed || prev_pressed)) begin auto_pending<=0;failed<=0;end
     else if(launch_switch && display_valid) auto_pending<=0;
     else if(preview_done && auto_pressed && key_count==0) auto_pending<=1;
     case(load_state)
       L_LOW: if(!fill_done && !source_done && !source_status[7]) load_state<=L_DONE;
       L_DONE: begin
         if(source_done && fill_done && source_status==8'hA5) begin
           valid[load_img-1'b1]<=1;load_state<=L_IDLE;
         end else if(source_status[7] && source_status!=8'hA5) begin
           failed[load_img]<=1;valid[load_img-1'b1]<=0;load_state<=L_IDLE;
         end
       end
       L_IDLE: if(wanted!=0) begin
         load_img<=wanted;wr_base<=base(wanted);
         valid[wanted-1'b1]<=0;load_state<=L_LAUNCH;
       end
       L_LAUNCH: begin load_restart<=1;load_state<=L_LOW;end
     endcase
   end
 end
endmodule

// Debounced key events; automatic slideshow timer runs while prefetching.
module img_switch_ctrl #(
 parameter [28:0] T_C1=29'd50000000,T_C3=29'd150000000,T_C5=29'd250000000,T_C8=29'd400000000,
 parameter integer DEBOUNCE_CYCLES=1000000
)(
 input clk,rst,key_next_n,key_prev_n,sw1_n,sw2_n,sw3_n,sw4_n,
 input display_valid,switch_done,input [3:0] disp_img,
 output next_pressed,prev_pressed,output reg auto_pressed
);
 reg [1:0] kn,kp;
 reg [3:0] sw_s1,sw_s2;
 reg next_armed,prev_armed;
 reg stable_n,stable_p,old_n,old_p;
 reg [19:0] cnt_n,cnt_p;
 always @(posedge clk or posedge rst) begin
   if(rst) begin kn<=3;kp<=3;sw_s1<=15;sw_s2<=15;end
   else begin kn<={kn[0],key_next_n};kp<={kp[0],key_prev_n};
     sw_s1<={sw4_n,sw3_n,sw2_n,sw1_n};sw_s2<=sw_s1;end
 end
 always @(posedge clk or posedge rst) begin
   if(rst) begin stable_n<=1;stable_p<=1;old_n<=1;old_p<=1;cnt_n<=0;cnt_p<=0;end
   else begin
     old_n<=stable_n;old_p<=stable_p;
     if(kn[1]==stable_n) cnt_n<=0;
     else if(cnt_n==DEBOUNCE_CYCLES-1) begin stable_n<=kn[1];cnt_n<=0;end
     else cnt_n<=cnt_n+1'b1;
     if(kp[1]==stable_p) cnt_p<=0;
     else if(cnt_p==DEBOUNCE_CYCLES-1) begin stable_p<=kp[1];cnt_p<=0;end
     else cnt_p<=cnt_p+1'b1;
   end
 end
 // Ignore keys held during preview; require a debounced release before
 // accepting a fresh press once controls are enabled.
 always @(posedge clk or posedge rst)begin
   if(rst)begin next_armed<=0;prev_armed<=0;end
   else if(!display_valid)begin next_armed<=0;prev_armed<=0;end
   else begin
     if(stable_n && kn[1])next_armed<=1;
     if(stable_p && kp[1])prev_armed<=1;
   end
 end
 assign next_pressed=display_valid && next_armed && old_n && !stable_n;
 assign prev_pressed=display_valid && prev_armed && old_p && !stable_p;
 reg [28:0] limit,old_limit,count;
 reg [3:0] old_img;
 always @(*) begin
   if(!sw_s2[0]) limit=T_C1;
   else if(!sw_s2[1]) limit=T_C3;
   else if(!sw_s2[2]) limit=T_C5;
   else if(!sw_s2[3]) limit=T_C8;
   else limit=0;
 end
 always @(posedge clk or posedge rst) begin
   if(rst) begin count<=0;old_limit<=0;old_img<=1;auto_pressed<=0;end
   else begin
     auto_pressed<=0;old_limit<=limit;old_img<=disp_img;
     // The selected interval is the stable-image hold time. A fade does not
     // consume any of it; start a fresh interval after the new image commits.
     if(!display_valid || !switch_done || limit==0 || limit!=old_limit ||
        disp_img!=old_img || next_pressed || prev_pressed) count<=0;
     else if(count==limit-1) begin count<=0;auto_pressed<=1;end
     else count<=count+1'b1;
   end
 end
endmodule








// Do not depend on the encrypted IP parameter for refresh generation. A held
// external request is acknowledged by refresh_active. Block new transactions
// while pending; finish any BL4 packet already offered before handing over.
// 390 clocks @ 50 MHz = 7.8 us, ample for 2048/4096 rows per 64 ms.
module ab_sdram_refresh_ctrl #(parameter INTERVAL=390)(
 input clk,rst,init_done,refresh_active,output reg req
);
 reg [8:0] count;
 always @(posedge clk or posedge rst) begin
   if(rst) begin count<=0;req<=0;end
   else if(!init_done) begin count<=0;req<=0;end
   else if(req) begin if(refresh_active) req<=0;end
   else if(count==INTERVAL-1) begin count<=0;req<=1;end
   else count<=count+1'b1;
 end
endmodule

// A toggle event cannot be missed when source and destination clocks have the
// same frequency but an arbitrary phase. The base bus is held by the cache.
module ab_reload_cdc(input src_clk,dst_clk,rst,src_pulse,output dst_pulse);
 reg toggle;
 reg s1,s2,s3;
 always @(posedge src_clk or posedge rst) begin
   if(rst) toggle<=0;else if(src_pulse) toggle<=~toggle;
 end
 always @(posedge dst_clk or posedge rst) begin
   if(rst) begin s1<=0;s2<=0;s3<=0;end
   else begin s1<=toggle;s2<=s1;s3<=s2;end
 end
 assign dst_pulse=s2 ^ s3;
endmodule

// alpha is constant throughout an active frame. First image is presented
// directly; later requests use 31 mixed frames followed by the exact new one.
// The request acknowledgement holds both cache slots until the fade is over.
module ab_fade_ctrl(input clk,rst,frame_blank,request,input [20:0] switch_base,
 output reg ack,display_active,output reg [20:0] old_base,new_base,
 output reg blending,output reg [5:0] alpha);
 reg pending_request;
 always @(posedge clk or posedge rst) begin
   if(rst) begin
     ack<=0;display_active<=0;old_base<=0;new_base<=0;blending<=0;alpha<=0;pending_request<=0;
   end else if(frame_blank) begin
     if(blending) begin
       if(alpha==31) begin
         old_base<=new_base;blending<=0;alpha<=0;ack<=pending_request;
       end else alpha<=alpha+1'b1;
     end else if(request!=ack) begin
       if(!display_active) begin old_base<=switch_base;new_base<=switch_base;ack<=request;display_active<=1;end
       else begin new_base<=switch_base;alpha<=1;blending<=1;pending_request<=request;end
     end
   end
 end
endmodule

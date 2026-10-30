`timescale 1ns/1ps
// Real exported SDRAM controller + pin memory; both application clients real.
module tb_pin_line #(parameter real MEM_TAC=4.5,CLK_DELAY=0,parameter [5:0] MIX_ALPHA=16,parameter MIX_ENABLE=1);
 reg clk=0,rst=1,restart=0,fs=0;
 always #10 clk=~clk;
 wire shifted;assign #8 shifted=clk;
 wire init,refv,busy,rden,refresh_req;
 ab_sdram_refresh_ctrl refresh_ctrl(.clk(clk),.rst(rst),.init_done(init),.refresh_active(refv),.req(refresh_req));wire [31:0] rdata;
 wire wr,rd,read_reserved;wire [20:0] wa,ra;wire [31:0] data;wire[3:0]wm;
 wire ck,ras,cas,we;wire[1:0]ba;wire[10:0]a;wire[3:0]dm;wire[31:0]dq;
 sdr_as_ram dut(.Sdr_clk(clk),.Sdr_clk_sft(shifted),.Rst(rst),.Sdr_init_done(init),
 .Sdr_init_ref_vld(refv),.Sdr_busy(busy),.App_ref_req(refresh_req),
 .App_wr_en(wr),.App_wr_addr(wa),.App_wr_din(data),.App_wr_dm(wm),
 .App_rd_en(rd),.App_rd_addr(ra),.Sdr_rd_en(rden),.Sdr_rd_dout(rdata),
 .SDRAM_CLK(ck),.SDR_RAS(ras),.SDR_CAS(cas),.SDR_WE(we),.SDR_ADDR(a),.SDR_BA(ba),.SDR_DM(dm),.SDR_DQ(dq));
 wire pin_clk;assign #(CLK_DELAY) pin_clk=ck;
 EG_PHY_SDRAM_2M_32 #(.T_AC(MEM_TAC)) mem(.clk(pin_clk),.ras_n(ras),.cas_n(cas),.we_n(we),.addr(a),.ba(ba),.dq(dq),.cs_n(1'b0),.dm0(dm[0]),.dm1(dm[1]),.dm2(dm[2]),.dm3(dm[3]),.cke(1'b1));
 integer last_refresh=0,max_refresh_gap=0;
 always @(posedge pin_clk) if(init && {ras,cas,we}==1) begin
   if(last_refresh!=0 && $time-last_refresh>max_refresh_gap) max_refresh_gap=$time-last_refresh;
   last_refresh=$time;
 end
 integer tick=0,pixels=0,read_words=0,groups=0,j,laddr;
 wire grant=(tick%256<128);
 reg [4:0] wg=0,rg=0;
 always @(posedge clk) begin
   tick<=tick+1;
   if(wr) wg<=16;else if(wg!=0) wg<=wg-1'b1;
   if(rd || rden) rg<=31;else if(rg!=0) rg<=rg-1'b1;
 end
 wire take,done;
 wire [19:0] accepted;wire[2:0]state;
 function [11:0] color;
 input integer n;begin color={n[3:0],n[7:4],n[11:8]};end
 endfunction
 wire [11:0] pc=color(pixels);
 ab_bmp_sdram_writer writer(.clk(clk),.rst(rst),.restart(restart),.enable(init),
 .busy(read_reserved || refresh_req || busy || grant || rg!=0),.refresh(refv),.wr_base(21'd480000),
 .pix_avail(pixels<2048),.pix_data({pc[11:8],4'b0,pc[7:4],4'b0,pc[3:0],4'b0}),.pix_take(take),.src_done(pixels==2048),
 .app_wr_en(wr),.app_wr_addr(wa),.app_wr_din(data),.app_wr_dm(wm),.accepted(accepted),.fill_done(done),.dbg_state(state));
 always @(posedge clk) if(take) pixels<=pixels+1;
 wire fw;wire [23:0] fd;
 frame_read #(.TOTAL(4000),.BURST(400)) reader(.Clk(clk),.Rst(rst),.Sdr_init_done(init),
 .Sdr_init_ref_vld(refv),.Start(1'b0),.Frame_sync(fs),.rd_base(21'd0),
 .rd_base_next(21'd240000),.Blend_enable(MIX_ENABLE),.Blend_alpha(MIX_ALPHA),.Read_busy(read_reserved),
 .Fifo_full(!grant),.Fifo_level(11'd0),.Sdr_busy(refresh_req || busy || wr || wg!=0),
 .App_rd_en(rd),.App_rd_addr(ra),.Sdr_rd_en(rden),.Sdr_rd_dout(rdata),.Fifo_wr_en(fw),.Fifo_wr_din(fd));
 function integer physical;
 input integer n;begin physical=((n>>10)<<10) | (((n>>2)&3)<<8) | (((n>>4)&63)<<2) | (n&3);end
 endfunction
 function [23:0] source_word;
 input integer image_id,n;
 begin source_word=(image_id==0) ? (24'ha00000 | n):(24'h0fc000 ^ (n*17));end
 endfunction
 function [23:0] mixed_word;
 input integer n;
 reg [23:0] av,bv;integer lane,v;
 begin
   av=source_word(0,n);bv=source_word(1,n);mixed_word=av;
   if(MIX_ENABLE) for(lane=0;lane<6;lane=lane+1) begin
     v=av[lane*4+:4]*(32-MIX_ALPHA)+bv[lane*4+:4]*MIX_ALPHA;
     mixed_word[lane*4+:4]=(v+16)/32;
   end
 end
 endfunction
 integer old_reads=0,new_reads=0;
 always @(posedge clk) if(!rst) begin
   if(rd && wr) $fatal(1,"overlapping App requests");
   if(rd) begin if(ra<240000) old_reads=old_reads+1;else new_reads=new_reads+1;end
   if(fw) begin
     if(fd !== mixed_word(read_words)) $fatal(1,"pin blend read mismatch at %0d: got %h expected %h",read_words,fd,mixed_word(read_words));
     read_words=read_words+1;
   end
 end
 initial begin
   for(j=0;j<4096;j=j+1) begin mem.mem[physical(j)]={8'b0,source_word(0,j)};mem.mem[physical(240000+j)]={8'b0,source_word(1,j)};end
   #200;rst=0;
   // Skip only the long power-up wait; retain the real init command sequence.
   force dut.\u1_init_ref/pwr_200ms_cnt =18'd0;
   #1000;force dut.\u1_init_ref/pwr_200ms_cnt =18'h20000;
   wait(init);@(negedge clk);restart=1;@(negedge clk);restart=0;
   // Eight black words exercise clearing without spending 240000 writes here.
   force writer.clear_addr=21'd239992;@(negedge clk);release writer.clear_addr;
   repeat(5) @(negedge clk);fs=1;@(negedge clk);fs=0;
   wait(accepted==1024 && read_words==4000);repeat(64) @(negedge clk);
   for(j=0;j<1024;j=j+1) begin
     laddr=480000+215640-(j/320)*400+j%320;
     if(mem.mem[physical(laddr)][23:0] !== {color(2*j+1),color(2*j)})
       $fatal(1,"pin write mismatch pair %0d appaddr %0d got %h expected %h",j,laddr,mem.mem[physical(laddr)],{color(2*j+1),color(2*j)});
   end
   $display("REFRESH commands=%0d max gap=%0d ns tAC=%0.1f skew=%0.1f",mem.refreshes,max_refresh_gap,MEM_TAC,CLK_DELAY);
   // EM638325 specifies 4096 refresh cycles/64 ms (15.625 us average).
   // Whole-line traffic can defer the 7.8 us request beyond the former
   // 10 us short-packet test budget. Keep a conservative 12 us limit.
   if(max_refresh_gap>12000) $fatal(1,"refresh delayed too long");
   if(old_reads!=4000 || new_reads!=(MIX_ENABLE ? 4000:0)) $fatal(1,"read lengths %d/%d",old_reads,new_reads);
   if(mem.refreshes<20) $fatal(1,"periodic refresh missing: %d",mem.refreshes);
   if(mem.unknown_writes!=0) $fatal(1,"DQ conflict/unknown write beats %d",mem.unknown_writes);
   $display("PASS pin transactions: real TD controller, 4000 blended output words + 1024 written image pairs, 400-word line packets, dual-bank/row addresses, refresh/arbitration/delay margins");$finish;
 end
 initial begin #4000000;$fatal(1,"pin timeout: accepted=%0d pixels=%0d read=%0d",accepted,pixels,read_words);end
endmodule


`timescale 1ns/1ps
// Complete physical-controller round trip. Two original frames are read and
// blended while a third is cleared/written, then that written frame is read.
module tb_pin_fullframe;
 reg clk=0,rst=1,restart=0,fs=0;always #10 clk=~clk;
 wire shifted;assign #8 shifted=clk;
 wire init,refv,busy,rden,refresh_req;wire[31:0]rdata;
 wire wr,rd,reserved,ck,ras,cas,we;wire[20:0]wa,ra;wire[31:0]data;wire[3:0]wm,dm;
 wire[1:0]ba;wire[10:0]a;wire[31:0]dq;
 ab_sdram_refresh_ctrl refresh_ctrl(.clk(clk),.rst(rst),.init_done(init),.refresh_active(refv),.req(refresh_req));
 sdr_as_ram dut(.Sdr_clk(clk),.Sdr_clk_sft(shifted),.Rst(rst),.Sdr_init_done(init),
 .Sdr_init_ref_vld(refv),.Sdr_busy(busy),.App_ref_req(refresh_req),
 .App_wr_en(wr),.App_wr_addr(wa),.App_wr_din(data),.App_wr_dm(wm),
 .App_rd_en(rd),.App_rd_addr(ra),.Sdr_rd_en(rden),.Sdr_rd_dout(rdata),
 .SDRAM_CLK(ck),.SDR_RAS(ras),.SDR_CAS(cas),.SDR_WE(we),.SDR_ADDR(a),.SDR_BA(ba),.SDR_DM(dm),.SDR_DQ(dq));
 EG_PHY_SDRAM_2M_32 #(.T_AC(4.5)) mem(.clk(ck),.ras_n(ras),.cas_n(cas),.we_n(we),.addr(a),.ba(ba),.dq(dq),.cs_n(1'b0),.dm0(dm[0]),.dm1(dm[1]),.dm2(dm[2]),.dm3(dm[3]),.cke(1'b1));
 reg[11:0]original[0:8*307200-1];initial $readmemh("ab_verify/results/bmp_pixels.hex",original);
 integer tick=0,pixels=0,read_words=0,phase=0,j,k,ret_words=0;
 wire grant=tick%256<128;reg[4:0]wg=0,rg=0;
 always @(posedge clk)begin
  tick<=tick+1;
  if(wr)wg<=16;else if(wg!=0)wg<=wg-1'b1;
  if(rd || rden)rg<=31;else if(rg!=0)rg<=rg-1'b1;
  if(tick%500000==0)$display("pin full t=%0t phase=%0d written=%0d source=%0d read=%0d",$time,phase,accepted,pixels,read_words);
 end
 wire take,done;wire[19:0]accepted;wire[2:0]state;
 wire[11:0]pc=pixels<307200 ? original[7*307200+pixels]:12'd0;
 ab_bmp_sdram_writer writer(.clk(clk),.rst(rst),.restart(restart),.enable(init),
 .busy(reserved || refresh_req || busy || grant || rg!=0),.refresh(refv),.wr_base(21'd1680000),
 .pix_avail(pixels<307200),.pix_data({pc[11:8],4'b0,pc[7:4],4'b0,pc[3:0],4'b0}),.pix_take(take),.src_done(pixels==307200),
 .app_wr_en(wr),.app_wr_addr(wa),.app_wr_din(data),.app_wr_dm(wm),.accepted(accepted),.fill_done(done),.dbg_state(state));
 always @(posedge clk)if(take)pixels<=pixels+1;
 wire fw;wire[23:0]fd;
 frame_read #(.TOTAL(240000),.BURST(400)) reader(.Clk(clk),.Rst(rst),.Sdr_init_done(init),
 .Sdr_init_ref_vld(refv),.Start(1'b0),.Frame_sync(fs),.rd_base(phase==0?21'd1200000:21'd1680000),
 .rd_base_next(21'd1440000),.Blend_enable(phase==0),.Blend_alpha(6'd16),.Read_busy(reserved),
 .Fifo_full(!grant),.Fifo_level(11'd0),.Sdr_busy(refresh_req || busy || wr || wg!=0),
 .App_rd_en(rd),.App_rd_addr(ra),.Sdr_rd_en(rden),.Sdr_rd_dout(rdata),.Fifo_wr_en(fw),.Fifo_wr_din(fd));
 function integer physical;input integer n;
 begin physical=((n>>10)<<10)|(((n>>2)&3)<<8)|(((n>>4)&63)<<2)|(n&3);end endfunction
 function[11:0]pixel;input integer image_id,n;integer x,y;
 begin x=n%800;y=n/800;pixel=0;
 if(x>=80 && x<720 && y>=60 && y<540)pixel=original[(image_id-1)*307200+(539-y)*640+x-80];end endfunction
 function[23:0]source_word;input integer image_id,n;
 begin source_word={pixel(image_id,2*n+1),pixel(image_id,2*n)};end endfunction
 function[23:0]expected_word;input integer n;reg[23:0]av,bv;integer lane,v;
 begin
  expected_word=source_word(8,n);
  if(phase==0)begin av=source_word(6,n);bv=source_word(7,n);
   for(lane=0;lane<6;lane=lane+1)begin v=av[lane*4+:4]*16+bv[lane*4+:4]*16;expected_word[lane*4+:4]=(v+16)/32;end
  end
 end endfunction
 always @(posedge clk)if(!rst)begin
  if(rd && wr)$fatal(1,"overlapping application requests");
  if(fw)begin
   if(fd!==expected_word(read_words))$fatal(1,"FULL ROUNDTRIP mismatch phase=%0d word=%0d x=%0d y=%0d got=%h expected=%h",phase,read_words,(read_words*2)%800,(read_words*2)/800,fd,expected_word(read_words));
   read_words=read_words+1;ret_words=ret_words+1;
  end
 end
 initial begin
  for(j=0;j<240000;j=j+1)begin mem.mem[physical(1200000+j)]={8'd0,source_word(6,j)};mem.mem[physical(1440000+j)]={8'd0,source_word(7,j)};end
  #200;rst=0;force dut.\u1_init_ref/pwr_200ms_cnt =18'd0;
  #1000;force dut.\u1_init_ref/pwr_200ms_cnt =18'h20000;
  wait(init);@(negedge clk);restart=1;@(negedge clk);restart=0;
  repeat(5)@(negedge clk);fs=1;@(negedge clk);fs=0;
  wait(done && read_words==240000);repeat(64)@(negedge clk);
  $display("Full write completed; reading back original IMAGE8 from slot 7 (1,680,000 words)");
  phase=1;read_words=0;fs=1;@(negedge clk);fs=0;
  wait(read_words==240000);repeat(64)@(negedge clk);
  if(ret_words!=480000 || accepted!=153600 || mem.unknown_writes!=0)$fatal(1,"Incomplete physical roundtrip coverage");
  $display("PASS FULL SDRAM ROUNDTRIP: 240000 mixed words from original IMAGE6/7; full clear + 153600 written IMAGE8 pairs; 240000 words read back from physical SDRAM; all 480000 output words exact in high slots 5/6/7, refresh=%0d",mem.refreshes);$finish;
 end
 initial begin #1000000000;$fatal(1,"full pin roundtrip timeout");end
endmodule


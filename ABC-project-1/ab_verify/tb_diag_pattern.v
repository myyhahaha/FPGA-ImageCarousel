`timescale 1ns/1ps
module tb_diag_pattern;
 reg sys_clk=0;always #10 sys_clk=~sys_clk;
 wire[7:0]r,g,b;wire sclk,mosi,cs;
 ab_video_diag_top dut(.sys_clk(sys_clk),.key_next(1'b1),.key_prev(1'b1),.sw1_n(1'b1),.sw2_n(1'b1),.sw3_n(1'b1),
 .SD_MISO(1'b1),.SD_DCLK(sclk),.SD_MOSI(mosi),.SD_nCS(cs),.VGA_R(r),.VGA_G(g),.VGA_B(b));
 reg[11:0]original[0:8*307200-1];initial $readmemh("ab_verify/results/bmp_pixels.hex",original);
 reg[11:0]gray_line[0:639];reg[11:0]expected;integer x,y,m,checked=0,checker_pixels=0,gray=0;
 always @(posedge dut.pixel_clk)begin
  x=dut.h-80;y=dut.v-60;m=dut.mode;
  #1;
  if(!dut.por)begin
   if(cs!==1 || sclk!==0 || mosi!==1)$fatal(1,"diagnostic must keep SD pins idle");
   if(x>=0 && x<640 && y>=0 && y<480)begin
    if((m==0 || m==3) && y>=290 && y<430)begin
     expected=original[4*307200+(479-y)*640+x];
     if({r[7:4],g[7:4],b[7:4]}!==expected)$fatal(1,"diagnostic IMAGE5 bars mismatch %d,%d",x,y);
     checked=checked+1;
     if(m==3 && {r,g,b}!=={expected[11:8],expected[11:8],expected[7:4],expected[7:4],expected[3:0],expected[3:0]})$fatal(1,"full range diagnostic color mismatch");
    end
    if(m==1)begin
     expected=original[5*307200+(479-y)*640+x];
     if({r[7:4],g[7:4],b[7:4]}!==expected)$fatal(1,"diagnostic IMAGE6 checker_pixels mismatch %d,%d",x,y);
     checker_pixels=checker_pixels+1;
    end
    if(m==2)begin
     if(y==0)gray_line[x]={r[7:4],g[7:4],b[7:4]};
     else if({r[7:4],g[7:4],b[7:4]}!==gray_line[x])$fatal(1,"diagnostic gray edge shifted between rows");
     if(r!==g || g!==b)$fatal(1,"diagnostic gray channel mismatch");gray=gray+1;
    end
   end
  end
 end
 initial begin
  #100;force dut.por_cnt=23'd8388607;wait(!dut.por);release dut.por_cnt;
  wait(dut.v==600);force dut.requested_mode=2'd1;wait(dut.mode==1);
  wait(dut.v==600); // this is the following frame's blank, since mode latched at 601
  force dut.requested_mode=2'd2;wait(dut.mode==2);wait(dut.v==600);
  force dut.requested_mode=2'd3;wait(dut.mode==3);wait(dut.v==600);
  if(checked<179200 || checker_pixels<307200 || gray<307200)$fatal(1,"incomplete diagnostic coverage");
  $display("PASS DIAGNOSTIC: %0d exact original bar pixels, %0d exact original checker_pixels pixels, %0d row-stable grayscale pixels; no TF transactions",checked,checker_pixels,gray);$finish;
 end
 initial begin #100000000;$fatal(1,"diagnostic simulation timeout");end
endmodule


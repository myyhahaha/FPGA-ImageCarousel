`timescale 1ns/1ps
module abc_tb_audio_waveform;
 reg clk=0,rst=1,blank=0,valid=0;always #5 clk=~clk;
 reg signed[15:0]sample=0;reg[9:0]address=0;wire[9:0]levels;
 abc_audio_waveform #(.BIN_SAMPLES(4))dut(.clk(clk),.rst(rst),.frame_blank(blank),.sample_valid(valid),.sample(sample),.read_column(address),.levels(levels));
 reg[9:0]ring[0:639],old_snapshot[0:639];integer head=0,i,j,hi,lo,checks=0;
 task one;input integer s;
 begin @(negedge clk);sample=s;valid=1;@(negedge clk);valid=0;repeat(199)@(negedge clk);end endtask
 task bin;input integer p,n;
 begin one(p);one(n);one(p/2);one(n/2);ring[head]=((p>>11)<<5)|((-n)>>11);head=(head+1)%640;end endtask
 task capture;
 begin @(negedge clk);blank=1;@(negedge clk);blank=0;repeat(645)@(negedge clk);end endtask
 task check_current;
 begin for(j=0;j<640;j=j+1)begin
  @(negedge clk);address=j;@(posedge clk);#1;
  if(levels!==ring[(head+j)%640])$fatal(1,"waveform column=%0d got=%h expected=%h",j,levels,ring[(head+j)%640]);
  old_snapshot[j]=levels;checks=checks+1;
 end end endtask
 initial begin
  for(i=0;i<640;i=i+1)ring[i]=0;
  repeat(6)@(negedge clk);rst=0;repeat(660)@(negedge clk);capture;check_current;
  for(i=0;i<700;i=i+1)bin((i*97)%32768,-((i*193)%32769));
  capture;check_current;
  for(i=0;i<12;i=i+1)bin(32767,-32768);
  for(j=0;j<640;j=j+1)begin
   @(negedge clk);address=j;@(posedge clk);#1;
   if(levels!==old_snapshot[j])$fatal(1,"visible waveform snapshot tore during live audio writes");checks=checks+1;
  end
  capture;check_current;
  // Complete a bin while the vertical-blank copy is in flight. Its write
  // must wait; this frame stays coherent and the next includes the new bin.
  one(8192);one(-4096);one(4096);
  @(negedge clk);blank=1;@(negedge clk);blank=0;
  repeat(30)@(negedge clk);sample=-2048;valid=1;@(negedge clk);valid=0;repeat(645)@(negedge clk);
  check_current;
  ring[head]=((8192>>11)<<5)|(4096>>11);head=(head+1)%640;
  capture;check_current;
  rst=1;repeat(4)@(negedge clk);rst=0;repeat(660)@(negedge clk);
  for(i=0;i<640;i=i+1)ring[i]=0;head=0;capture;check_current;
  $display("PASS audio waveform: %0d exact snapshot columns; PCM min/max including -32768, ring wrap, immutable visible frames, deferred write during copy and reset clear",checks);$finish;
 end
 initial begin #10000000;$fatal(1,"waveform timeout");end
endmodule

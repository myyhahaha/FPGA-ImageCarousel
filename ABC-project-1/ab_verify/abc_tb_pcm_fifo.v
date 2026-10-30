`timescale 1ns/1ps
module abc_tb_pcm_fifo;
 reg wc=0,rc=0,rst=1,we=0,re=0;always #10 wc=~wc;always #12.5 rc=~rc;
 reg[15:0]din=0;wire[15:0]dout;wire full,empty;wire[12:0]wl,rl;
 integer pushes=0,pops=0,phase=0,wt=0,rt=0;
 abc_pcm_fifo dut(.wr_clk(wc),.wr_rst(rst),.wr_en(we),.din(din),.full(full),.rd_clk(rc),.rd_rst(rst),.rd_en(re),.dout(dout),.empty(empty),.wr_level(wl),.rd_level(rl));
 function[15:0]signature;input integer n;begin signature=(n*137)^16'ha53c;end endfunction
 always @(negedge wc)begin wt=wt+1;we=!rst && pushes<20000 && (phase==0 || wt%7!=0);din=signature(pushes);end
 always @(negedge rc)begin rt=rt+1;re=!rst && phase==1 && rt%5!=0;end
 always @(posedge wc)if(!rst && we && !full)pushes=pushes+1;
 always @(posedge rc)if(!rst && re && !empty)begin
  if(dout!==signature(pops))$fatal(1,"PCM FIFO sample %0d got=%h expected=%h",pops,dout,signature(pops));pops=pops+1;
 end
 initial begin
  repeat(6)@(negedge wc);rst=0;wait(full);repeat(10)@(negedge wc);
  if(pushes!=4096)$fatal(1,"PCM FIFO did not stop at 4096 samples");
  phase=1;wait(pops==20000);repeat(30)@(negedge rc);
  if(!empty || wl!=0 || rl!=0)$fatal(1,"PCM FIFO drain level incorrect");
  $display("PASS PCM FIFO: 20000 exact samples, 4096-depth full hold, asynchronous clocks, random backpressure, wrap and empty/prefill levels");$finish;
 end
 initial begin #5000000;$fatal(1,"PCM FIFO timeout");end
endmodule

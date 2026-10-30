`timescale 1ns/1ps
// Throughput of the actual unchanged SPI master. No SD-card latency is
// modeled here; the estimate is explicitly not an end-to-end boot time.
module tb_spi_speed;
 reg clk=0,rst=1,req=0;always #10 clk=~clk;
 wire sck,ack;wire[7:0]rx;
 spi_master dut(.sys_clk(clk),.rst(rst),.nCS(),.DCLK(sck),.MOSI(),.MISO(1'b1),
  .CPOL(1'b0),.CPHA(1'b0),.nCS_ctrl(1'b0),.clk_div(16'd6),
  .wr_req(req),.wr_ack(ack),.data_in(8'haa),.data_out(rx));
 integer tick=0,last_edge=0,edges=0,first_tick,j;
 always @(posedge clk)begin
  tick=tick+1;
  if(!rst && dut.state==1)begin
   if(dut.clk_edge_cnt!=0 && tick-last_edge!=8)$fatal(1,"SPI half cycle changed");
   last_edge=tick;edges=edges+1;
  end
 end
 initial begin
  repeat(4)@(negedge clk);rst=0;first_tick=tick;
  for(j=0;j<512;j=j+1)begin
   @(negedge clk);req=1;wait(ack);@(negedge clk);
   if(rx!=8'hff)$fatal(1,"SPI sampled byte mismatch");
   req=0;wait(!ack);repeat(2)@(negedge clk);
  end
  if(edges!=8192)$fatal(1,"SPI edge count mismatch");
  $display("PASS SPI master timing: divider6, 8 sys clocks/half-cycle = 3.125MHz, 512 bytes in %0d sys clocks including handshake",tick-first_tick);
  $display("ESTIMATE only: eight BMP payloads at this master handshake rate = %0f seconds; excludes SD init/commands/token/FAT/SDRAM",(tick-first_tick)*7373232.0/512.0/50000000.0);
  $finish;
 end
 initial begin #5000000;$fatal(1,"SPI timeout");end
endmodule

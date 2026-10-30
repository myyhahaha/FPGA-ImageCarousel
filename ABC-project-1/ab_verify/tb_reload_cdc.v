`timescale 1ns/1ps
module tb_reload_cdc #(parameter real DST_HALF=10.0);
 reg sc=0,dc=0,rst=1,pulse=0;
 always #10 sc=~sc;
 initial begin #7.3;forever #(DST_HALF) dc=~dc;end
 wire out;
 ab_reload_cdc dut(.src_clk(sc),.dst_clk(dc),.rst(rst),.src_pulse(pulse),.dst_pulse(out));
 integer sent=0,received=0,i;reg old=0;
 always @(posedge sc or posedge rst) if(rst) sent=0;else if(pulse) sent=sent+1;
 always @(posedge dc or posedge rst) begin
   if(rst) begin received=0;old=0;end
   else begin
     if(out && old) $fatal(1,"reload pulse repeated across destination clocks");
     if(out) received=received+1;
     old=out;
   end
 end
 initial begin
   #103;rst=0;
   for(i=0;i<100;i=i+1) begin
     repeat(6+i%11) @(negedge sc);pulse=1;@(negedge sc);pulse=0;
   end
   repeat(10) @(negedge sc);
   if(sent!=100 || received!=100) $fatal(1,"reload events lost: %d/%d",sent,received);
   rst=1;#83;rst=0;repeat(10) @(negedge sc);
   if(received!=0) $fatal(1,"spurious reload after reset");
   $display("PASS reload CDC: 100 single-cycle events, dst half period %0.1f ns, independent phase, no loss/duplication/reset residue",DST_HALF);$finish;
 end
 initial begin #100000;$fatal(1,"CDC timeout");end
endmodule

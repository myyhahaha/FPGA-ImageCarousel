`timescale 1ns/1ps
module tb_brightness;
 `include "ab_verify/brightness_golden.svh"
 reg clk=0,rstn=0,enable=0,blank=0,up=1,down=1;always #12.5 clk=~clk;
 wire [3:0] level;
 abc_brightness_ctrl #(.DEBOUNCE_CYCLES(4)) dut(.clk(clk),.reset_n(rstn),.enable(enable),
  .frame_blank(blank),.key_brighter_n(up),.key_dimmer_n(down),.level(level));
 reg [11:0] rgb=0;reg[3:0] scale_level=4;wire[23:0] adjusted;
 abc_brightness_rgb color(.rgb(rgb),.level(scale_level),.adjusted(adjusted));
 integer old_level=4;reg allowed;
 always @(posedge clk)begin
  allowed=blank || !enable || !rstn;
  #1;if(rstn && level!=old_level && !allowed)$fatal(1,"brightness changed during active frame");
  old_level=level;
 end
 task ticks;input integer n;begin repeat(n)@(negedge clk);end endtask
 task apply;input integer wanted;
 begin blank=1;ticks(1);blank=0;ticks(1);if(level!=wanted)$fatal(1,"level=%0d wanted=%0d",level,wanted);end endtask
 task key;input brighter;
 begin if(brighter)up=0;else down=0;ticks(12);up=1;down=1;ticks(12);end endtask
 integer i,j,checks=0;
 initial begin
  ticks(3);rstn=1;ticks(3);
  key(1);if(level!=4 || dut.requested!=4)$fatal(1,"preload input changed default");
  enable=1;up=0;ticks(1);up=1;ticks(12);apply(4);
  up=0;ticks(30);if(dut.requested!=5 || level!=4)$fatal(1,"held key repeated or was applied before blank");
  apply(5);up=1;ticks(12);key(0);apply(4);
  repeat(10)key(1);apply(8);key(1);apply(8);
  repeat(20)key(0);apply(0);key(0);apply(0);
  up=0;down=0;ticks(12);up=1;down=1;ticks(12);apply(0);
  enable=0;ticks(2);if(level!=4)$fatal(1,"disabled output not default");
  enable=1;key(1);apply(5);rstn=0;ticks(2);rstn=1;ticks(3);apply(4);
  for(i=0;i<=8;i=i+1)begin
   scale_level=i;
   for(j=0;j<4096;j=j+1)begin
    rgb=j;#1;
    if(adjusted!==gold_brightness(rgb,i))$fatal(1,"RGB scale mismatch level=%0d rgb=%h got=%h expected=%h",i,rgb,adjusted,gold_brightness(rgb,i));
    checks=checks+1;
   end
  end
  $display("PASS brightness: debounce/held/simultaneous keys, preload ignored, saturation/reset, frame-atomic application; %0d RGB444 x level vectors, exact default passthrough and black preservation",checks);
  $finish;
 end
 initial begin #1000000;$fatal(1,"brightness timeout");end
endmodule

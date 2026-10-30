`timescale 1ns/1ps
// Pixel-clock-domain keys: 20 ms debounce at 40 MHz, one event per press.
// Level 0..8 represents 50%, 62.5%, ... 150%; power-on level 4 is 100%.
module abc_brightness_ctrl #(parameter integer DEBOUNCE_CYCLES=800000)(
 input clk,reset_n,enable,frame_blank,key_brighter_n,key_dimmer_n,
 output reg [3:0] level
);
 reg [1:0] up_sync,down_sync;
 reg up_stable,down_stable,up_old,down_old;
 reg [19:0] up_count,down_count;
 reg [3:0] requested;
 reg up_armed,down_armed;
 wire up_event=up_armed && up_old && !up_stable;
 wire down_event=down_armed && down_old && !down_stable;
 always @(posedge clk or negedge reset_n)begin
  if(!reset_n)begin
   up_sync<=3;down_sync<=3;up_stable<=1;down_stable<=1;
   up_old<=1;down_old<=1;up_count<=0;down_count<=0;
  end else begin
   up_sync<={up_sync[0],key_brighter_n};down_sync<={down_sync[0],key_dimmer_n};
   up_old<=up_stable;down_old<=down_stable;
   if(up_sync[1]==up_stable)up_count<=0;
   else if(up_count==DEBOUNCE_CYCLES-1)begin up_stable<=up_sync[1];up_count<=0;end
   else up_count<=up_count+1'b1;
   if(down_sync[1]==down_stable)down_count<=0;
   else if(down_count==DEBOUNCE_CYCLES-1)begin down_stable<=down_sync[1];down_count<=0;end
   else down_count<=down_count+1'b1;
  end
 end
 always @(posedge clk or negedge reset_n)begin
  if(!reset_n)begin requested<=4;level<=4;up_armed<=0;down_armed<=0;end
  else if(!enable)begin requested<=4;level<=4;up_armed<=0;down_armed<=0;end
  else begin
   if(up_stable && up_sync[1])up_armed<=1;
   if(down_stable && down_sync[1])down_armed<=1;
   if(up_event && !down_event && requested<8)requested<=requested+1'b1;
   else if(down_event && !up_event && requested>0)requested<=requested-1'b1;
   // Keep the applied gain constant throughout every active frame.
   if(frame_blank)level<=requested;
  end
 end
endmodule

// Brightness is applied after the existing crossfade, before OSD composition.
// RGB444 * gain/8 becomes RGB888 exactly: nibble * 16 * gain/8 = product * 2.
// This adds no pipeline latency. Black stays black; over-range values saturate.
module abc_brightness_rgb(input [11:0] rgb,input [3:0] level,output [23:0] adjusted);
 wire [3:0] gain=level+4'd4;
 function [7:0] scale;
  input [3:0] component,g;
  reg [7:0] product;
  begin product=component*g;scale=product[7] ? 8'hff:{product[6:0],1'b0};end
 endfunction
 assign adjusted={scale(rgb[11:8],gain),scale(rgb[7:4],gain),scale(rgb[3:0],gain)};
endmodule

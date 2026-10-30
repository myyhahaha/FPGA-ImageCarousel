// Independent percentage-domain reference, separate from the nibble/gain RTL.
 function [23:0] gold_brightness;
 input [11:0] pixel;input integer level;
 integer c,value,percent_twice;
 begin
  percent_twice=100+25*level;gold_brightness=0;
  for(c=0;c<3;c=c+1)begin
   value=(pixel[c*4+:4]*16)*percent_twice/200;
   if(value>255)value=255;
   gold_brightness[c*8+:8]=value;
  end
 end endfunction

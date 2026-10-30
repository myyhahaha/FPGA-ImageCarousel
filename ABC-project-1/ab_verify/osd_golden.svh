// Untimed mathematical scoreboard. Glyph data comes from the raster assets,
// independent of the synchronous packed ROM used by the design.
 reg[9:0]gold_wave[0:639];
 reg[3:0]gold_zh[0:4031],gold_digits[0:2639];
 initial begin
  $readmemh("ab_verify/results/osd_wave_levels.hex",gold_wave);
  $readmemh("ab_verify/results/osd_zh_pixels.hex",gold_zh);
  $readmemh("ab_verify/results/osd_digit_pixels.hex",gold_digits);
 end
 function[23:0]gold_mix;input[23:0]bg,fg;input integer alpha;integer c,value;
 begin for(c=0;c<3;c=c+1)begin
  value=(bg[c*8+:8]*(16-alpha)+fg[c*8+:8]*alpha+8)/16;
  gold_mix[c*8+:8]=value;
 end end endfunction
 function integer gold_coverage;input integer v;
 begin gold_coverage=v==15?16:v;end endfunction
 function[5:0]gold_name;input integer pos,y;integer glyph,col;reg dot;
 begin
  pos=pos%292;glyph=pos/28;col=pos%28;
  dot=pos>=242 && pos<=246 && y>=573 && y<=577 && !((pos==242 || pos==246)&&(y==573 || y==577));
  gold_name=0;
  if(dot)gold_name=6'd48;
  else if(glyph<7 && col<24)gold_name=gold_coverage(gold_zh[glyph*576+(y-563)*24+col]);
 end endfunction
 function gold_caption;input[7:0]ch;input integer row,col;reg[34:0]bits;
 begin
  case(ch)
   "T":bits=35'b11111_00100_00100_00100_00100_00100_00100;
   "E":bits=35'b11111_10000_10000_11110_10000_10000_11111;
   "A":bits=35'b01110_10001_10001_11111_10001_10001_10001;
   "M":bits=35'b10001_11011_10101_10101_10001_10001_10001;
   "R":bits=35'b11110_10001_10001_11110_10100_10010_10001;
   "U":bits=35'b10001_10001_10001_10001_10001_10001_01110;
   "N":bits=35'b10001_11001_11001_10101_10011_10011_10001;
   "I":bits=35'b11111_00100_00100_00100_00100_00100_11111;
   default:bits=0;
  endcase
  gold_caption=bits[34-row*5-col];
 end endfunction
 function[23:0]gold_osd;
 input integer x,y;input[23:0]bg;input integer scroll;input[27:0]bcd;input de;
 integer a,da,slot,col,pos,fade,glyph,left,n,sy,hi,lo,dy;reg[9:0]wv;reg[23:0]matte;reg panel;reg[23:0]result,decor,ink;reg[5:0]av,bv;
 reg[63:0]caption;
 begin
  if(!de)gold_osd=0;
  else if(x>=80 && x<720 && y>=60 && y<540)gold_osd=bg;
  else begin
   panel=x<80 || x>=720 || y<60 || y>=540;matte=24'h16191b;
   if(y<44)matte=24'h1d2023;else if(y<48)matte=24'h1b1e21;else if(y<52)matte=24'h191c1f;else if(y<56)matte=24'h171a1d;
   if(y>=544)matte=24'h171a1d;if(y>=548)matte=24'h191c1f;
   if(y>=552)matte=24'h1b1e21;if(y>=556)matte=24'h1d2023;
   result=gold_mix(bg,matte,panel?12:0);
   decor=0;da=0;
   if(y==52 && x>=100 && x<680)begin decor=24'h718080;da=2;end
   if(x==520 && y>=17 && y<45)begin decor=24'h8d9394;da=3;end
   if(x>=702 && x<=706 && y>=32 && y<=36 && !((x==702 || x==706)&&(y==32 || y==36)))begin decor=24'h9bafa5;da=bcd[0]?8:12;end
   if(y==574 && x>=80 && x<720)begin decor=24'h657275;da=3;end
   result=gold_mix(result,decor,da);sy=y;y=y<60?y+540:-1;ink=24'hd8dedb;a=0;
   if(y>=551 && y<558)begin
    ink=24'h8f999e;
    for(n=0;n<2;n=n+1)begin
     left=n==0?100:552;caption=n==0?64'h5445414d20202020:"RUN TIME";
     for(slot=0;slot<(n==0?4:8);slot=slot+1)begin
      col=x-left-slot*6;
      if(col>=0 && col<5 && gold_caption(caption[(7-slot)*8+:8],y-551,col))a=10;
     end
    end
   end
   if(x>=100 && x<496 && y>=563 && y<587)begin
    pos=x-100+scroll/4;av=gold_name(pos,y);bv=gold_name(pos+1,y);
    ink=av[5] || bv[5]?24'ha8b6af:24'hd8dedb;
    a=(av[4:0]*(4-scroll%4)+bv[4:0]*(scroll%4)+2)/4;
    fade=16;if(x-100<fade)fade=x-100;if(495-x<fade)fade=495-x;
    a=(a*fade+8)/16;
   end
   if(x>=552 && x<678 && y>=565 && y<585)begin
    slot=(x-552)/14;col=(x-552)%14;
    if(col<12)begin
     case(slot)
      0:glyph=bcd[27:24];1:glyph=bcd[23:20];2:glyph=bcd[19:16];3:glyph=10;
      4:glyph=bcd[15:12];5:glyph=bcd[11:8];6:glyph=10;7:glyph=bcd[7:4];default:glyph=bcd[3:0];
     endcase
     a=gold_coverage(gold_digits[glyph*240+(y-565)*12+col]);ink=24'hbac3c4;
    end
   end
   if(x>=80 && x<720 && sy>=552 && sy<592)begin
    wv=gold_wave[x-80];hi=wv[9:5];lo=wv[4:0];dy=sy-574;ink=24'h91b4ad;a=0;
    if(wv!=0 && dy>=-hi && dy<=lo)a=(dy==-hi || dy==lo)?14:5;
   end
   gold_osd=gold_mix(result,ink,a);
  end
 end endfunction

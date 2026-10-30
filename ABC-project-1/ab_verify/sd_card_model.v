`timescale 1ns/1ps
// Synthetic FAT32 card with IMAGE1.BMP .. IMAGE8.BMP, all 640x480 BMP24.
// Sector transactions replace SPI pins; real FAT32/header/BMP RTL is exercised.
module sd_card_top #(parameter SPI_LOW_SPEED_DIV=248,SPI_HIGH_SPEED_DIV=6,BYTE_CYCLES=1)(
 input clk,rst,output SD_nCS,SD_DCLK,SD_MOSI,input SD_MISO,
 output reg sd_init_done=0,input sd_sec_read,input [31:0] sd_sec_read_addr,
 output reg [7:0] sd_sec_read_data=0,output reg sd_sec_read_data_valid=0,
 output reg sd_sec_read_end=0,input sd_sec_write,input [31:0] sd_sec_write_addr,
 input [7:0] sd_sec_write_data,output sd_sec_write_data_req,sd_sec_write_end
);
 assign {SD_nCS,SD_DCLK,SD_MOSI}=3'b100;
 assign {sd_sec_write_data_req,sd_sec_write_end}=0;
 integer byte_wait=0;
`ifdef REAL_MUSIC
 `include "ab_verify/results/music_test_config.vh"
 reg[7:0]music_bytes[0:MUSIC_BYTES-1];
 initial $readmemh("ab_verify/results/music_bytes.hex",music_bytes);
`endif
 localparam DATA_LBA=2080,FILE_SIZE=921654;
 integer init_count=0,count=0,lba=0,card_image=0,sector_offset=0,k;
 reg active=0;
`ifdef REAL_BMPS
 reg [7:0] file_bytes[0:8*921654-1];
 initial $readmemh("ab_verify/results/bmp_bytes.hex",file_bytes);
`endif
 function [7:0] value;
   input integer b;
   integer pos,entry,off,cl,wordv,pix,x,y,component;
   begin
     value=0;
     if(lba==0) begin
       case(b)
         12:value=2;13:value=128;14:value=32;16:value=2;
         35:value=1;37:value=4;44:value=2;
         82:value="F";83:value="A";84:value="T";85:value="3";86:value="2";
         510:value=8'h55;511:value=8'hAA;
       endcase
     end else if(lba==DATA_LBA) begin
       entry=b/32;off=b%32;
       if(entry<8) begin
         case(off)
           0:value="I";1:value="M";2:value="A";3:value="G";4:value="E";
           5:value="1"+entry;6,7:value=" ";8:value="B";9:value="M";10:value="P";
           11:value=8'h20;26:value=10+entry*32;
           28,29,30,31:value=(FILE_SIZE >> ((off-28)*8)) & 255;
         endcase
       end
`ifdef REAL_MUSIC
       if(entry==8)begin
        case(off)
         0:value="M";1:value="U";2:value="S";3:value="I";4:value="C";5,6,7:value=" ";
         8:value="W";9:value="A";10:value="V";11:value=8'h20;26:value=8'he8;27:value=3;
         28,29,30,31:value=(MUSIC_BYTES>>((off-28)*8))&255;
        endcase
       end
`endif
     end else if(lba>=32 && lba<1056) begin
       cl=(lba-32)*128+b/4;
       wordv=cl+1;
       if(cl==2 || (cl>=10 && (cl-10)%32==14)) wordv=32'h0fffffff;
`ifdef REAL_MUSIC
       if(cl>=1000 && (cl-1000)%3==0)wordv=cl+3;
`endif
       value=(wordv >> ((b%4)*8)) & 255;
`ifdef REAL_MUSIC
     end else if(lba>=DATA_LBA+998*128)begin
       cl=(lba-DATA_LBA)/128+2;
       if((cl-1000)%3==0)begin
        pos=((cl-1000)/3)*65536+((lba-DATA_LBA)%128)*512+b;
        if(pos<MUSIC_BYTES)value=music_bytes[pos];
       end
`endif
     end else if(card_image!=0) begin
       pos=sector_offset*512+b;
`ifdef REAL_BMPS
       if(pos<FILE_SIZE) value=file_bytes[(card_image-1)*FILE_SIZE+pos];
`else
       if(pos<54) begin
         case(pos)
           0:value="B";1:value="M";
           2,3,4,5:value=(FILE_SIZE >> ((pos-2)*8)) & 255;
           10:value=54;14:value=40;18:value=8'h80;19:value=2;
           22:value=8'hE0;23:value=1;26:value=1;28:value=24;
         endcase
       end else begin
         pix=(pos-54)/3;component=(pos-54)%3;x=pix%640;y=pix/640;
         case(component)
           0:value=((y+card_image*3)%16)*16;1:value=((x+card_image*5)%16)*16;2:value=((card_image+x/16+y/16)%16)*16;
         endcase
       end
`endif
     end
   end
 endfunction
 always @(posedge clk) begin
   sd_sec_read_data_valid<=0;sd_sec_read_end<=0;
   if(rst) begin init_count<=0;sd_init_done<=0;active<=0;count<=0;end
   else begin
     if(init_count<30) init_count<=init_count+1;
     sd_init_done<=init_count>=20;
     if(sd_sec_read) begin
       if(active) $fatal(1,"overlapping SD commands");
       lba=sd_sec_read_addr;count<=0;byte_wait<=0;active<=1;card_image=0;sector_offset=0;
       for(k=1;k<=8;k=k+1) begin
         if(lba>=DATA_LBA+(8+(k-1)*32)*128 && lba<DATA_LBA+(8+(k-1)*32)*128+1801) begin
           card_image=k;sector_offset=lba-(DATA_LBA+(8+(k-1)*32)*128);
         end
       end
     end else if(active && byte_wait<BYTE_CYCLES-1)byte_wait<=byte_wait+1;
     else if(active) begin
       byte_wait<=0;
       if(count<512) begin
         sd_sec_read_data<=value(count);sd_sec_read_data_valid<=1;count<=count+1;
       end else begin active<=0;sd_sec_read_end<=1;end
     end
   end
 end
endmodule

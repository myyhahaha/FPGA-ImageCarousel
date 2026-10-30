`timescale 1ns/1ps
module abc_tb_music_file;
 `include "ab_verify/results/music_test_config.vh"
 reg clk=0,rst=1;always #5 clk=~clk;
 wire fq,sq,found,find_error,stream_error,pcm_valid;wire[31:0]flba,slba,fc,fs,loops;wire[15:0]pcm;
 wire req,valid,ending;wire[31:0]lba;wire iv,ie,av,ae;reg iq=0;reg[31:0]ilba=1;
 reg[7:0]data=0;reg raw_valid=0,raw_end=0;wire raw_req;wire[31:0]raw_lba;
 reg[7:0]bytes[0:MUSIC_BYTES-1];reg[15:0]gold[0:MUSIC_SAMPLES-1];
 initial begin $readmemh("ab_verify/results/music_bytes.hex",bytes);$readmemh("ab_verify/results/music_pcm.hex",gold);end
 abc_wav_find finder(.clk(clk),.rst(rst),.mounted(!rst),.fat_lba(32'd32),.data_lba(32'd2080),.root_cluster(32'd2),.spc(8'd4),
 .read_req(fq),.read_lba(flba),.read_data(data),.byte_valid(av),.read_end(ae),.done(found),.error(find_error),.error_code(),.file_cluster(fc),.file_size(fs));
 abc_wav_stream stream(.clk(clk),.rst(rst),.start(found),.need_data(1'b1),.file_cluster(fc),.file_size(fs),.fat_lba(32'd32),.data_lba(32'd2080),.spc(8'd4),
 .read_req(sq),.read_lba(slba),.read_data(data),.byte_valid(av),.read_end(ae),.pcm_data(pcm),.pcm_valid(pcm_valid),.pcm_ready(ready),.error(stream_error),.error_code(),.loop_count(loops));
 abc_sd_sector_arbiter arb(.clk(clk),.rst(rst),.image_req(iq),.image_lba(ilba),.audio_req(found?sq:fq),.audio_lba(found?slba:flba),.audio_urgent(1'b1),
 .card_req(raw_req),.card_lba(raw_lba),.card_valid(raw_valid),.card_end(raw_end),.image_valid(iv),.image_end(ie),.audio_valid(av),.audio_end(ae));
 integer tick=0,n=0,read_lba=0,pos=0,image_bytes=0,image_sectors=0,checked=0,read_sectors=0;
 reg active=0,waiting_image=0;
 wire ready=(tick%11!=0 && tick%17!=0);
 function[7:0]card_byte;input integer a,b;integer cl,wordv,off,sector_index,file_index;
 begin
  card_byte=0;
  if(a>=32 && a<1056)begin
   cl=(a-32)*128+b/4;wordv=32'h0fffffff;
   if(cl==2)wordv=6;
   else if(cl>=1000 && (cl-1000)%3==0)wordv=cl+3;
   card_byte=(wordv>>(8*(b%4)))&255;
  end else if(a>=2080 && a<2084)begin
   // Full first root cluster: deleted entries, no premature 0x00 terminator.
   card_byte=(b%32==0)?8'he5:8'h20;
  end else if(a==2096)begin
   off=b%32;
   if(b<32)case(off)
    0:card_byte="M";1:card_byte="U";2:card_byte="S";3:card_byte="I";4:card_byte="C";5,6,7:card_byte=" ";8:card_byte="W";9:card_byte="A";10:card_byte="V";
    11:card_byte=8'h20;26:card_byte=8'he8;27:card_byte=3;
    28,29,30,31:card_byte=(MUSIC_BYTES>>((off-28)*8))&255;
   endcase
  end else if(a>=6072)begin
   cl=(a-2080)/4+2;sector_index=(a-2080)%4;
   if(cl>=1000 && (cl-1000)%3==0)begin
    file_index=((cl-1000)/3*4+sector_index)*512+b;
    if(file_index<MUSIC_BYTES)card_byte=bytes[file_index];
   end
  end else if(a==1)card_byte=8'h5a;
 end endfunction
 always @(posedge clk)begin
  tick<=tick+1;iq<=0;raw_valid<=0;raw_end<=0;
  if(!rst)begin
   if(!waiting_image)begin iq<=1;waiting_image<=1;end
   if(iv)begin if(data!==8'h5a)$fatal(1,"sector ownership leaked to image");image_bytes=image_bytes+1;end
   if(ie)begin if(image_bytes!=512)$fatal(1,"image sector truncated");image_bytes=0;image_sectors=image_sectors+1;waiting_image<=0;end
   if(raw_req)begin if(active)$fatal(1,"overlapping physical sector requests");active<=1;pos<=0;read_lba<=raw_lba;read_sectors=read_sectors+1;end
   if(active)begin
    if(pos<512)begin raw_valid<=1;data<=card_byte(read_lba,pos);pos<=pos+1;end
    else begin active<=0;raw_end<=1;end
   end
   if(find_error || stream_error)$fatal(1,"music file read failed state=%0d",stream.state);
   if(pcm_valid && ready)begin
    if(pcm!==gold[checked%MUSIC_SAMPLES])$fatal(1,"song sample %0d got=%h expected=%h",checked,pcm,gold[checked%MUSIC_SAMPLES]);
    checked=checked+1;
    if(checked==MUSIC_SAMPLES+256)begin
     if(loops!=1 || image_sectors<100)$fatal(1,"loop/fairness coverage incomplete");
     $display("PASS full MUSIC.WAV: %0d exact PCM frames (entire user track + 256 loop frames), fragmented root and data clusters, random backpressure, %0d image sectors interleaved, %0d total card sectors, no lost/duplicated bytes",checked,image_sectors,read_sectors);$finish;
    end
   end
  end
 end
 initial begin repeat(8)@(negedge clk);rst=0;end
 initial begin #2000000000;$fatal(1,"full music timeout checked=%0d",checked);end
endmodule

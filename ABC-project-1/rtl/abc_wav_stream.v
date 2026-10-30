// Canonical RIFF PCM16 mono 48000 Hz, 44-byte header; prepared by music tool.
// Full sector buffering, FAT chaining, backpressure, exact data length and looping.
module abc_wav_stream(
 input clk,rst,start,need_data,input[31:0]file_cluster,file_size,fat_lba,data_lba,input[7:0]spc,
 output reg read_req,output reg[31:0]read_lba,input[7:0]read_data,input byte_valid,read_end,
 output reg[15:0]pcm_data,output reg pcm_valid,input pcm_ready,
 output reg error,output reg[7:0]error_code,output reg[31:0]loop_count
);
 localparam WAIT=0,REQ=1,CAP=2,DRAIN=3,NEXT=4,FREQ=5,FCAP=6,FCHECK=7,FAIL=8;
 reg[3:0]state;reg[7:0]mem[0:511];reg[9:0]count,rd_ptr;
 reg[31:0]cluster,file_pos,data_size,remaining,fat_entry,hops;reg[7:0]sector,low_byte;reg high_byte,header_bad;
 function[2:0]shift_spc;input[7:0]n;
 begin case(n)1:shift_spc=0;2:shift_spc=1;4:shift_spc=2;8:shift_spc=3;16:shift_spc=4;32:shift_spc=5;64:shift_spc=6;default:shift_spc=7;endcase end endfunction
 function header_match;input[5:0]p;input[7:0]v;
 begin case(p)
  0:header_match=v=="R";1:header_match=v=="I";2,3:header_match=v=="F";
  8:header_match=v=="W";9:header_match=v=="A";10:header_match=v=="V";11:header_match=v=="E";
  12:header_match=v=="f";13:header_match=v=="m";14:header_match=v=="t";15:header_match=v==" ";
  16,34:header_match=v==16;20,22,30:header_match=v==1;24:header_match=v==8'h80;25:header_match=v==8'hbb;29:header_match=v==8'h77;32:header_match=v==2;
  17,18,19,21,23,26,27,28,31,33,35:header_match=v==0;
  36:header_match=v=="d";37:header_match=v=="a";38:header_match=v=="t";39:header_match=v=="a";
  default:header_match=1;
 endcase end endfunction
 wire[7:0]current_byte=mem[rd_ptr[8:0]];
 wire[31:0]declared_size={current_byte,data_size[23:0]};
 wire[31:0]next_cluster=fat_entry & 32'h0fffffff;
 always @(posedge clk or posedge rst)begin
  if(rst)begin state<=WAIT;read_req<=0;read_lba<=0;count<=0;rd_ptr<=0;cluster<=0;file_pos<=0;data_size<=0;remaining<=0;fat_entry<=0;hops<=0;sector<=0;low_byte<=0;high_byte<=0;header_bad<=0;pcm_data<=0;pcm_valid<=0;error<=0;error_code<=0;loop_count<=0;end
  else begin
   read_req<=0;
   case(state)
    WAIT:if(start)begin
     if(file_cluster<2 || file_size<46 || spc==0)begin error<=1;error_code<=8'hF4;state<=FAIL;end
     else begin cluster<=file_cluster;sector<=0;file_pos<=0;header_bad<=0;read_lba<=data_lba+((file_cluster-2)<<shift_spc(spc));state<=REQ;end
    end
    REQ:if(need_data)begin count<=0;read_req<=1;state<=CAP;end
    CAP:begin
     if(byte_valid && count<512)begin mem[count[8:0]]<=read_data;count<=count+1'b1;end
     if(read_end)begin if(count!=512)begin error<=1;error_code<=8'hF5;state<=FAIL;end else begin rd_ptr<=0;state<=DRAIN;end end
    end
    DRAIN:begin
     if(pcm_valid)begin if(pcm_ready)pcm_valid<=0;end
     else if(file_pos>=44 && remaining==0)begin
      // Do not consume directory padding or require a contiguous next extent.
      loop_count<=loop_count+1'b1;hops<=0;cluster<=file_cluster;sector<=0;file_pos<=0;header_bad<=0;high_byte<=0;
      read_lba<=data_lba+((file_cluster-2)<<shift_spc(spc));state<=REQ;
     end else if(rd_ptr==512)state<=NEXT;
     else if(file_pos<44)begin
      if(!header_match(file_pos[5:0],current_byte))header_bad<=1;
      case(file_pos[5:0])40:data_size[7:0]<=current_byte;41:data_size[15:8]<=current_byte;42:data_size[23:16]<=current_byte;
       43:begin
        data_size[31:24]<=current_byte;remaining<=declared_size;
        if(header_bad || declared_size<2 || declared_size[0] || declared_size>file_size-44)begin error<=1;error_code<=8'hF6;state<=FAIL;end
       end
      endcase
      file_pos<=file_pos+1'b1;rd_ptr<=rd_ptr+1'b1;
     end else begin
      if(!high_byte)low_byte<=current_byte;
      else begin pcm_data<={current_byte,low_byte};pcm_valid<=1;end
      high_byte<=~high_byte;file_pos<=file_pos+1'b1;remaining<=remaining-1'b1;rd_ptr<=rd_ptr+1'b1;
     end
    end
    NEXT:if(sector+1<spc)begin sector<=sector+1'b1;read_lba<=read_lba+1'b1;state<=REQ;end
     else begin read_lba<=fat_lba+(cluster>>7);state<=FREQ;end
    FREQ:begin count<=0;fat_entry<=0;read_req<=1;state<=FCAP;end
    FCAP:begin
     if(byte_valid && count<512)begin
      if(count[8:2]==cluster[6:0])case(count[1:0])0:fat_entry[7:0]<=read_data;1:fat_entry[15:8]<=read_data;2:fat_entry[23:16]<=read_data;3:fat_entry[31:24]<=read_data;endcase
      count<=count+1'b1;
     end
     if(read_end)begin if(count!=512)begin error<=1;error_code<=8'hF5;state<=FAIL;end else state<=FCHECK;end
    end
    FCHECK:if(next_cluster<2 || next_cluster>=32'h0ffffff8 || hops>32'd1000000)begin error<=1;error_code<=8'hF7;state<=FAIL;end
     else begin cluster<=next_cluster;sector<=0;hops<=hops+1'b1;read_lba<=data_lba+((next_cluster-2)<<shift_spc(spc));state<=REQ;end
    default:begin state<=FAIL;pcm_valid<=0;end
   endcase
  end
 end
endmodule

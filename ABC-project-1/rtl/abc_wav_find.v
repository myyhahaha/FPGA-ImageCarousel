// Find MUSIC.WAV in the already mounted FAT32 root, including fragmented roots.
// Reuses the image reader's validated BPB instead of mounting the same card twice.
module abc_wav_find(
 input clk,rst,mounted,input[31:0]fat_lba,data_lba,root_cluster,input[7:0]spc,
 output reg read_req,output reg[31:0]read_lba,input[7:0]read_data,input byte_valid,read_end,
 output reg done,error,output reg[7:0]error_code,output reg[31:0]file_cluster,file_size
);
 localparam WAIT=0,REQ=1,CAP=2,CHECK=3,FREQ=4,FCAP=5,FCHECK=6,STOP=7;
 reg[2:0]state;reg[9:0]count;reg[31:0]cluster,entry_cluster,entry_size,found_cluster,found_size,fat_entry;
 reg[7:0]sector,first,attr;reg match,found,ended;reg[15:0]hops;
 function[2:0]shift_spc;input[7:0]n;
 begin case(n)1:shift_spc=0;2:shift_spc=1;4:shift_spc=2;8:shift_spc=3;16:shift_spc=4;32:shift_spc=5;64:shift_spc=6;default:shift_spc=7;endcase end endfunction
 function[7:0]name_char;input[3:0]n;
 begin case(n)0:name_char="M";1:name_char="U";2:name_char="S";3:name_char="I";4:name_char="C";5,6,7:name_char=" ";8:name_char="W";9:name_char="A";default:name_char="V";endcase end endfunction
 wire[31:0]next_cluster=fat_entry & 32'h0fffffff;
 always @(posedge clk or posedge rst)begin
  if(rst)begin state<=WAIT;count<=0;cluster<=0;entry_cluster<=0;entry_size<=0;found_cluster<=0;found_size<=0;fat_entry<=0;sector<=0;first<=0;attr<=0;match<=0;found<=0;ended<=0;hops<=0;read_req<=0;read_lba<=0;done<=0;error<=0;error_code<=0;file_cluster<=0;file_size<=0;end
  else begin
   read_req<=0;
   case(state)
    WAIT:if(mounted)begin cluster<=root_cluster;sector<=0;read_lba<=data_lba+((root_cluster-2)<<shift_spc(spc));state<=REQ;end
    REQ:begin count<=0;found<=0;ended<=0;match<=0;entry_cluster<=0;entry_size<=0;read_req<=1;state<=CAP;end
    CAP:begin
     if(byte_valid && count<512)begin
      count<=count+1'b1;
      if(count[4:0]==0)begin first<=read_data;match<=read_data==name_char(0);attr<=0;entry_cluster<=0;entry_size<=0;if(read_data==0)ended<=1;end
      else if(count[4:0]<=10 && read_data!=name_char(count[3:0]))match<=0;
      case(count[4:0])
       11:attr<=read_data;20:entry_cluster[23:16]<=read_data;21:entry_cluster[31:24]<=read_data;
       26:entry_cluster[7:0]<=read_data;27:entry_cluster[15:8]<=read_data;
       28:entry_size[7:0]<=read_data;29:entry_size[15:8]<=read_data;30:entry_size[23:16]<=read_data;
       31:if(match && !ended && first!=8'he5 && attr!=8'h0f && (attr & 8'h18)==0)begin found<=1;found_cluster<=entry_cluster;found_size<={read_data,entry_size[23:0]};end
      endcase
     end
     if(read_end)begin if(count!=512)begin error<=1;error_code<=8'hF1;state<=STOP;end else state<=CHECK;end
    end
    CHECK:begin
     if(found)begin
      if(found_cluster<2 || found_size<46)begin error<=1;error_code<=8'hF2;end
      else begin file_cluster<=found_cluster;file_size<=found_size;done<=1;end
      state<=STOP;
     end else if(ended)begin error<=1;error_code<=8'hF3;state<=STOP;end
     else if(sector+1<spc)begin sector<=sector+1'b1;read_lba<=read_lba+1'b1;state<=REQ;end
     else begin read_lba<=fat_lba+(cluster>>7);state<=FREQ;end
    end
    FREQ:begin count<=0;fat_entry<=0;read_req<=1;state<=FCAP;end
    FCAP:begin
     if(byte_valid && count<512)begin
      if(count[8:2]==cluster[6:0])case(count[1:0])0:fat_entry[7:0]<=read_data;1:fat_entry[15:8]<=read_data;2:fat_entry[23:16]<=read_data;3:fat_entry[31:24]<=read_data;endcase
      count<=count+1'b1;
     end
     if(read_end)begin if(count!=512)begin error<=1;error_code<=8'hF1;state<=STOP;end else state<=FCHECK;end
    end
    FCHECK:if(next_cluster<2 || next_cluster>=32'h0ffffff8 || hops==16'hffff)begin error<=1;error_code<=8'hF3;state<=STOP;end
     else begin cluster<=next_cluster;sector<=0;hops<=hops+1'b1;read_lba<=data_lba+((next_cluster-2)<<shift_spc(spc));state<=REQ;end
    default:state<=STOP;
   endcase
  end
 end
endmodule

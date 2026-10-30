// Member B stage-1 FAT32 + BMP header reader, streaming implementation.
// No 512-byte register array, variable divider, or parallel directory scan.
// SDHC/SDXC block LBA; FAT32 MBR partition #1 or FAT32 superfloppy.
// 512-byte sectors; 8.3 short name in FAT32 root directory.
// 640x480, 24-bit BI_RGB BMP header verification.
module fat32_bmp_reader #(
    parameter [87:0] TARGET_NAME = "IMAGE   BMP"
)(
    input wire clk,
    input wire rst,
    input wire init_done,
    input wire [3:0] file_idx,      // 1..8 -> IMAGE1.BMP .. IMAGE8.BMP
    input wire restart,             // 高有效(50MHz 域): 回到目录重扫当前 file_idx
    output reg read_req,
    output reg [31:0] read_lba,
    input wire [7:0] read_data,
    input wire byte_valid,
    input wire read_end,
    output reg done,
    output reg error,
    output reg [7:0] error_code,
    output reg [31:0] file_size,
    output reg [31:0] file_cluster,
    output reg [31:0] width,
    output reg [31:0] height,
    output reg [31:0] pixel_offset,
    output reg [15:0] bits_per_pixel,
    output reg [31:0] compression,
    output reg [31:0] first_data_lba,
    output reg [31:0] fat_base_lba, data_base_lba,
    output wire [31:0] root_cluster_out,
    output reg [7:0] sectors_per_cluster
);
    localparam [2:0] ST_WAIT=0, ST_REQ=1, ST_CAPTURE=2,
                     ST_CHECK=3, ST_DONE=4, ST_FAIL=5;
    localparam [2:0] PH_PROBE=0, PH_BOOT=1, PH_DIR=2,
                     PH_FAT=3, PH_BMP=4;
    assign root_cluster_out=bpb_root_cluster;
    reg [2:0] state;
    reg [2:0] phase;
    reg [9:0] byte_index;
    reg [7:0] sig0, sig1;

    // MBR / VBR recognition
    reg probe_label_ok;
    reg [7:0] partition_type;
    reg [31:0] mbr_start;
    reg [31:0] part_lba;

    // BPB fields
    reg [15:0] bpb_bytes_per_sector;
    reg [7:0]  bpb_spc, bpb_num_fats;
    reg [15:0] bpb_reserved, bpb_root_entries;
    reg [31:0] bpb_total_sectors, bpb_fat_size, bpb_root_cluster;
    reg [2:0]  spc_shift;
    reg [31:0] fat_lba, data_lba, cluster_count;

    // FAT32 root-directory traversal
    reg [31:0] current_cluster;
    reg [7:0] sector_in_cluster;
    reg [15:0] cluster_hops;
    reg [7:0] dir_first, dir_attr;
    reg dir_match, dir_ended, dir_found;
    reg [31:0] dir_cluster, dir_size;
    reg [31:0] found_cluster, found_size;
    reg [31:0] fat_value;

    // BMP header (first sector of the file)
    reg [7:0] bmp_b, bmp_m;
    reg [31:0] bmp_off, bmp_dib_size, bmp_w, bmp_h, bmp_compression;
    reg [15:0] bmp_planes, bmp_bpp;

    // 8.3 短名: IMAGEx  BMP (x = '1'..'8' 由 file_idx 决定)
    function [7:0] name_char;
        input [3:0] n;
        begin
            case(n)
              4'd0: name_char="I";
              4'd1: name_char="M";
              4'd2: name_char="A";
              4'd3: name_char="G";
              4'd4: name_char="E";
              4'd5: name_char=8'h30 + file_idx;   // '1' (0x31) .. '8' (0x38)
              4'd6: name_char=" ";
              4'd7: name_char=" ";
              4'd8: name_char="B";
              4'd9: name_char="M";
              4'd10: name_char="P";
              default: name_char=8'h00;
            endcase
        end
    endfunction

    function [2:0] shift_spc;
      input [7:0] v;
      begin
        case(v)
          8'd1: shift_spc=0;
          8'd2: shift_spc=1;
          8'd4: shift_spc=2;
          8'd8: shift_spc=3;
          8'd16: shift_spc=4;
          8'd32: shift_spc=5;
          8'd64: shift_spc=6;
          8'd128: shift_spc=7;
          default: shift_spc=0;
        endcase
      end
    endfunction

    wire [31:0] fat_region = (bpb_num_fats==8'd2) ?
                              (bpb_fat_size << 1) : bpb_fat_size;
    wire [31:0] data_lba_calc = part_lba + bpb_reserved + fat_region;
    wire [31:0] overhead = {16'd0,bpb_reserved} + fat_region;
    wire [31:0] fat_next = fat_value & 32'h0fffffff;

    always @(posedge clk or posedge rst) begin
      if(rst) begin
        state<=ST_WAIT; phase<=PH_PROBE;
        read_req<=0; read_lba<=0; byte_index<=0;
        done<=0; error<=0; error_code<=0;
        sig0<=0; sig1<=0; probe_label_ok<=0;
        partition_type<=0; mbr_start<=0; part_lba<=0;
        bpb_bytes_per_sector<=0; bpb_spc<=0; bpb_num_fats<=0;
        bpb_reserved<=0; bpb_root_entries<=0;
        bpb_total_sectors<=0; bpb_fat_size<=0; bpb_root_cluster<=0;
        spc_shift<=0; fat_lba<=0; data_lba<=0; cluster_count<=0;
        current_cluster<=0; sector_in_cluster<=0; cluster_hops<=0;
        dir_first<=0; dir_attr<=0; dir_match<=0;
        dir_ended<=0; dir_found<=0;
        dir_cluster<=0; dir_size<=0;
        found_cluster<=0; found_size<=0; fat_value<=0;
        bmp_b<=0; bmp_m<=0; bmp_off<=0; bmp_dib_size<=0;
        bmp_w<=0; bmp_h<=0; bmp_planes<=0; bmp_bpp<=0;
        bmp_compression<=0;
        file_size<=0; file_cluster<=0; width<=0; height<=0;
        pixel_offset<=0; bits_per_pixel<=0; compression<=0;
        first_data_lba<=0; fat_base_lba<=0; data_base_lba<=0; sectors_per_cluster<=0;
      end else begin
        // ★ 手动切图重载: 仅在本轮已结束(DONE/FAIL)时受理; 保留已识别的 BPB/分区
        //   参数, 直接回根目录按新 file_idx 重扫, 不必重读 MBR/VBR(加快切图)。
        if(restart && (state==ST_DONE || state==ST_FAIL)) begin
          done<=1'b0; error<=1'b0; error_code<=8'h00;
          file_size<=32'd0; file_cluster<=32'd0;
          width<=32'd0; height<=32'd0; pixel_offset<=32'd0;
          bits_per_pixel<=16'd0; compression<=32'd0; first_data_lba<=32'd0;
          current_cluster<=bpb_root_cluster;
          sector_in_cluster<=8'd0; cluster_hops<=16'd0;
          read_lba<=data_lba+((bpb_root_cluster-32'd2)<<spc_shift);
          phase<=PH_DIR; state<=ST_REQ;
        end else begin
        read_req<=1'b0;
        case(state)
          ST_WAIT: begin
            if(init_done) begin
              read_lba<=0;
              phase<=PH_PROBE;
              state<=ST_REQ;
            end
          end
          ST_REQ: begin
            byte_index<=0;
            sig0<=0; sig1<=0;
            if(phase==PH_PROBE) begin
              probe_label_ok<=1'b1;
              partition_type<=0; mbr_start<=0;
            end
            if(phase==PH_DIR) begin
              dir_found<=0; dir_ended<=0;
              dir_match<=0; dir_first<=0; dir_attr<=0;
              dir_cluster<=0; dir_size<=0;
              found_cluster<=0; found_size<=0;
            end
            if(phase==PH_FAT) fat_value<=0;
            if(phase==PH_BMP) begin
              bmp_b<=0; bmp_m<=0;
              bmp_off<=0; bmp_dib_size<=0;
              bmp_w<=0; bmp_h<=0;
              bmp_planes<=0; bmp_bpp<=0; bmp_compression<=0;
            end
            read_req<=1'b1;
            state<=ST_CAPTURE;
          end
          ST_CAPTURE: begin
            if(byte_valid) begin
              if(byte_index<10'd512) begin
                byte_index<=byte_index+10'd1;
                if(byte_index==10'd510) sig0<=read_data;
                if(byte_index==10'd511) sig1<=read_data;
                case(phase)
                  PH_PROBE: begin
                    case(byte_index)
                      10'd82: if(read_data!="F") probe_label_ok<=0;
                      10'd83: if(read_data!="A") probe_label_ok<=0;
                      10'd84: if(read_data!="T") probe_label_ok<=0;
                      10'd85: if(read_data!="3") probe_label_ok<=0;
                      10'd86: if(read_data!="2") probe_label_ok<=0;
                      10'd450: partition_type<=read_data;
                      10'd454: mbr_start[7:0]<=read_data;
                      10'd455: mbr_start[15:8]<=read_data;
                      10'd456: mbr_start[23:16]<=read_data;
                      10'd457: mbr_start[31:24]<=read_data;
                      default: ;
                    endcase
                  end
                  PH_BOOT: begin
                    case(byte_index)
                      10'd11: bpb_bytes_per_sector[7:0]<=read_data;
                      10'd12: bpb_bytes_per_sector[15:8]<=read_data;
                      10'd13: bpb_spc<=read_data;
                      10'd14: bpb_reserved[7:0]<=read_data;
                      10'd15: bpb_reserved[15:8]<=read_data;
                      10'd16: bpb_num_fats<=read_data;
                      10'd17: bpb_root_entries[7:0]<=read_data;
                      10'd18: bpb_root_entries[15:8]<=read_data;
                      10'd32: bpb_total_sectors[7:0]<=read_data;
                      10'd33: bpb_total_sectors[15:8]<=read_data;
                      10'd34: bpb_total_sectors[23:16]<=read_data;
                      10'd35: bpb_total_sectors[31:24]<=read_data;
                      10'd36: bpb_fat_size[7:0]<=read_data;
                      10'd37: bpb_fat_size[15:8]<=read_data;
                      10'd38: bpb_fat_size[23:16]<=read_data;
                      10'd39: bpb_fat_size[31:24]<=read_data;
                      10'd44: bpb_root_cluster[7:0]<=read_data;
                      10'd45: bpb_root_cluster[15:8]<=read_data;
                      10'd46: bpb_root_cluster[23:16]<=read_data;
                      10'd47: bpb_root_cluster[31:24]<=read_data;
                      default: ;
                    endcase
                  end
                  PH_DIR: begin
                    // One entry (32 bytes) is checked at a time.
                    if(byte_index[4:0]==5'd0) begin
                      dir_first<=read_data;
                      dir_match<=(read_data==name_char(4'd0));
                      dir_attr<=0;
                      dir_cluster<=0;
                      dir_size<=0;
                      if(read_data==8'h00) dir_ended<=1;
                    end else if(byte_index[4:0]<=5'd10) begin
                      if(read_data!=name_char(byte_index[3:0])) dir_match<=0;
                    end
                    case(byte_index[4:0])
                      5'd11: dir_attr<=read_data;
                      5'd20: dir_cluster[23:16]<=read_data;
                      5'd21: dir_cluster[31:24]<=read_data;
                      5'd26: dir_cluster[7:0]<=read_data;
                      5'd27: dir_cluster[15:8]<=read_data;
                      5'd28: dir_size[7:0]<=read_data;
                      5'd29: dir_size[15:8]<=read_data;
                      5'd30: dir_size[23:16]<=read_data;
                      5'd31: begin
                        dir_size[31:24]<=read_data;
                        if(!dir_found && !dir_ended && dir_match &&
                           dir_first!=8'h00 && dir_first!=8'hE5 &&
                           dir_attr!=8'h0f && (dir_attr & 8'h18)==0) begin
                          dir_found<=1;
                          found_cluster<=dir_cluster;
                          found_size<={read_data,dir_size[23:0]};
                        end
                      end
                      default: ;
                    endcase
                  end
                  PH_FAT: begin
                    if(byte_index[8:2]==current_cluster[6:0]) begin
                      case(byte_index[1:0])
                        2'd0: fat_value[7:0]<=read_data;
                        2'd1: fat_value[15:8]<=read_data;
                        2'd2: fat_value[23:16]<=read_data;
                        2'd3: fat_value[31:24]<=read_data;
                      endcase
                    end
                  end
                  PH_BMP: begin
                    case(byte_index)
                      10'd0: bmp_b<=read_data;
                      10'd1: bmp_m<=read_data;
                      10'd10: bmp_off[7:0]<=read_data;
                      10'd11: bmp_off[15:8]<=read_data;
                      10'd12: bmp_off[23:16]<=read_data;
                      10'd13: bmp_off[31:24]<=read_data;
                      10'd14: bmp_dib_size[7:0]<=read_data;
                      10'd15: bmp_dib_size[15:8]<=read_data;
                      10'd16: bmp_dib_size[23:16]<=read_data;
                      10'd17: bmp_dib_size[31:24]<=read_data;
                      10'd18: bmp_w[7:0]<=read_data;
                      10'd19: bmp_w[15:8]<=read_data;
                      10'd20: bmp_w[23:16]<=read_data;
                      10'd21: bmp_w[31:24]<=read_data;
                      10'd22: bmp_h[7:0]<=read_data;
                      10'd23: bmp_h[15:8]<=read_data;
                      10'd24: bmp_h[23:16]<=read_data;
                      10'd25: bmp_h[31:24]<=read_data;
                      10'd26: bmp_planes[7:0]<=read_data;
                      10'd27: bmp_planes[15:8]<=read_data;
                      10'd28: bmp_bpp[7:0]<=read_data;
                      10'd29: bmp_bpp[15:8]<=read_data;
                      10'd30: bmp_compression[7:0]<=read_data;
                      10'd31: bmp_compression[15:8]<=read_data;
                      10'd32: bmp_compression[23:16]<=read_data;
                      10'd33: bmp_compression[31:24]<=read_data;
                      default: ;
                    endcase
                  end
                  default: ;
                endcase
              end else begin
                error<=1; error_code<=8'hE1; state<=ST_FAIL;
              end
            end
            if(read_end && state==ST_CAPTURE) begin
              if(byte_index!=10'd512) begin
                error<=1; error_code<=8'hE1; state<=ST_FAIL;
              end else state<=ST_CHECK;
            end
          end
          ST_CHECK: begin
            case(phase)
              PH_PROBE: begin
                if(sig0!=8'h55 || sig1!=8'hAA) begin
                  error<=1; error_code<=8'hE2; state<=ST_FAIL;
                end else if(probe_label_ok) begin
                  part_lba<=0; read_lba<=0;
                  phase<=PH_BOOT; state<=ST_REQ;
                end else if((partition_type==8'h0b || partition_type==8'h0c) && mbr_start!=0) begin
                  part_lba<=mbr_start; read_lba<=mbr_start;
                  phase<=PH_BOOT; state<=ST_REQ;
                end else begin
                  error<=1; error_code<=8'hE3; state<=ST_FAIL;
                end
              end
              PH_BOOT: begin
                if(sig0!=8'h55 || sig1!=8'hAA ||
                   bpb_bytes_per_sector!=16'd512 ||
                   !(bpb_spc==1 || bpb_spc==2 || bpb_spc==4 || bpb_spc==8 ||
                     bpb_spc==16 || bpb_spc==32 || bpb_spc==64 || bpb_spc==128) ||
                   !(bpb_num_fats==1 || bpb_num_fats==2) ||
                   bpb_reserved==0 || bpb_root_entries!=0 ||
                   bpb_fat_size==0 || bpb_root_cluster<2 ||
                   bpb_total_sectors<=overhead) begin
                  error<=1; error_code<=8'hE4; state<=ST_FAIL;
                end else begin
                  spc_shift<=shift_spc(bpb_spc);
                  fat_lba<=part_lba+bpb_reserved;
                  fat_base_lba<=part_lba+bpb_reserved;
                  data_base_lba<=data_lba_calc;
                  sectors_per_cluster<=bpb_spc;
                  data_lba<=data_lba_calc;
                  cluster_count<=(bpb_total_sectors-overhead)>>shift_spc(bpb_spc);
                  current_cluster<=bpb_root_cluster;
                  sector_in_cluster<=0; cluster_hops<=0;
                  read_lba<=data_lba_calc+((bpb_root_cluster-32'd2)<<shift_spc(bpb_spc));
                  phase<=PH_DIR; state<=ST_REQ;
                end
              end
              PH_DIR: begin
                if(dir_found) begin
                  if(found_cluster<2 || found_size<54) begin
                    error<=1; error_code<=8'hE5; state<=ST_FAIL;
                  end else begin
                    file_cluster<=found_cluster;
                    file_size<=found_size;
                    read_lba<=data_lba+((found_cluster-32'd2)<<spc_shift);
                    phase<=PH_BMP; state<=ST_REQ;
                  end
                end else if(dir_ended) begin
                  error<=1; error_code<=8'hE6; state<=ST_FAIL;
                end else if(sector_in_cluster+8'd1 < bpb_spc) begin
                  sector_in_cluster<=sector_in_cluster+8'd1;
                  read_lba<=read_lba+32'd1;
                  phase<=PH_DIR; state<=ST_REQ;
                end else begin
                  read_lba<=fat_lba+(current_cluster>>7);
                  phase<=PH_FAT; state<=ST_REQ;
                end
              end
              PH_FAT: begin
                if(fat_next>=32'h0ffffff8) begin
                  error<=1; error_code<=8'hE6; state<=ST_FAIL;
                end else if(fat_next<2 || fat_next>=cluster_count+32'd2 ||
                            cluster_hops==16'hffff) begin
                  error<=1; error_code<=8'hE7; state<=ST_FAIL;
                end else begin
                  current_cluster<=fat_next;
                  read_lba<=data_lba+((fat_next-32'd2)<<spc_shift);
                  sector_in_cluster<=0;
                  cluster_hops<=cluster_hops+16'd1;
                  phase<=PH_DIR; state<=ST_REQ;
                end
              end
              PH_BMP: begin
                if(bmp_b!=8'h42 || bmp_m!=8'h4d ||
                   bmp_dib_size!=32'd40 || bmp_planes!=16'd1 ||
                   bmp_w!=32'd640 || bmp_h!=32'd480 ||
                   bmp_bpp!=16'd24 || bmp_compression!=32'd0 ||
                   bmp_off<32'd54 || bmp_off>=file_size) begin
                  error<=1; error_code<=8'hE8; state<=ST_FAIL;
                end else begin
                  width<=bmp_w; height<=bmp_h;
                  pixel_offset<=bmp_off;
                  bits_per_pixel<=bmp_bpp;
                  compression<=bmp_compression;
                  first_data_lba<=read_lba; // file first sector (not pixel data sector)
                  done<=1; state<=ST_DONE;
                end
              end
              default: begin
                error<=1; error_code<=8'hEF; state<=ST_FAIL;
              end
            endcase
          end
          ST_DONE: state<=ST_DONE;
          ST_FAIL: state<=ST_FAIL;
          default: begin
            error<=1; error_code<=8'hEF; state<=ST_FAIL;
          end
        endcase
        end  // 闭合 restart/正常 双分支
      end
    end
endmodule

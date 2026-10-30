`timescale 1ns/1ps
module tb_all_files;
 reg clk=0,rst_n=0,restart=0;always #10 clk=~clk;
 reg [3:0] file_idx=1;
 function [23:0] color;
 input integer img,px;
 reg[3:0]r,g,b;
 begin r=(img+px/16)%16;g=(px+img*5)%16;b=(img*3)%16;color={r,4'b0,g,4'b0,b,4'b0};end
 endfunction
 wire [23:0] rgb;wire valid,done,busy;wire[9:0]x;wire[8:0]y;wire[7:0]status;
 wire full=(tick%47<11);integer tick=0,n=0,checked=0,f;
 sd_bmp_stream_top dut(.clk(clk),.rst_n(rst_n),.file_idx(file_idx),.restart(restart),.busy(busy),
 .SD_MISO(1'b1),.fifo_full(full),.fifo_din(rgb),.fifo_wr_en(valid),
 .pixel_x(x),.pixel_y_bottom(y),.frame_done(done),.status(status));
 always @(negedge clk) tick=tick+1;
 always @(posedge clk) begin
   if(!rst_n || restart) n=0;
   else if(valid) begin
     if(full) $fatal(1,"stream ignored backpressure");
     if(rgb !== color(file_idx,n))
       $fatal(1,"IMAGE%0d first-row pixel%0d got%h",file_idx,n,rgb);
     n=n+1;checked=checked+1;
   end
 end
 initial begin
   #100;rst_n=1;
   for(f=1;f<=8;f=f+1) begin
     wait(n>=96);@(negedge clk);
     $display("IMAGE%0d header/first row OK",f);
     if(f!=8) begin file_idx=f+1;restart=1;@(negedge clk);restart=0;end
   end
   $display("PASS all files: IMAGE1..8 FAT32 lookup/header/BGR pixels with backpressure/restart, %0d pixels",checked);$finish;
 end
 initial begin #3000000;$fatal(1,"all-files timeout status=%h file=%d n=%d",status,file_idx,n);end
endmodule

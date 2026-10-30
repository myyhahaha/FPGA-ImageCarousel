`timescale 1ns/1ps
module tb_cache_equiv;
 reg clk=0,rst=1,n=0,p=0,a=0,done=0,fill=0,ack=0;
 reg[7:0]status=0;
 always #10 clk=~clk;
 wire[3:0]li,di,mli,mdi;
 wire[20:0]wb,sb,mwb,msb;
 wire restart,req,visible,all_ready,ready,mrestart,mreq,mvisible,mall_ready,mready;
 ab_image_cache_ctrl rtl(.clk(clk),.rst(rst),.next_pressed(n),.prev_pressed(p),.auto_pressed(a),
  .source_done(done),.source_status(status),.fill_done(fill),.load_img(li),.wr_base(wb),.load_restart(restart),
  .switch_base(sb),.switch_req(req),.switch_ack(ack),.display_valid(visible),.disp_img(di),.preload_done(all_ready),.preview_done(ready));
 cache_mapped gate(.clk(clk),.rst(rst),.next_pressed(n),.prev_pressed(p),.auto_pressed(a),
  .source_done(done),.source_status(status),.fill_done(fill),.load_img(mli),.wr_base(mwb),.load_restart(mrestart),
  .switch_base(msb),.switch_req(mreq),.switch_ack(ack),.display_valid(mvisible),.disp_img(mdi),.preload_done(mall_ready),.preview_done(mready));
 integer ticks=0,left=80,delay=80,boot=0,commits=0,compares=0,last=0,j;
 always @(posedge clk)begin
   if(rst)begin left<=delay;done<=0;fill<=0;status<=0;ack<=0;commits<=0;last<=0;end
   else begin
     ticks<=ticks+1;
     if(restart)left<=delay;
     else if(left>0)begin
       left<=left-1;
       if(left==delay-4)begin done<=0;fill<=0;status<=8'h22;end
       if(left==8)done<=1;
       if(left==1)begin fill<=1;status<=8'hA5;end
     end
     if(req!=ack && ticks%43==0)begin
       ack<=req;commits<=commits+1;
       if(!ready && sb/240000+1!=(commits==8?1:commits+1))$fatal(1,"preview request order");
     end
   end
   #1;
   if(!rst)begin
     compares=compares+1;
     if({li,di,wb,sb,restart,req,visible,all_ready,ready} !==
        {mli,mdi,mwb,msb,mrestart,mreq,mvisible,mall_ready,mready})
       $fatal(1,"RTL/gate diverged boot=%0d tick=%0d RTL: load=%0d display=%0d req=%b ready=%b all=%b, mapped load=%0d display=%0d req=%b ready=%b all=%b",boot,ticks,li,di,req,ready,all_ready,mli,mdi,mreq,mready,mall_ready);
   end
 end
 initial begin
   for(boot=0;boot<4;boot=boot+1)begin
     @(negedge clk);rst=1;delay=boot%2 ? 2000:80;
     repeat(4)@(negedge clk);rst=0;
     wait(ready);repeat(4)@(negedge clk);
     if(di!=1 || commits!=9)$fatal(1,"did not return to 1");
     for(j=0;j<24;j=j+1)begin n=1;@(negedge clk);n=0;repeat(90)@(negedge clk);end
     p=1;@(negedge clk);p=0;repeat(90)@(negedge clk);
     a=1;@(negedge clk);a=0;repeat(90)@(negedge clk);
   end
   $display("PASS mapped cache equivalence: %0d cycle comparisons, fast/slow sequential loading, four cold boots, 1..8..1 preview, manual/reverse/automatic",compares);$finish;
 end
 initial begin #2000000;$fatal(1,"mapped cache timeout");end
endmodule

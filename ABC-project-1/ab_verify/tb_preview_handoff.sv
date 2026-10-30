`timescale 1ns/1ps
module tb_preview_handoff;
 reg clk=0,sdr=0,rst=1,n=0,p=0,a=0,done=0,fill=0;
 always #10 clk=~clk;
 initial begin #3;forever #10.2 sdr=~sdr;end
 reg[7:0]status=0;
 wire[3:0]li,di;wire[20:0]wb,sb,old_base,new_base;
 wire restart,req,visible,all_ready,ready,ack,active,blending;
 wire[5:0]alpha;
 reg ack1=0,ack2=0,req1=0,req2=0,blank=0;reg[5:0]frame_count=0;
 cache_mapped cache(.clk(clk),.rst(rst),.next_pressed(n),.prev_pressed(p),.auto_pressed(a),
  .source_done(done),.source_status(status),.fill_done(fill),.load_img(li),.wr_base(wb),.load_restart(restart),
  .switch_base(sb),.switch_req(req),.switch_ack(ack2),.display_valid(visible),.disp_img(di),.preload_done(all_ready),.preview_done(ready));
 ab_fade_ctrl fade(.clk(sdr),.rst(rst),.frame_blank(blank),.request(req2),.switch_base(sb),.ack(ack),
  .display_active(active),.old_base(old_base),.new_base(new_base),.blending(blending),.alpha(alpha));
 always @(posedge sdr or posedge rst)begin
   if(rst)begin req1<=0;req2<=0;frame_count<=0;blank<=0;end
   else begin req1<=req;req2<=req1;frame_count<=frame_count+1'b1;blank<=frame_count==63;end
 end
 always @(posedge clk or posedge rst)begin
   if(rst)begin ack1<=0;ack2<=0;end
   else begin ack1<=ack;ack2<=ack1;end
 end
 integer delay=400,left=400,loads=0,count=0,last=0,boot=0;
 reg finished=0;
 always @(posedge clk)begin
   if(rst)begin left<=delay;done<=0;fill<=0;status<=0;loads<=0;end
   else begin
     if(restart)begin left<=delay;loads<=loads+1;end
     else if(left>0)begin
       left<=left-1;
       if(left==delay-4)begin done<=0;fill<=0;status<=8'h22;end
       if(left==8)done<=1;
       if(left==1)begin fill<=1;status<=8'hA5;end
     end
   end
   #1;
   if(!rst && !finished && visible)begin
     if(di!=last)begin
       if(di!=(count==8?1:count+1))$fatal(1,"mapped preview skipped/repeated image at step %0d",count);
       count=count+1;last=di;
     end
     if(ready)begin
       if(count!=9 || di!=1 || !all_ready || old_base!=0 || blending || !active)
         $fatal(1,"unlock did not follow actual 8->1 fade ACK");
       finished=1;
     end
   end
 end
 task event_key;input integer direction;
 begin @(negedge clk);n=direction==0;p=direction==1;a=direction==2;
 @(negedge clk);n=0;p=0;a=0;end endtask
 initial begin
   for(boot=0;boot<2;boot=boot+1)begin
     @(negedge clk);rst=1;delay=boot==0?400:24000;count=0;last=0;finished=0;
     repeat(5)@(negedge clk);rst=0;
     wait(ready);@(negedge clk);
     if(!finished || count!=9 || loads!=7)$fatal(1,"mapped preview handoff coverage failed");
     repeat(30)@(negedge clk);
     if(di!=1 || blending)$fatal(1,"manual mode did not remain on IMAGE1");
     event_key(0);wait(di==2);event_key(1);wait(di==1);event_key(2);wait(di==2);
     repeat(10)@(negedge clk);
     if(loads!=7 || !ready)$fatal(1,"control lost after preview handoff");
     $display("PASS mapped preview handoff boot=%0d: %0d-cycle loads, independent 50/49MHz clocks and two-stage CDC, real 32-frame fades 1..8..1, return-to-slot0 ACK before unlock, manual/reverse/automatic work",boot,delay);
   end
   $finish;
 end
 initial begin #10000000;$fatal(1,"mapped preview return timed out");end
endmodule

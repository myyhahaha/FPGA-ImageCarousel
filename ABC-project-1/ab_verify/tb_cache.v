`timescale 1ns/1ps
module tb_cache;
 reg clk=0,rst=1,n=0,p=0,a=0,done=0,fill=0,ack=0;
 always #10 clk=~clk;
 reg [7:0] status=0;
 wire [3:0] load_img,disp_img;
 wire [20:0] wr_base,sw_base;
 wire restart,req,visible,cache_ready,preview_done;
 ab_image_cache_ctrl dut(clk,rst,n,p,a,done,status,fill,
   load_img,wr_base,restart,sw_base,req,ack,visible,disp_img,cache_ready,preview_done);
 integer tick=0,remaining=90,loads=0,commits=0,i,preview_next=1,boot_loads;
 reg fail_eight=1,ack_enable=1;
 reg [3:0] loaded[0:7];
 reg [20:0] active_base=0;
 integer expected_queue[0:255];
 integer expect_head=0,expect_tail=0,score_image=1;
 reg score=0;
 always @(posedge clk) begin
   tick<=tick+1;
   if(rst) begin
     remaining<=90;done<=0;fill<=0;status<=0;ack<=0;active_base<=0;preview_next<=1;
     for(i=0;i<8;i=i+1)loaded[i]<=0;
   end else begin
     if(wr_base>1680000 || sw_base>1680000 || wr_base%240000!=0 || sw_base%240000!=0)
       $fatal(1,"SDRAM slot address out of bounds");
     if(cache_ready && loaded[7]==0)$fatal(1,"all-ready before final SDRAM write");
     if(preview_done && !cache_ready)$fatal(1,"controls enabled before all images cached");
     if(!preview_done && dut.key_count!=0)$fatal(1,"preview input was queued");
     if(req!=ack && tick%43==0 && ack_enable) begin
       if(loaded[sw_base/240000]!=(sw_base/240000)+1) $fatal(1,"commit incomplete/wrong slot");
       if(score)begin
         if(expect_head==expect_tail || loaded[sw_base/240000]!=expected_queue[expect_head])
           $fatal(1,"lost/reordered key at %0d: got=%0d expected=%0d",expect_head,loaded[sw_base/240000],expected_queue[expect_head]);
         expect_head=expect_head+1;
       end
       if(!preview_done)begin
         if(loaded[sw_base/240000]!=(preview_next==9?1:preview_next))$fatal(1,"preview order mismatch expected step=%0d got=%0d",preview_next,loaded[sw_base/240000]);
         preview_next<=preview_next+1;
       end
       active_base<=sw_base;ack<=req;commits<=commits+1;
     end
     if(restart) begin
       if(loaded[wr_base/240000]!=0) $fatal(1,"valid frame evicted/reloaded");
       if(visible && (wr_base==active_base || (req!=ack && wr_base==sw_base)))
         $fatal(1,"overwrites displayed/fading frame");
       remaining<=80;loads<=loads+1;
     end else if(remaining>0) begin
       remaining<=remaining-1;
       if(remaining==75) begin done<=0;fill<=0;status<=8'h22;end
       // Source completion alone must never publish a partly written image.
       if(remaining==5)done<=1;
       if(remaining==1) begin
         if(fail_eight && load_img==8)begin status<=8'hD3;fail_eight<=0;end
         else begin fill<=1;status<=8'hA5;loaded[wr_base/240000]<=load_img;end
       end
     end
   end
 end
 task press;
   input backwards;
   begin
     if(score)begin
       score_image=backwards ? (score_image==1?8:score_image-1):(score_image==8?1:score_image+1);
       expected_queue[expect_tail]=score_image;expect_tail=expect_tail+1;
     end
     @(negedge clk);n=!backwards;p=backwards;@(negedge clk);n=0;p=0;
   end
 endtask
 task expect_image;
   input [3:0] wanted;
   integer k;
   begin
     k=0;
     while((!visible || disp_img!=wanted) && k<2000) begin @(negedge clk);k=k+1;end
     if(k==2000) $fatal(1,"expected image %0d got %0d valid=%b",wanted,disp_img,dut.valid);
     if(loaded[active_base/240000]!=wanted) $fatal(1,"wrong image contents");
   end
 endtask
 task drain;
   integer k;
   begin
     k=0;
     while((expect_head!=expect_tail || req!=ack || dut.commit_pending || dut.key_count!=0) && k<4000)
       begin @(negedge clk);k=k+1;end
     if(k==4000)$fatal(1,"key queue did not drain");
     repeat(4)@(negedge clk);
   end
 endtask
 integer oldloads,start_tick,oldcommits;
 initial begin
   #75;rst=0;expect_image(1);
   if(cache_ready || preview_done)$fatal(1,"first image waited for the whole cache");
   repeat(20)begin press(0);press(1);@(negedge clk);a=1;@(negedge clk);a=0;end
   wait(dut.failed[8]);repeat(200)@(negedge clk);
   if(!visible || disp_img!=7 || preview_done || dut.key_count!=0)$fatal(1,"failed image must hold previous preview without unlocking");
   // Cold restart after correcting a missing/failed file.
   @(negedge clk);rst=1;repeat(3)@(negedge clk);rst=0;boot_loads=loads;
   expect_image(1);wait(preview_done);repeat(10)@(negedge clk);
   if(disp_img!=1 || preview_next!=10 || dut.valid!=8'hff)$fatal(1,"preview did not return to image 1");
   if(loads-boot_loads!=7)$fatal(1,"each image should load once per cold boot");
   oldloads=loads;start_tick=tick;press(0);expect_image(2);
   if(tick-start_tick>49)$fatal(1,"cached key switch waited for SD");
   score_image=2;score=1;
   // All presses arrive within one transition; every direction is retained.
   repeat(12)press(0);repeat(4)press(1);repeat(9)press(0);drain;
   if(expect_head!=25 || disp_img!=score_image)$fatal(1,"rapid queue coverage");
   // Circular FIFO wraps repeatedly and handles enqueue/dequeue overlap.
   repeat(3)begin repeat(20)press(0);drain;end
   score=0;oldcommits=commits;
   @(negedge clk);a=1;@(negedge clk);a=0;
   wait(commits==oldcommits+1);repeat(5)@(negedge clk);
   if(loads!=oldloads)$fatal(1,"warm switching reread TF pictures");
   // A full queue rejects excess input without corrupting retained presses.
   ack_enable=0;press(0);wait(req!=ack);
   repeat(32)press(0);
   if(dut.key_count!=32)$fatal(1,"queue should be full");
   repeat(5)press(0);
   if(dut.key_count!=32)$fatal(1,"full queue wrapped");
   oldcommits=commits;ack_enable=1;
   wait(commits==oldcommits+33);repeat(8)@(negedge clk);
   if(dut.key_count!=0 || req!=ack)$fatal(1,"full queue not consumed");
   // A cold reset discards the old valid mask and again starts at image 1.
   @(negedge clk);rst=1;
   repeat(3)@(negedge clk);rst=0;expect_image(1);
   if(preview_done)$fatal(1,"cold restart skipped preview");
   wait(preview_done);if(disp_img!=1 || dut.valid!=8'hff)$fatal(1,"cold preview restart incomplete");
   $display("PASS eight-image cache: 7,680,000 bytes bounded; early first frame; ordered 1..8..1 ready-driven preview; locked input; failed-file holds last image; cold reset; all slots retained; no warm TF rereads; 85 ordered rapid keys, FIFO wrap/full; auto; incomplete/failed-load protection and retry; loads=%0d commits=%0d",loads,commits);
   $finish;
 end
 initial begin #2000000;$fatal(1,"cache timeout");end
endmodule

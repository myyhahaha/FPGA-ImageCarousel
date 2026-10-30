// Queue both one-cycle requests; sector transactions are never interleaved.
module abc_sd_sector_arbiter(
 input clk,rst,input image_req,input[31:0]image_lba,input audio_req,input[31:0]audio_lba,input audio_urgent,
 output reg card_req,output reg[31:0]card_lba,input card_valid,card_end,
 output image_valid,image_end,audio_valid,audio_end
);
 reg ip,ap,busy,owner,turn_audio;reg[31:0]ilba,alba;reg[2:0]audio_streak;
 assign image_valid=busy && !owner && card_valid;
 assign image_end=busy && !owner && card_end;
 assign audio_valid=busy && owner && card_valid;
 assign audio_end=busy && owner && card_end;
 always @(posedge clk or posedge rst)begin
  if(rst)begin ip<=0;ap<=0;busy<=0;owner<=0;turn_audio<=1;ilba<=0;alba<=0;card_req<=0;card_lba<=0;audio_streak<=0;end
  else begin
   card_req<=0;
   if(image_req)begin ip<=1;ilba<=image_lba;end
   if(audio_req)begin ap<=1;alba<=audio_lba;end
   if(busy)begin if(card_end)busy<=0;end
   else if(ap && (!ip || (audio_urgent && audio_streak<4) || (!audio_urgent && turn_audio)))begin
    ap<=0;owner<=1;busy<=1;card_req<=1;card_lba<=alba;turn_audio<=0;
    if(audio_streak<7)audio_streak<=audio_streak+1'b1;
   end else if(ip)begin
    ip<=0;owner<=0;busy<=1;card_req<=1;card_lba<=ilba;turn_audio<=1;audio_streak<=0;
   end
  end
 end
endmodule

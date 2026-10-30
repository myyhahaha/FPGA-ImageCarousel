// True PCM min/max waveform: 160 samples/column, 640 columns (~2.13 s).
// Copy a coherent ring snapshot during vertical blank; scanout never reads
// a history slot that is being modified by the audio analyzer.
module abc_audio_waveform #(parameter BIN_SAMPLES=160)(
 input clk,rst,frame_blank,sample_valid,input signed[15:0]sample,
 input[9:0]read_column,output reg[9:0]levels
);
 reg[9:0]history[0:639],snapshot[0:639];
 reg[9:0]head,clear_index,copy_index,copy_head;reg clearing,copy_active,pending_valid;
 reg[9:0]pending_pair,history_read;reg[7:0]bin_count;
 reg signed[15:0]maximum,minimum;
 wire signed[15:0]hi=sample>maximum ? sample:maximum;
 wire signed[15:0]lo=sample<minimum ? sample:minimum;
 wire[15:0]negative_magnitude=-lo;
 wire commit=pending_valid && !copy_active && !clearing;
 wire[9:0]next_head=head==639 ? 10'd0:head+1'b1;
 wire[10:0]copy_sum={1'b0,copy_head}+{1'b0,copy_index};
 wire[9:0]copy_address=copy_sum>=640 ? copy_sum-640:copy_sum;
 always @(posedge clk)begin
  if(clearing)begin history[clear_index]<=0;snapshot[clear_index]<=0;end
  else begin
   if(commit)history[head]<=pending_pair;
   if(copy_active && copy_index>0)snapshot[copy_index-1'b1]<=history_read;
  end
  if(copy_active && copy_index<640)history_read<=history[copy_address];
  levels<=snapshot[read_column<640 ? read_column:10'd0];
 end
 always @(posedge clk or posedge rst)begin
  if(rst)begin head<=0;clear_index<=0;copy_index<=0;copy_head<=0;clearing<=1;copy_active<=0;pending_valid<=0;pending_pair<=0;bin_count<=0;maximum<=0;minimum<=0;end
  else if(clearing)begin
   if(clear_index==639)clearing<=0;else clear_index<=clear_index+1'b1;
  end else begin
   if(commit)begin head<=next_head;pending_valid<=0;end
   if(sample_valid)begin
    if(bin_count==BIN_SAMPLES-1)begin
     pending_pair<={hi[15:11],negative_magnitude[15:11]};pending_valid<=1;
     bin_count<=0;maximum<=0;minimum<=0;
    end else begin bin_count<=bin_count+1'b1;maximum<=hi;minimum<=lo;end
   end
   if(frame_blank && !copy_active)begin copy_active<=1;copy_index<=0;copy_head<=commit ? next_head:head;end
   else if(copy_active)begin
    if(copy_index==640)copy_active<=0;else copy_index<=copy_index+1'b1;
   end
  end
 end
endmodule

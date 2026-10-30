// Bridge for a synchronous FIFO with wr_en / full interface.
// fifo_din is RGB888, pixel_y_bottom=0 represents bottom BMP row.
module pixel_fifo_bridge(
 input wire [23:0] pixel_rgb,
 input wire pixel_valid,
 output wire pixel_ready,
 input wire fifo_full,
 output wire [23:0] fifo_din,
 output wire fifo_wr_en
);
 assign pixel_ready = ~fifo_full;
 assign fifo_wr_en = pixel_valid & ~fifo_full;
 assign fifo_din = pixel_rgb;
endmodule

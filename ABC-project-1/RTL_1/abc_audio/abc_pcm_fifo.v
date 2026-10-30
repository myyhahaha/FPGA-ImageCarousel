// PCM16 dual-clock BRAM FIFO; Gray synchronizers and registered look-ahead.
module abc_pcm_fifo (
    input  wire        wr_clk,
    input  wire        wr_rst,      // 高有效
    input  wire        wr_en,
    input  wire [15:0] din,
    output reg         full,

    input  wire        rd_clk,
    input  wire        rd_rst,      // 高有效
    input  wire        rd_en,
    output reg  [15:0] dout,
    output reg         empty,
    output reg [12:0] rd_level,
    output reg  [12:0] wr_level    // 写域看到的当前FIFO字数(水位, 深度1024)
);
    localparam AW = 12;             // 2^10 = 1024 深(已验证时序)
    localparam DW = 16;

    reg [DW-1:0] mem [0:(1<<AW)-1];

    reg [AW:0] wbin;
    reg [AW:0] wgray;
    reg [AW:0] rbin;
    reg [AW:0] rgray;

    // ---------------- 写侧 ----------------
    wire [AW:0] wbin_nxt  = wbin + ((wr_en && !full) ? 1'b1 : 1'b0);
    wire [AW:0] wgray_nxt = (wbin_nxt >> 1) ^ wbin_nxt;

    reg [AW:0] rgray_w1, rgray_w2;
    always @(posedge wr_clk or posedge wr_rst) begin
        if (wr_rst) begin rgray_w1 <= 0; rgray_w2 <= 0; end
        else        begin rgray_w1 <= rgray; rgray_w2 <= rgray_w1; end
    end

    wire full_val = (wgray_nxt == {~rgray_w2[AW:AW-1], rgray_w2[AW-2:0]});

    always @(posedge wr_clk or posedge wr_rst) begin
        if (wr_rst) begin
            wbin  <= 0;
            wgray <= 0;
            full  <= 1'b0;
        end
        else begin
            wbin  <= wbin_nxt;
            wgray <= wgray_nxt;
            full  <= full_val;
        end
    end

    always @(posedge wr_clk) begin
        if (wr_en && !full) mem[wbin[AW-1:0]] <= din;
    end

    // ---------------- 读侧 ----------------
    wire [AW:0] rbin_nxt  = rbin + ((rd_en && !empty) ? 1'b1 : 1'b0);
    wire [AW:0] rgray_nxt = (rbin_nxt >> 1) ^ rbin_nxt;

    reg [AW:0] wgray_r1, wgray_r2;
    always @(posedge rd_clk or posedge rd_rst) begin
        if (rd_rst) begin wgray_r1 <= 0; wgray_r2 <= 0; end
        else        begin wgray_r1 <= wgray; wgray_r2 <= wgray_r1; end
    end

    wire empty_val = (rgray_nxt == wgray_r2);

    always @(posedge rd_clk or posedge rd_rst) begin
        if (rd_rst) begin
            rbin  <= 0;
            rgray <= 0;
            empty <= 1'b1;
        end
        else begin
            rbin  <= rbin_nxt;
            rgray <= rgray_nxt;
            empty <= empty_val;
        end
    end

    // Synchronous look-ahead preserves FWFT behaviour: on the consuming
    // (odd pixel) edge, prefetch the next word for the following even pixel.
    // While empty, the two pointer synchronizers allow this prefetch to settle
    // before empty deasserts. Both memory ports can now map to block RAM.
    always @(posedge rd_clk) dout<=mem[rbin_nxt[AW-1:0]];

    integer j;reg[AW:0]wbin_r2;
    always @* begin
      wbin_r2[AW]=wgray_r2[AW];
      for(j=AW-1;j>=0;j=j-1)wbin_r2[j]=wbin_r2[j+1]^wgray_r2[j];
    end
    always @(posedge rd_clk or posedge rd_rst)begin
      if(rd_rst)rd_level<=0;else rd_level<=wbin_r2-rbin;
    end
    // ---- 写域水位: 把同步过来的读指针格雷码转回二进制, 用写指针减读指针 ----
    integer k;
    reg [AW:0] rbin_w2;
    always @(*) begin
        rbin_w2[AW] = rgray_w2[AW];
        for (k = AW-1; k >= 0; k = k-1)
            rbin_w2[k] = rbin_w2[k+1] ^ rgray_w2[k];
    end
    // Registered water level breaks Gray-decode/subtract/control timing chains.
    // The half-full threshold leaves >500 words for this one-cycle latency.
    always @(posedge wr_clk or posedge wr_rst) begin
        if(wr_rst) wr_level<=0;
        else wr_level<=wbin-rbin_w2;
    end

endmodule



//=============================================================================
// abc_acr_calc.v —— HDMI ACR (Audio Clock Regeneration) 参数计算
//   C 模块 | D13-D14
//
//   HDMI 规范: 接收端用 CTS/N 从 TMDS 时钟恢复音频采样时钟, 满足
//     128 x fs = TMDS_CLK x N / CTS
//   本模块固定 N = 6144 (48kHz 常用值), CTS 用像素时钟实测:
//     每 AUDIO_DIV = N>>7 = 48 个音频样本, 统计其间像素时钟周期数 -> CTS。
//
//   本工程: 像素时钟 40 MHz, 实际采样率 48027.66 Hz
//     48 样本间隔 = 48 x 40e6 / 48027.66 = 39977 像素周期
//     -> CTS ~= 39977, 接收端恢复 128fs ~= 6.1468 MHz, 与真实采样率
//        相差约 121ppm, 完全在 PLL 锁定范围, 音质无影响。
//=============================================================================
module abc_acr_calc #(
    parameter [19:0] ACR_N = 20'd6144
)(
    input  wire        I_clk,          // 像素时钟 40 MHz
    input  wire        I_rst,          // 高有效复位
    input  wire        I_audio_valid,  // 每样本有效脉冲
    output reg         O_acr_valid,    // ACR 参数有效(更新那拍)
    output reg  [19:0] O_acr_cts,
    output reg  [19:0] O_acr_n
);

    localparam [7:0] AUDIO_DIV = ACR_N >> 7;   // 48

    reg [7:0]  div_cnt;    // 样本计数 0..47
    reg [19:0] cyc_cnt;    // 像素时钟计数

    // 样本分频: 每 48 个样本一个节拍
    always @(posedge I_clk or posedge I_rst) begin
        if (I_rst)
            div_cnt <= 8'd0;
        else if (I_audio_valid)
            div_cnt <= (div_cnt >= AUDIO_DIV - 1) ? 8'd0 : div_cnt + 8'd1;
    end

    wire div_pulse = I_audio_valid && (div_cnt == AUDIO_DIV - 1);

    // 节拍间隔内统计像素时钟周期数
    always @(posedge I_clk or posedge I_rst) begin
        if (I_rst)
            cyc_cnt <= 20'd0;
        else
            cyc_cnt <= div_pulse ? 20'd0 : cyc_cnt + 20'd1;
    end

    // 节拍到达: 输出实测 CTS 与固定 N
    always @(posedge I_clk) begin
        if (div_pulse) begin
            O_acr_valid <= 1'b1;
            O_acr_cts   <= cyc_cnt + 20'd1;
            O_acr_n     <= ACR_N;
        end
        else begin
            O_acr_valid <= 1'b0;
            O_acr_cts   <= 20'd0;
            O_acr_n     <= 20'd0;
        end
    end

endmodule

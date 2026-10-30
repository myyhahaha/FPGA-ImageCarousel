//=============================================================================
// abc_video_rgb_to_axis.v —— RGB888/DE/VS 打包为 AXI-Stream 视频流
//   C 模块 | D13-D14
//
//   把 vga_disp 输出的 800x600@60 时序 (HS/VS/DE + RGB888) 打包成
//   HDMI 1.4b 发射核需要的 AXIS 视频从接口:
//     O_video_user  = 帧起始 (SOF): 任意 VS 跳变后, 下一帧首行首像素置 1
//     O_video_valid = 数据有效 (I_de 寄存一拍, 与数据对齐)
//     O_video_last  = 行结束: 每行第 HACTIVE 个有效像素置 1
//     O_video_data  = RGB888
//
//   参数化 HACTIVE, 本工程 800x600 时 = 800。
//=============================================================================
module abc_video_rgb_to_axis #(
    parameter [10:0] HACTIVE = 11'd800
)(
    input  wire        I_clk,
    input  wire        I_rst,          // 高有效复位
    input  wire        I_vs,           // 场同步
    input  wire        I_de,           // 数据有效
    input  wire [23:0] I_rgb,          // RGB888
    output reg         O_video_user,
    output reg         O_video_valid,
    output reg         O_video_last,
    output reg  [23:0] O_video_data
);

    reg        vs_1d;
    reg        de_1d;
    reg        frame_arm;   // 收到 VS 跳变后, 下一帧首像素标 SOF
    reg [10:0] x_cnt;       // 行内有效像素计数

    always @(posedge I_clk or posedge I_rst) begin
        if (I_rst) begin
            vs_1d        <= 1'b0;
            de_1d        <= 1'b0;
            frame_arm    <= 1'b1;
            x_cnt        <= 11'd0;
            O_video_user <= 1'b0;
            O_video_valid<= 1'b0;
            O_video_last <= 1'b0;
            O_video_data <= 24'd0;
        end
        else begin
            vs_1d <= I_vs;
            de_1d <= I_de;

            // 默认输出 (valid 与 data 同拍, 均由 de 驱动)
            O_video_user  <= 1'b0;
            O_video_valid <= I_de;
            O_video_last  <= 1'b0;
            O_video_data  <= I_rgb;

            // 任意 VS 跳变 -> 布防 SOF
            if (vs_1d != I_vs)
                frame_arm <= 1'b1;

            if (I_de) begin
                if (!de_1d) begin
                    // 行首: 复位列计数, 若已布防则标帧起始 (本行首像素)
                    x_cnt <= 11'd0;
                    if (frame_arm) begin
                        O_video_user <= 1'b1;   // 帧起始
                        frame_arm    <= 1'b0;
                    end
                end
                else begin
                    // 行内像素计数: 第 N 像素处 x_cnt = N-2 (N>=2)
                    if (x_cnt == HACTIVE - 2'b10)
                        O_video_last <= 1'b1;   // 第 HACTIVE 个像素 = 行尾
                    x_cnt <= x_cnt + 11'd1;
                end
            end
            else begin
                x_cnt <= 11'd0;
            end
        end
    end

endmodule

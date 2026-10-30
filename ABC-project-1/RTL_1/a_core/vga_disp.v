//=============================================================================
// vga_disp.v —— 800x600@60 显示时序 + 从异步 FIFO 取像素 (每字 2 像素)
//   像素时钟: 40MHz (端口名沿用早期工程习惯仍叫 clk25M)
//
//   ★ 每字 2 像素(12bit/像素): FIFO 每个 24bit 字装 2 个像素,
//     [11:0] = 偶数像素, [23:12] = 奇数像素。
//     这样 SDRAM 每帧只需读 240000 字(而不是 480000), 读带宽需求减半
//     (28.95M -> 14.5M 字/秒), 给读通道留出 2 倍余量, 画面不再闪。
//     显示本来就用每通道高 4bit, 画质与原来完全一致。
//
//   ★ 640x480 图像居中显示在 800x600 中(左右各 80 列、上下各 60 行黑边),
//     与 v6 原版一致。
//
//   时序 (VESA DMT 800x600@60, 像素时钟 40MHz):
//     行: 有效 800 / 前肩 40 / 同步 128 / 后肩 88 / 合计 1056
//     场: 有效 600 / 前肩 1  / 同步 4   / 后肩 23 / 合计 628
//     帧率: 40MHz / (1056*628) = 60.3Hz   行/场同步均为【正极性】
//=============================================================================
module vga_disp
(
    input               clk25M      ,   // 40MHz 像素时钟
    input               reset_n     ,

    input  wire [23:0]  fifo_dout   ,
    input  wire         fifo_empty  ,
    input  wire [11:0]  dbg_pix     ,   // 调试: 当前信箱像素颜色
    input  wire [19:0]  dbg_val     ,   // 调试: 写模块已写入 SDRAM 的字数
    output wire         fifo_rd_en  ,
    output reg          frame_start ,

    output reg          VGA_EN      ,
    output reg          VGA_HSYNC   ,
    output reg          VGA_VSYNC   ,
    output reg  [11:0]  VGA_D,
    output reg  [10:0]  VGA_X,
    output reg  [10:0]  VGA_Y
);

    localparam H_ACT   = 800;
    localparam H_FP    = 40;
    localparam H_SYNC  = 128;
    localparam H_BP    = 88;
    localparam H_TOTAL = 1056;

    localparam V_ACT   = 600;
    localparam V_FP    = 1;
    localparam V_SYNC  = 4;
    localparam V_BP    = 23;
    localparam V_TOTAL = 628;

    reg  [10:0] hcnt;
    reg  [10:0] vcnt;
    wire        dis_en;

    always @(posedge clk25M or negedge reset_n) begin
        if (!reset_n)               hcnt <= 11'd0;
        else if (hcnt == H_TOTAL-1) hcnt <= 11'd0;
        else                        hcnt <= hcnt + 11'd1;
    end

    always @(posedge clk25M or negedge reset_n) begin
        if (!reset_n)               vcnt <= 11'd0;
        else if (hcnt == H_TOTAL-1) begin
            if (vcnt == V_TOTAL-1)  vcnt <= 11'd0;
            else                    vcnt <= vcnt + 11'd1;
        end
    end

    assign dis_en = (hcnt < H_ACT) && (vcnt < V_ACT);

    // Coordinates have exactly the same register phase as VGA_D/EN/sync.
    always @(posedge clk25M or negedge reset_n) begin
        if(!reset_n) begin VGA_X<=0;VGA_Y<=0;end
        else begin VGA_X<=hcnt;VGA_Y<=vcnt;end
    end

    // ---- 每 2 个像素读一个 FIFO 字 (修正读相位) ----
    //   FIFO 是 FWFT 组合读: dout = mem[rbin], 读指针停在哪, dout 就已经是哪个字,
    //   发 rd_en 后【下一拍】读指针才前进。
    //
    //   ★ 旧代码在奇数 hcnt 才"预取+锁存 pix_word", 使每个字晚 2 列上屏:
    //       字0 被锁在 hcnt=1, 却在 hcnt=2/3 才显示 -> 列0 恒黑、整行右移 2 列;
    //       每行最后一个字在消隐期锁存、滚到下一行行首显示 -> 行边界斜向错位
    //       (这就是"横向错位 + 纵向错位"同时出现的根因)。
    //
    //   正确相位(每个字占 偶列/奇列 两拍):
    //     偶数 hcnt: 读指针正指向新字, 偶像素直接取 dout[11:0], 并把该字锁存;
    //     奇数 hcnt: 奇像素取已锁存字的 [23:12], 同时发 rd_en 让指针下一拍前进。
    //   每行 400 字, 从 hcnt=0(字0) 起精确对齐, 行末字也落在本行, 不跨行错位。
    wire advance = dis_en && (!fifo_empty) && hcnt[0];    // 奇列: 用完当前字再前进
    assign fifo_rd_en = advance;

    reg [23:0] pix_word;
    always @(posedge clk25M or negedge reset_n) begin
        if (!reset_n)                                       pix_word <= 24'd0;
        else if (dis_en && (!fifo_empty) && !hcnt[0])       pix_word <= fifo_dout;
    end

    // 偶列走组合 dout(本拍读指针正指向该字); 奇列走上一拍锁存的同一字
    wire [11:0] cur_pix = hcnt[0] ? pix_word[23:12] : fifo_dout[11:0];

    // 帧起始脉冲: 有效区结束、进入垂直消隐的第一行
    always @(posedge clk25M or negedge reset_n) begin
        if (!reset_n) frame_start <= 1'b0;
        else          frame_start <= (vcnt == V_ACT + V_FP) && (hcnt == 11'd0);
    end

    always @(posedge clk25M or negedge reset_n) begin
        if (!reset_n) VGA_HSYNC <= 1'b0;
        else VGA_HSYNC <= (hcnt >= H_ACT + H_FP) && (hcnt < H_ACT + H_FP + H_SYNC);
    end

    always @(posedge clk25M or negedge reset_n) begin
        if (!reset_n) VGA_VSYNC <= 1'b0;
        else VGA_VSYNC <= (vcnt >= V_ACT + V_FP) && (vcnt < V_ACT + V_FP + V_SYNC);
    end

    always @(posedge clk25M or negedge reset_n) begin
        if (!reset_n) VGA_EN <= 1'b0;
        else          VGA_EN <= dis_en;
    end

    // ★★ 分屏自诊断开关 ★★
    //   1 = 左半屏(hcnt<400) 变成"写入进度表":
    //         橙色 = 写模块已写进 SDRAM 的字数(每行 256 字, 满屏 = 153600 字)
    //         深蓝 = 还没写到
    //       左下角 100x100 小方块 = 信箱里此刻的像素颜色(即 B 送来的数据)
    //       右半屏 = 真正从 SDRAM 读回来的图像
    //       判读: 整屏全黑   -> HDMI/TMDS 链路坏了(连蓝底都该亮)
    //             只有蓝      -> B 一个像素都没送来 / 写模块没启动
    //             橙条长一点 -> 写了一半就停(看停在哪一行反推字数)
    //             橙条满/右半屏有图 -> 全链路 OK, 只是行序/色彩要修
    //   0 = 正常整屏显示 SDRAM 数据。
    localparam SPLIT_TEST = 1'b0;

    // 20bit 进度值(150MHz 域) -> 40MHz 域, 两级同步
    reg [19:0] acc_s1, acc_s2;
    always @(posedge clk25M or negedge reset_n) begin
        if (!reset_n) begin acc_s1 <= 20'd0; acc_s2 <= 20'd0; end
        else          begin acc_s1 <= dbg_val; acc_s2 <= acc_s1; end
    end

    // 每行代表 256 个字: 600 行 x 256 = 153600 = 整张 640x480 图像的字数
    wire [19:0] bar_th = {1'b0, vcnt, 8'd0};        // vcnt * 256
    wire        bar_on = (acc_s2 >= bar_th);

    always @(posedge clk25M or negedge reset_n) begin
        if (!reset_n)                        VGA_D <= 12'd0;
        else if (SPLIT_TEST && (hcnt < 11'd400)) begin
            if (vcnt >= 11'd500 && hcnt < 11'd100)
                                             VGA_D <= dbg_pix;   // 左下半 100x100: 信箱像素色
            else                             VGA_D <= bar_on ? 12'hF80   // 橙: 已写入
                                                            : 12'h00F;  // 蓝: 未写到
        end
        else if (dis_en && !fifo_empty)      VGA_D <= cur_pix;    // 右半屏: SDRAM 数据
        else                                 VGA_D <= 12'h000;
    end

endmodule

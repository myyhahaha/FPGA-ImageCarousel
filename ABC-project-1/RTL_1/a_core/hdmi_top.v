//=============================================================================
// hdmi_top.v —— HDMI 驱动顶层 (帧缓存版)
//   相对原版的改动:
//     1) 删掉了没用到的测试端口(SERDES/ODDR_TEST、第二组 HDMI 输出、TPG 相关)
//        —— 原版把 hdmi_top 的 _P1 输出又接回同一条 net, 属于多驱动隐患, 一并去掉
//     2) vga_disp 换成"从 FIFO 取像素"的版本, 新增 4 个 FIFO/帧同步端口
//=============================================================================
module hdmi_top #(parameter integer BRIGHTNESS_DEBOUNCE_CYCLES=800000)(
    input               PXLCLK_I       ,   // 40MHz pixel clock
    input               PXLCLK_5X_I    ,   // 200MHz TMDS serializer clock
    input               RST_I          ,
    input  wire         DISPLAY_READY  ,   // committed frame available; synchronized below

    input wire KEY_BRIGHTER_N,KEY_DIMMER_N,CONTROLS_READY,

    // ---- 帧缓存 FIFO 读侧 (接到顶层的异步 FIFO) ----
    input  wire [23:0]  FIFO_DOUT      ,
    input  wire         FIFO_EMPTY     ,
    input  wire [11:0]  DBG_PIX        ,
    input  wire [19:0]  DBG_VAL        ,
    output wire         FIFO_RD_EN     ,
    output wire         FRAME_START    ,

    input wire[15:0] PCM_DOUT,
    input wire PCM_EMPTY,
    input wire[12:0] PCM_LEVEL,
    output wire PCM_RD_EN,
    output wire HDMI_DDC_SCL,
    inout wire HDMI_DDC_SDA,
    // ---- HDMI 输出 ----
    output              HDMI_CLK_P     ,
    output              HDMI_D2_P      ,
    output              HDMI_D1_P      ,
    output              HDMI_D0_P      ,

    // ---- VGA 测试信号(仅供仿真观察, 本板为 virtualIO) ----
    output              VGA_HS         ,
    output              VGA_VS         ,
    output [7:0]        VGA_R          ,
    output [7:0]        VGA_G          ,
    output [7:0]        VGA_B
);

    wire        VGA_DE,raw_de,raw_hs,raw_vs;
    wire [11:0] VGA_D;
    wire [10:0] raw_x,raw_y,display_x,display_y;
    wire [23:0] display_rgb;

    assign {VGA_R,VGA_G,VGA_B}=display_rgb;

    // 显示时序 + 从 FIFO 取像素
    vga_disp u_vga_disp(
        .clk25M      (PXLCLK_I     ),
        .reset_n     (RST_I        ),
        .fifo_dout   (FIFO_DOUT    ),
        .fifo_empty  (FIFO_EMPTY   ),
        .dbg_pix     (DBG_PIX      ),
        .dbg_val     (DBG_VAL      ),
        .fifo_rd_en  (FIFO_RD_EN   ),
        .frame_start (FRAME_START  ),
        .VGA_HSYNC   (raw_hs       ),
        .VGA_VSYNC   (raw_vs       ),
        .VGA_EN      (raw_de       ),
        .VGA_D       (VGA_D        ),
        .VGA_X       (raw_x        ),
        .VGA_Y       (raw_y        )
    );

    wire presenting;
    ab_video_start u_present(.clk(PXLCLK_I),.reset_n(RST_I),.image_ready_async(DISPLAY_READY),
        .frame_begin(raw_de && raw_x==0 && raw_y==0),.presenting(presenting));
    reg controls_s1,controls_s2;
    always @(posedge PXLCLK_I or negedge RST_I)begin
      if(!RST_I)begin controls_s1<=0;controls_s2<=0;end
      else begin controls_s1<=CONTROLS_READY;controls_s2<=controls_s1;end
    end
    wire [3:0] brightness_level;
    wire [23:0] bright_rgb;
    abc_brightness_ctrl #(.DEBOUNCE_CYCLES(BRIGHTNESS_DEBOUNCE_CYCLES)) u_brightness(
        .clk(PXLCLK_I),.reset_n(RST_I),.enable(presenting && controls_s2),.frame_blank(FRAME_START),
        .key_brighter_n(KEY_BRIGHTER_N),.key_dimmer_n(KEY_DIMMER_N),.level(brightness_level));
    abc_brightness_rgb u_bright_rgb(.rgb(VGA_D),.level(brightness_level),.adjusted(bright_rgb));
    wire audio_valid,audio_playing,audio_underrun;wire[23:0]audio_left,audio_right;
    abc_pcm_playback u_player(.clk(PXLCLK_I),.rst(!RST_I),.play_enable(presenting),
        .fifo_data(PCM_DOUT),.fifo_empty(PCM_EMPTY),.fifo_level(PCM_LEVEL),.fifo_read(PCM_RD_EN),
        .audio_valid(audio_valid),.audio_left(audio_left),.audio_right(audio_right),.playing(audio_playing),.underrun(audio_underrun));
    ab_osd_overlay u_osd(.clk(PXLCLK_I),.reset_n(RST_I),.frame_blank(FRAME_START),.enable(presenting),
        .audio_valid(audio_valid),.audio_pcm(audio_left[23:8]),
        .in_rgb(bright_rgb),
        .in_de(raw_de),.in_hs(raw_hs),.in_vs(raw_vs),.in_x(raw_x),.in_y(raw_y),
        .out_rgb(display_rgb),.out_de(VGA_DE),.out_hs(VGA_HS),.out_vs(VGA_VS),
        .out_x(display_x),.out_y(display_y));

    // TMDS 发送
    abc_hdmi_audio_tx u3_hdmi_tx
    (
        .PXLCLK_I    (PXLCLK_I     ),
        .PXLCLK_5X_I (PXLCLK_5X_I  ),
        .RST_N       (RST_I        ),
        .VGA_HS      (VGA_HS       ),
        .VGA_VS      (VGA_VS       ),
        .VGA_DE      (VGA_DE       ),
        .VGA_RGB     ({VGA_R, VGA_G, VGA_B}),
        .AUDIO_VALID(audio_valid),.AUDIO_LEFT(audio_left),.AUDIO_RIGHT(audio_right),
        .HDMI_DDC_SCL(HDMI_DDC_SCL),.HDMI_DDC_SDA(HDMI_DDC_SDA),
        .HDMI_CLK_P  (HDMI_CLK_P   ),
        .HDMI_D2_P   (HDMI_D2_P    ),
        .HDMI_D1_P   (HDMI_D1_P    ),
        .HDMI_D0_P   (HDMI_D0_P    )
    );

endmodule

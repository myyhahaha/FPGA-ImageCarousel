# 第8张返回首图与操作解锁修订（2026-10-30）

用户上板报告：启动能显示一轮，随后停在第8张，K1/K2、亮度与SW无效；字幕、计时和音频仍在运行，LED4状态不确定。这与预览完成信号未开放操作的路径一致。上一版完整RTL仿真通过，却没有覆盖到实际故障；新增的旧逻辑综合网表功能检查也未复现板端故障，因此目前不能断言板端故障的唯一原因。

本次针对返回/解锁路径重写两处，其他43项活动源码/约束的内容保持原哈希：
1. 独立preview_step计数0～8，0～7依次选择IMAGE1～8，步骤8只选择IMAGE1。预览目标与手动方向、正常图片索引分开。
2. 发切换请求的同一时钟沿立即置commit_pending，不再依赖下一拍观察到request/ack不一致才记住等待状态。收到匹配的转场完成确认后推进步骤；最后一次回到首图且缓存全有效后才解锁。

检查结果：
- 快速专项全部通过：预览顺序、缺图等待、复位、按键排队、亮度、SW真实默认计数、SPI/FIFO和400字整行SDRAM事务。
- 缓存综合后网表与RTL完成43092周期对照，覆盖4次冷启动、快/慢加载、1..8..1返回、前后与自动切图。
- 缓存综合网表连接原淡入淡出控制器和双级CDC，使用独立50/49MHz时钟及缩短的帧脉冲周期；400周期和24000周期两种加载速度均通过。核对真实转场控制器已把old_base提交为0且停止混合后才解锁；解锁后手动前进、后退、自动切换均有效。此项是功能仿真，不模拟板级模拟/时序效应。
- 单独缓存仿真模型消除Icarus把tri1输入错误提升为双向驱动造成的CE冲突，保留悬空CE默认1；没有改动硬件RTL中的时钟或IO结构。
- 8张实际BMP和项目参考WAV的整链路逐像素检查重跑，含全部31个中间权重、启动预览、亮度、手动/排队/自动和PCM连续性。
- HDMI综合网表重新导出并检查音视频封包和串行输出。完整曲目循环本轮未重跑。
- 综合、布局布线、位流生成及最终pr.db独立DRC通过；建立裕量0.159ns，保持裕量0.003ns。保留既有SDRAM_CLK单端点本地布线提示。

实际输出：
```
PASS mapped cache equivalence: 43092 cycle comparisons, fast/slow sequential loading, four cold boots, 1..8..1 preview, manual/reverse/automatic
PASS mapped preview handoff boot=0: 400-cycle loads, independent 50/49MHz clocks and two-stage CDC, real 32-frame fades 1..8..1, return-to-slot0 ACK before unlock, manual/reverse/automatic work
PASS mapped preview handoff boot=1: 24000-cycle loads, independent 50/49MHz clocks and two-stage CDC, real 32-frame fades 1..8..1, return-to-slot0 ACK before unlock, manual/reverse/automatic work
PASS startup preview: 1..8..1 complete, first image early, all inputs ignored, final fade committed before unlock
PASS resident cache integration: eight source loads including reset; preview 1..8..1; zero picture reloads during manual/queued/automatic switches
PASS integrated K3/K4 brightness: 87.5/100/112.5 percent across cached switches and crossfades, frame-atomic, OSD and music preserved
PASS integrated music: 363647 ordered reference-song PCM frames, zero playback underruns, frame-stable waveform compositing
PASS startup alignment: 3360000 initial loading pixels held black; first preview image, OSD and audio started together; elapsed time continuous across preview return and all switches, 303039264 displayed clocks
PASS continuous ORIGINAL BMP fade + OSD: eight untouched user files + real FAT32/BMP + writer + dual-frame reader + FIFO + VGA + alpha/ROM/ticker/timer, 456 frames, 219360000 exact RGB888 active pixels, 372 mixed frames, all 31 intermediate weights; preview/manual/queued/automatic, no underflow/tearing/protected-slot write
```

新固件：C:\Users\m_yy\Desktop\ABC-preview-return-fix.bit
SHA256：5eddd52251460dc52666ef298c840a1a068afe541f5a1b479aff1f0e9e6e81cd
修改前完整备份：C:\Users\m_yy\Documents\Codex\2026-10-27\k1k2\outputs\ABC-project-1_before_preview_fix_20261030.zip
本次尚未上板实测，是否消除用户报告的停8现象，需要下载此新固件确认；不能以仿真通过替代板端结果。

---
下方为历史记录。上一版已经收到板端异常报告，历史仿真结果不代表其上板通过。

# 启动预览：1→2→…→8→1（2026-10-30）

第1张完整读入并写入SDRAM后立即参与显示；后台按顺序填满8个固定缓存。启动预览强制经过1～8，再淡入回到1。仅在最后一次转场ACK提交、disp_img=1且所有缓存有效后置preview_done，解锁导航、自动轮播和亮度调节。预览不使用SW的停留定时，下一张完整就绪且前一转场已结束时即发起切换。保留原32帧淡入淡出与400字整行读取。

K1/K2和K3/K4在预览时不预约动作；持续按住的键在解锁后需松开再按。运行时间、组名滚动和PCM播放从首张预览开始，回到1解锁时保持连续；LED4改为预览结束指示。SW1/2/3/4的1/3/5/8秒稳定停留仍额外加约0.53秒淡入淡出。

- 综合、布局布线与位流生成通过，place seed 4；建立裕量0.524ns、保持裕量0.003ns。对最终pr.db再次独立检查，没有布线错误、多驱动或异常时序路径；保留此前SDRAM_CLK单端点本地布线提示。
- 快速专项套件全部通过，包括1..8..1就绪驱动预览、首图提前、缺图停在前图不解锁、冷启动复位、85次顺序按键/FIFO满与回绕、四键预览锁定及释放后重新按下、全部亮度向量、SW四档真实默认计数边界、SPI速率、异步FIFO、完整400字SDRAM行事务及多种延迟/混合权重。
- 使用8张原始BMP与项目参考WAV重跑真实FAT/BMP→写缓存→淡入淡出→FIFO→亮度→OSD整链路。故意整个预览按住四键并打开SW1，核对只发生1..8..1，且解锁后按住的键无动作；释放后手动、反向排队、亮度和自动模式均正常。逐像素检查所有31个中间权重、8张图片和87.5%/100%/112.5%亮度；音乐样本、计时与波形跨预览结束连续。
- 背景读图/播放共享TF卡单独压力检查：保守144系统时钟/字节条件下，1秒48000个PCM采样完全一致，同时处理90606个BMP像素，FIFO最低2930采样，零欠载。此项为模型带宽验证，不是实卡启动时长测量。
- 重新导出HDMI综合网表并检查真实20ms亮度按键、RGB像素、立体声PCM、音频包、ACR、InfoFrame、BCH及串行字。DSP模型再次与安装的厂商公开功能库完成160008次对照。
- 修正验证用CMake生成文件匹配，支持abc_开头的音频测试顶层；不影响硬件RTL。本轮未重新运行完整曲目循环，也未上板实测。

```
PASS startup preview: 1..8..1 complete, first image early, all inputs ignored, final fade committed before unlock
PASS resident cache integration: eight source loads including reset; preview 1..8..1; zero picture reloads during manual/queued/automatic switches
PASS integrated K3/K4 brightness: 87.5/100/112.5 percent across cached switches and crossfades, frame-atomic, OSD and music preserved
PASS integrated music: 363647 ordered reference-song PCM frames, zero playback underruns, frame-stable waveform compositing
PASS startup alignment: 3360000 initial loading pixels held black; first preview image, OSD and audio started together; elapsed time continuous across preview return and all switches, 303039264 displayed clocks
PASS continuous ORIGINAL BMP fade + OSD: eight untouched user files + real FAT32/BMP + writer + dual-frame reader + FIFO + VGA + alpha/ROM/ticker/timer, 456 frames, 219360000 exact RGB888 active pixels, 372 mixed frames, all 31 intermediate weights; preview/manual/queued/automatic, no underflow/tearing/protected-slot write
PASS mapped K3/K4: real 20ms debounce, 1228800 brightened picture pixels and 921600 restored picture pixels; OSD and serialized HDMI checked
PASS HDMI music output: 4320000 exact regenerated RGB pixels, 7923 ordered 24-bit stereo PCM samples, 7923 audio packets, 138 ACR packets, 21 infoframes, 84795 packet BCH blocks, 6603093 pin serializer words
PASS shared TF bandwidth: 1 s of 48 kHz exact music, 48000 PCM frames, 90606 BMP pixels concurrently; conservative 144 sys clocks/byte, lowest FIFO 2930 samples, zero underruns
- ab_verify\abc_tb_media_bandwidth.sv:26: Verilog $finish
- S i m u l a t i o n   R e p o r t: Verilator 5.49
- Verilator: $finish at 1s; walltime 24.311 s; speed 46.933 ms/s
- Verilator: cpu 23.438 s on 1 threads; allocated 27 MB
```

正式固件SHA256：797c40e18e8b7cb6d82eff58af34c8032f2aef9079eccaf6945b6547b9fee9fe。
桌面副本：C:\Users\m_yy\Desktop\ABC-startup-preview.bit。
修改前完整工程备份：C:\Users\m_yy\Documents\Codex\2026-10-27\k1k2\outputs\ABC-project-1_before_startup_preview_20261030.zip。
本轮源码/网表/测试哈希：ab_verify/results/startup_preview_test_sources.json。

---

以下是旧版本的历史记录；旧版“全部加载后才显示”已由本次启动预览替代。

# K3/K4图片亮度调节（2026-10-30）

K3=B1提亮，K4=C1降亮，低有效。40MHz像素域双级同步、800000时钟/20ms消抖，每次按下产生一次事件。默认100%，上下限50%/150%，步进12.5%，共9档；保持按下不连发。切图保留亮度，上电恢复默认，启动预加载期间忽略调节。

图片在现有RGB444淡入淡出之后、RGB888 OSD叠加之前调节。倍率超出255时逐通道饱和，黑色保持0。应用倍率仅在垂直消隐更新，未增加视频寄存器级数。OSD/音频波形/四周边框不参与调节。八图全预加载、SW1/2/3/4的1/3/5/8秒稳定显示、过渡额外计算及音乐逻辑保留。

- 综合、布局布线、位流生成通过，place seed 4。建立裕量0.193ns、保持裕量0.003ns。最终pr.db独立DRC未报告错误，保留既有内置SDRAM_CLK单端点本地布线提示。
- verify.ps1 -Quick通过，包含新增亮度测试；9档×4096种RGB444共36864向量核对百分比数学参考，同时检查抖动、长按、同拍双事件、上下限、复位与整帧更新。
- 八图实际文件与参考WAV整链路重跑，调节87.5%/100%/112.5%并跨图片、转场保持；所有31个混合权重、启动对齐、音频连续性及视频FIFO零欠载通过。本轮未重跑完整曲目循环。
- 重新导出含亮度的hdmi_top网表并重跑HDMI协议/串行引脚仿真：使用实际20ms消抖的K3/K4输入，检查变亮及恢复原亮度的像素、OSD、立体声PCM、音频包、ACR、InfoFrame、BCH和串行字。
- 新网表使用有符号/无符号MULT9X9C组合。已按安装的Anlogic公开功能库补齐测试模型，并用8种符号/寄存组合、随机双通道及复位完成160008次直接对照，结果一致。该修改仅涉及仿真模型，不改变硬件源码。
- 未修改8张BMP、TF音乐、SDRAM400字整行读取、读卡速率或显示尺寸；本次未上板实测。

实际结果：
```
PASS brightness: debounce/held/simultaneous keys, preload ignored, saturation/reset, frame-atomic application; 36864 RGB444 x level vectors, exact default passthrough and black preservation
PASS multiplier reference: 160008 comparisons against installed Anlogic library; all signed/unsigned lane combinations, combinational/registered B, async reset
PASS resident cache integration: eight source loads including reset, zero picture reloads during manual/queued/automatic switches; eight rapid presses each presented in order
PASS integrated K3/K4 brightness: 87.5/100/112.5 percent across cached switches and crossfades, frame-atomic, OSD and music preserved
PASS integrated music: 358076 ordered user-song PCM frames, zero playback underruns, frame-stable waveform compositing
PASS startup alignment: 23520000 loading pixels held black; image and OSD released at frame origin; timer stayed zero before first image and counted 298397088 displayed clocks across all switches
PASS continuous ORIGINAL BMP fade + OSD: eight untouched user files + real FAT32/BMP + writer + dual-frame reader + FIFO + VGA + alpha/ROM/ticker/timer, 449 frames, 216000000 exact RGB888 active pixels, 372 mixed frames, all 31 intermediate weights; manual/queued/automatic, no underflow/tearing/protected-slot write
PASS mapped K3/K4: real 20ms debounce, 1228800 brightened picture pixels and 921600 restored picture pixels; OSD and serialized HDMI checked
PASS HDMI music output: 4320000 exact regenerated RGB pixels, 7923 ordered 24-bit stereo PCM samples, 7923 audio packets, 138 ACR packets, 21 infoframes, 84795 packet BCH blocks, 6603093 pin serializer words
```

正式固件SHA256：73a8fdf00c485f467b3e777db5cb05475ddaf184642d6e83cb681d6e9fc918b2。
桌面副本：C:\Users\m_yy\Desktop\ABC-K3K4-brightness.bit。
修改前完整备份：C:\Users\m_yy\Documents\Codex\2026-10-27\k1k2\outputs\ABC-project-1_before_brightness_20261030.zip。
本轮源码/网表/测试/厂商库哈希：ab_verify/results/brightness_test_sources.json。

---

以下为此前版本的历史验证记录。

# 八图全预加载与四档轮播（2026-10-30）

交付固件SHA256：29ef7f3d31c435770d50954e83fd343ebdbe0981eb63a1cddfea65214fd75906。
SW1/2/3/4分别为1/3/5/8秒稳定显示，淡入淡出额外计时（用户最新修正）。8张图片固定驻留SDRAM，从1～8循环。所有图片读取与写入完成后才请求首帧，先前第一张读完即展示的启动方式已更改。加载阶段保持黑屏、运行时间0、音乐静音；之后图像/OSD计时/音乐沿用帧边界同步呈现。LED4改为全部图片就绪指示。

容量：8×240000个32位字=7680000字节，最后应用地址1919999，小于2097152；剩余708608字节。音乐不存入此区域。400字整行读取、SD SPI divider=6、32帧淡入淡出及既有音视频链路保留。

## 本轮执行的检查

- 静态综合、布局布线、位流生成完成。最终place seed 4；建立裕量0.267ns、保持裕量0.003ns，STNS/HTNS均0。seed 3布线失败；seed 4优化过程的暂态冲突在最终保存结果中清除。独立加载最终pr.db执行drc_check -route及report_route_status -drc，未再报告布线冲突、多驱动或异常时序路径。保留既有SDRAM_CLK到内置PHY单一端点的本地布线提示，未改变该时钟结构。
- verify.ps1 -Quick通过：OSD/启动、8槽黑屏等待/故障重试/冷复位、85次有序快速按键、32深度队列、四档计数、FIFO、CDC与SDRAM实际控制器引脚检查。额外运行真实SPI主控512字节基准，通过后已加入verify.ps1供后续复跑。
- 四档默认门限50000000/150000000/250000000/400000000个50MHz时钟的边界核对通过；全关闭手动、多档优先级通过。淡入淡出期间计数归0，新图提交后重新完整计时。
- 8张当前最终BMP独立生成参考数据，真实FAT32/BMP/写入器/双帧读出/FIFO/VGA/Alpha/ROM/字幕/时钟整链路仿真通过；全部31个中间混合权重、八次快速按键有序显示与1/8回绕均覆盖。
- 独立物理SDRAM回读使用真实TD控制器网表，覆盖高槽5/6/7，完整写入与读回第8张，480000个输出字逐一核对。
- 音乐使用工程内参考WAV，在整个显示仿真期间逐样本核对连续性并确认零欠载；该参考曲目与TF文件夹当前MUSIC.WAV分别记录哈希，本轮未更换TF音乐、未重跑整首曲目循环。
- 重导出hdmi_top，剔除注释后的网表代码与此前版本逐行一致；HDMI封包/串行输出长测试本轮未重跑。

实际仿真结果：
```
PASS eight-image cache: 7,680,000 bytes bounded; all-before-show startup, failed-file black/retry, cold reset; all slots retained; no warm TF rereads; 85 ordered rapid keys, FIFO wrap/full; auto; incomplete/failed-load protection and retry; loads=15 commits=122
PASS default timer switch=1110 period=50000000 clocks @50MHz
PASS default timer switch=1101 period=150000000 clocks @50MHz
PASS default timer switch=1011 period=250000000 clocks @50MHz
PASS default timer switch=0111 period=400000000 clocks @50MHz
PASS default timer switch=0000 period=50000000 clocks @50MHz
PASS default timer switch=0101 period=150000000 clocks @50MHz
PASS default timer switch=0011 period=250000000 clocks @50MHz
PASS actual default limits: SW1/2/3/4=1/3/5/8s, exact boundaries, priority, manual mode, all-preload wait; fade excluded from interval, full hold starts after commit
PASS resident cache integration: eight source loads including reset, zero picture reloads during manual/queued/automatic switches; eight rapid presses each presented in order
PASS integrated music: 356485 ordered user-song PCM frames, zero playback underruns, frame-stable waveform compositing
PASS startup alignment: 23520000 loading pixels held black; image and OSD released at frame origin; timer stayed zero before first image and counted 297070752 displayed clocks across all switches
PASS continuous ORIGINAL BMP fade + OSD: eight untouched user files + real FAT32/BMP + writer + dual-frame reader + FIFO + VGA + alpha/ROM/ticker/timer, 447 frames, 215040000 exact RGB888 active pixels, 372 mixed frames, all 31 intermediate weights; manual/queued/automatic, no underflow/tearing/protected-slot write
PASS SPI master timing: divider6, 8 sys clocks/half-cycle = 3.125MHz, 512 bytes in 71168 sys clocks including handshake
ESTIMATE only: eight BMP payloads at this master handshake rate = 20.497585 seconds; excludes SD init/commands/token/FAT/SDRAM
```

耗时说明：8张BMP总计7373232字节，3.125MHz理想载荷下限约18.88秒；SPI握手基准换算约20.50秒，均不含整张卡与文件系统开销。无法据此承诺实卡启动时长为20秒或40秒。全链路模型使用扇区事务替代物理SPI，不能用于实卡速度测量。

桌面固件：C:\Users\m_yy\Desktop\ABC-8images-4switches.bit。
修改前完整备份：C:\Users\m_yy\Documents\Codex\2026-10-27\k1k2\outputs\ABC-project-1_before_eight_boot_20261030.zip。
输入、测试源码及固件哈希：ab_verify/results/eight_boot_test_sources.json。
本轮未进行开发板实测。

---

以下为此前版本的历史验证记录。

# 七图常驻缓存与连续按键（2026-10-29）

本次只修改缓存控制和手动事件排队。此前三槽缓存会不断换出图片，连续点击追上预读进度时需要等待TF卡；现在IMAGE1..7各有一个固定槽，读取成功后不再换出。旧版仍保存在完整备份中。

每帧800×600包含黑边，以两个RGB444像素/32位字存储，占240000字/960000字节。7帧共1680000字/6720000字节（约6.41MiB），低于2M×32位SDRAM的8388608字节；最后地址1679999，小于2097152。剩余1668608字节。音乐通过4096×16位片内FIFO流式播放，不占这七帧SDRAM区域，也不将整首歌装入SDRAM。

先呈现第1张并保持图片/文字/时间/音乐同步启动，后台继续读完其余图。当前目标、下一张、上一张优先，其余未缓存文件随后读入。成功标记必须同时满足BMP读取完成、SDRAM写入完成，失败图片不允许显示，手动输入可触发重试。首次尚未读完时仍可能等待；本轮未测量实机开机预读时长。

K1/K2每次有效点击按先后次序排队，最多32次；超额输入不破坏队列。缓存完成后不再因图片读取而等待。32帧约0.53秒的淡入淡出保留，排队的下一次过渡在前一次完成后开始。持续按住仍只触发一次。SW1/2/3沿用全部5秒默认值、全关闭手动模式；定时从过渡完成后开始，未改为精确起点到起点5秒。

## 本轮验证

- 静态综合、布局布线、位流生成通过。seed 2出现局部布线冲突，最终采用seed 3。建立裕量0.352ns，保持裕量0.003ns，负裕量总和为0。
- verify.ps1 -Quick通过。新缓存测试覆盖7槽地址边界、完整写入前禁止发布、失败重试、85次有序连续正反按键、环形队列回绕/满队列、自动切换、缓存命中不再重读。
- 用真实7张最终BMP产生独立像素参考，重跑完整显示链路。覆盖启动、7张图、全部31个中间混合权重、一次快速连续点击7次并逐张显示、K2反向与自动切换。缓存首次完成后图片加载次数保持不变。
- 音乐使用工程内233.293秒参考MUSIC.WAV，对上述显示仿真期间的实际PCM逐样本核对，无播放欠载；本轮未重跑整首音乐循环。TF卡里的曲目无需更换。
- SDRAM使用真实TD导出的控制器网表和物理引脚模型，在固定高槽3/4/6完成整帧混合、清空/写入、读回，480000个输出字逐个核对，覆盖第7张高地址及刷新/读写仲裁。保持已上板验证的400字整行读取。
- 重导出hdmi_top，剔除注释后逻辑网表逐行与此前版本相同；HDMI包/串行输出长测试本轮未重跑。未进行开发板实测。

实际日志摘要：
```
PASS seven-image cache: 6,720,000 bytes bounded; all slots retained; no warm TF rereads; 85 ordered rapid keys, FIFO wrap/full; auto; incomplete/failed-load protection and retry; loads=13 commits=123
PASS FULL SDRAM ROUNDTRIP: 240000 mixed words from original IMAGE4/5; full clear + 153600 written IMAGE7 pairs; 240000 words read back from physical SDRAM; all 480000 output words exact in high slots 3/4/6, refresh=51456
PASS resident cache integration: seven source loads including reset, zero picture reloads during manual/queued/automatic switches; seven rapid presses each presented in order
PASS integrated music: 318287 ordered user-song PCM frames, zero playback underruns, frame-stable waveform compositing
PASS startup alignment: 3360000 loading pixels held black; image and OSD released at frame origin; timer stayed zero before first image and counted 265238688 displayed clocks across all switches
PASS continuous ORIGINAL BMP fade + OSD: seven untouched user files + real FAT32/BMP + writer + dual-frame reader + FIFO + VGA + alpha/ROM/ticker/timer, 399 frames, 192000000 exact RGB888 active pixels, 341 mixed frames, all 31 intermediate weights; manual/queued/automatic, no underflow/tearing/protected-slot write
```

正式固件SHA256：a9f507dc771b44c4d3543984bac6d0686da679261668772119c33bf071d88e8a
桌面便捷副本：C:\Users\m_yy\Desktop\ABC-all-images-cached.bit
完整修改前备份：C:\Users\m_yy\Documents\Codex\2026-10-27\k1k2\outputs\ABC-project-1_before_seven_cache_20261029.zip
输入图片、参考音乐及测试源码哈希：ab_verify/results/seven_cache_test_sources.json。
全链路模型以扇区事务代替SPI引脚、以延迟模型代替SDRAM控制器；物理SDRAM验证另行采用实际控制器网表。因此仿真不用于声称实机TF卡加载耗时。

---

以下为此前版本的历史验证记录，不代表本轮新增执行项目。

# 三个开关统一5秒（2026-10-29）

用户最终选择将SW1/SW2/SW3统一为5秒，不采用扩大帧缓存的方案。
实际修改仅为abc_hdmi_top与img_switch_ctrl两个模块的默认计数值，均为250000000个50MHz时钟；引脚约束仅同步注释。
缓存、SD接口速率、视频和音频逻辑保持原样，LED4恢复正式程序原来的状态指示。
这设置的是自动切图触发门限。下一张图片尚未准备好时，缓存控制器仍会等待完整图像；本次没有承诺实机图像切换一定恰好5秒。

- 静态综合、布局布线、位流生成通过；建立裕量0.156ns、保持裕量0.003ns。
- 默认参数边界仿真确认SW1、SW2、SW3均在250000000个时钟后触发；全关闭时为手动模式。
- verify.ps1 -Quick通过，包括OSD、启动、缓存、手动/自动控制、淡入淡出、FIFO、CDC和真实SDRAM控制器引脚测试。
- 重新导出hdmi_top，去除注释后每行网表代码与已验证版本相同。
- 本轮未重跑完整7图逐像素长仿真和整首音乐验证，也未进行开发板实测。

正式位流SHA256：ef9deb141ccc21c4db419cc8714643b182f3787eea8ec5f144a5c0aec1b12539
桌面便捷副本：C:\Users\m_yy\Desktop\ABC-5seconds.bit
备份：C:\Users\m_yy\Documents\Codex\2026-10-27\k1k2\outputs\ABC-project-1_before_sw_timing_20261029.zip

默认参数实际仿真结果：
```
PASS default timer switch=110 period=250000000 clocks @50MHz
PASS default timer switch=101 period=250000000 clocks @50MHz
PASS default timer switch=011 period=250000000 clocks @50MHz
PASS default timer switch=100 period=250000000 clocks @50MHz
PASS default timer switch=001 period=250000000 clocks @50MHz
PASS actual default limits: single switches all 5s, multi-switch priority, manual mode; baseline timer pauses while fade is busy
```

---

以下为此前版本的历史验证记录。

2026-10-29 图片集替换：IMAGE1.BMP由《韩熙载夜宴图》改为仿《雅典学园》，IMAGE3.BMP由《神奈川冲浪里》改为仿《拾穗者》，均按原画大致完成年代排列；新图去外边框并按4:3等比缩放为640×480、24位BI_RGB。已验证BMP头、保存后像素及交付文件哈希。其他5幅（含修剪后的星月夜）、硬件源码和固件保持不变；本轮未重跑硬件编译或全链路仿真。下文仿真记录为此前图片集的历史验证结果。

2026-10-29 图片资源修订：IMAGE5.BMP（星月夜）重新裁切，排除原图细白边；仍为640×480、24位BI_RGB。已核对BMP头和保存后像素一致性，其他6张及固件哈希未变。本次仅修订图片，未重跑硬件编译和全链路仿真；下文完整仿真记录对应本次裁切前版本。

# 第1张启动及最终照片验证（2026-10-29）

本轮仅调整启动图片编号：首次加载、首个显示目标和复位编号统一为IMAGE1.BMP。
K1/K2、1/7循环、预读、淡入淡出、OSD与音乐逻辑保留。
7张最终照片来自 C:\Users\m_yy\Desktop\阶段检查_勿动\all_test_final，按所仿原画年代排序；原附件第4张顶部白边已经裁除。
测试参考目录 ab_verify/images 已同步为这7张最终照片，BMP字节和RGB444黄金数据由照片文件独立生成。

- 静态编译、布局布线及位流生成通过；建立裕量 0.487 ns，保持裕量 0.003 ns。
- verify.ps1 -Quick通过，包括缓存命中/反向/自动/失败重试、按键、淡入淡出、OSD与实际SDRAM控制器引脚模型。
- 完整新图显示链路仿真通过，明确断言启动编号为1，检查所有7图及全部31个中间混合权重。
- 本轮音频同步检查沿用工程内原有233.293秒参考WAV；未重跑整首歌曲循环/HDMI包协议测试。
- 重新导出hdmi_top硬件网表，与前版逐行去除注释后完全一致；已同步网表来源哈希。
- 本次未进行开发板实测。

完整新图仿真的实际结果：
```
PASS integrated music: 338977 ordered user-song PCM frames, zero playback underruns, frame-stable waveform compositing
PASS startup alignment: 3360000 loading pixels held black; image and OSD released at frame origin; timer stayed zero before first image and counted 282481056 displayed clocks across all switches
PASS continuous ORIGINAL BMP fade + OSD: seven untouched user files + real FAT32/BMP + writer + dual-frame reader + FIFO + VGA + alpha/ROM/ticker/timer, 425 frames, 204480000 exact RGB888 active pixels, 341 mixed frames, all 31 intermediate weights; manual/queued/automatic, no underflow/tearing/protected-slot write
```

正式固件：ABC-project-1.bit
SHA256：0350fdb639b165d66daad00010fe9ac47a358a853b3428d7d8783f6bb14d35f0

详细日志：ab_verify/results/start_image1_quick.log、continuous_real.log、start_image1_build.log。
更新前备份：C:\Users\m_yy\Documents\Codex\2026-10-27\k1k2\outputs\ABC-project-1_before_start_image1_20261029.zip

---

以下保留上一轮命名整理及更早音乐功能验证的历史记录，非本轮重跑结果。

# ABC 命名与精简核对记录

日期：2026-10-29。

- 工程：ABC-project-1.al；内部工程名称与桌面路径均已更新。
- 综合顶层：abc_hdmi_top；有效工程引用 43 项，路径全部存在。
- 音频代码、辅助测试及模块引用同步改为 abc 前缀。实际读取 TF 卡的固定文件名 MUSIC.WAV 保留。
- 本轮改动仅涉及文件/模块/工程命名和引用，以及文件整理。
- 重新综合、布局布线及位流生成通过；SWNS +0.116 ns / STNS 0，HWNS +0.003 ns / HTNS 0。
- 快速回归通过：1,264,336 个 OSD 参考像素、19 种启动相位、100 小时加速计时、混合全权重、按键/缓存/FIFO/跨时钟和 SDRAM 引脚事务等。
- 音频模块检查通过：20,000 个异步 FIFO 采样、4,480 列波形快照、44,689 个视频队列数据。
- 正式固件：ABC-project-1.bit；SHA256 `360b8b74500050eca7b384d640c8fb6a319cefd8c90b503688d6bbfa2c5784ee`。
- 本轮未重新进行完整七图/整首音乐长仿真和开发板测试。下方保留上一次增加配乐时的历史验证记录，作为功能基线。

---

# 配乐与波形叠加：验证记录

2026-10-29，EG4S20BG256。

## 实现

复用用户 C-project-1.zip 中的 HDMI 1.4b 加密核、ACR 计算和串行 PHY。参考工程的音源是测试正弦波；本版替换为真实歌曲。以 40 MHz 像素时钟生成精确平均 48 kHz 采样使能，PCM16 扩为 PCM24，送入 HDMI 音频封包和 ACR 通道。直接使用核的并行 PCM 接口，不经过额外 I2S 串行环节。

TF 卡仍使用原来的分频 6。新增扇区仲裁、MUSIC.WAV FAT32 根目录查找、碎片簇链读取、文件格式检查及 4096 采样异步 FIFO。低水位优先补音乐缓存，连续音频授权有上限，图片请求也能得到服务。歌曲不随切图重启，按数据块长度精确回绕。随附歌曲有 11,198,085 个采样，233.2934375 秒。

波形来自实际送往 HDMI 的采样，包括静音/缓冲恢复后的输出。每 160 个采样统计正负峰值，640 列环形历史约覆盖 2.13 秒；场消隐时复制为显示快照，整帧保持不变，避免上下行读到不同时刻。它是时域波形包络，不是 FFT 频谱。

组名、英文提示和运行时间移到上方 60 像素边框，保留细字、半像素平滑滚动和边缘渐隐。下方原有 60 像素边框内显示青灰色细波形。640×480 原图的位置和尺寸不变。OSD 三层 Alpha 和 4 拍颜色/坐标流水保留。首图、字幕和计时继续同步开启。

原来的 400 字整行 SDRAM 读取、双帧淡入淡出、RGB444 存储、图片写入和显示 FIFO 均保持。40/200 MHz 显示 PLL、SDRAM PLL 和严格相关时钟约束保持。仅增加参考工程中的 HDMI DDC 引脚 P2/R2，固定 800×600/48 kHz，不依赖 EDID 触发或模式切换。

## 本轮检查

| 检查 | 结果 |
|---|---|
| 整首真实歌曲读取 | 11,198,341 个 PCM 采样逐个正确：整首 11,198,085 个采样，加循环后的 256 个采样；碎片根目录、碎片文件簇链、随机背压，98,429 个图片扇区交错读取，无字节丢失或重复 |
| 音频 FIFO | 20,000 个采样，异步 50/40 MHz 时钟、4096 深度、满/空、随机背压和多次指针回绕通过 |
| 采样使能与 ACR | 40,000,000 个像素时钟准确生成 48,000 次采样使能；启动静音、下溢静音和再预填恢复通过；999 次 ACR，N=6144、稳态 CTS=40000 |
| 波形快照 | 4,480 列逐值正确；正负满幅（含 -32768）、环形回绕、显示帧保持、复制期间推迟写入、复位清零通过 |
| TF 卡带宽 | 144 个 50 MHz 时钟/字节的保守速率下，连续 1 秒输出 48,000 个正确采样，同时产生 90,606 个 BMP 像素；音频 FIFO 最低 2,930 采样，没有下溢 |
| 视频 AXIS 队列 | 44,689 个 26 位像素顺序正确；ready 停顿、满/空、回绕、单项旁路和溢出标志通过 |
| 上下叠加像素 | Icarus 四态仿真，1,264,336 个独立 Python / SV 参考像素正确，含歌曲实际包络、上下区域、字形 ROM、所有滚动小数相位、渐隐、同步流水和隐藏阶段 |
| 完整七图与歌曲 | 425 个完整帧周期、204,480,000 个有效 RGB888 像素正确，341 个混合帧覆盖全部 31 个中间权重；338,977 个真实歌曲采样顺序正确，无音频下溢；手动、反向排队、自动轮播、回绕、显示槽保护通过 |
| 启动与时间 | 3,360,000 个加载阶段有效像素保持黑色，首图和字幕在帧起点开启；随后 282,481,056 个展示时钟的计时正确。另有 19 种异步就绪相位及 100 小时加速进位检查通过 |
| HDMI 综合后网表 | PASS HDMI music output: 3360000 exact regenerated RGB pixels, 6331 ordered 24-bit stereo PCM samples, 6331 audio packets, 104 ACR packets, 17 infoframes, 65955 packet BCH blocks, 5276757 pin serializer words |
| 原有回归 | 混合全权重、按键、档位、缓存、FIFO、装载跨时钟、7 BMP 文件解析、64 字/400 字 SDRAM 引脚事务及刷新/延迟裕量全部通过 |
| TD 静态编译 | 综合、布局、布线及位流生成通过；SWNS +0.116 ns / STNS 0，HWNS +0.003 ns / HTNS 0 |

资源：15,805 LUT（80.64%）、5,493 寄存器、47 BRAM9K（73.44%）、16 DSP、2 PLL。综合网表仿真使用 TD 导出的实际逻辑、原厂 LUT/加法器模型和限定配置 BRAM/DSP/DDR 功能模型，功能模型不模拟线缆及显示器的电气行为。HDMI 接收测试按公开的 [HDMI packet assembler](https://github.com/hdl-util/hdmi/blob/master/src/packet_assembler.sv) 和 [audio packet layout](https://github.com/hdl-util/hdmi/blob/master/src/audio_sample_packet.sv) 的协议结构独立解包。

## 交付

根目录只保留 AB-project-1_osd.bit，644,764 字节，SHA256 `3622002e51a04a01380bcb2308cede36eaeabd590bb1ff5f6e9093e46754ffa2`。

歌曲 SHA256：`1d75fa1d2f5dd7e9105f4740ca8fdd4a09989c06eec5443d96860e6ca07490ea`。桌面覆盖前检查源码未被并发修改；交付源码、固件和准备好的歌曲逐文件核对。此前可用版完整备份：outputs/AB-project-1_before_music_20261029.zip。

本轮仿真和静态时序已通过；新的 HDMI 音频及新排版尚未进行开发板实测。

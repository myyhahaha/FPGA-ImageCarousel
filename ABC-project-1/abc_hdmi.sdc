# ---- 1. Board input clock (master) ----------------------------------------
create_clock -name sys_clk -period 20.000 -waveform {0.000 10.000} [get_ports {sys_clk}]

# ---- 2. Derive every PLL output clock, then rename -----------------------
derive_clocks

# SDRAM PLL (50 MHz): clkc[0] main, clkc[1] 144 deg shifted
rename_clock -name sdr_clk      [get_clocks {u_clk_sdr/pll_inst.clkc[0]}]
rename_clock -name sdr_clk_sft  [get_clocks {u_clk_sdr/pll_inst.clkc[1]}]

# Pixel PLL: clkc[0] 200 MHz TMDS 5x, clkc[1] 40 MHz pixel
rename_clock -name pixel_clk_5x [get_clocks {u_clk_wize/pll_inst.clkc[0]}]
rename_clock -name pixel_clk    [get_clocks {u_clk_wize/pll_inst.clkc[1]}]

# SDRAM main and shifted clocks are related and MUST be timed together.
# Cross-domain control/mailbox/FIFO use explicit synchronizers.
set_clock_groups -asynchronous \
    -group [get_clocks {sys_clk}] \
    -group [get_clocks {sdr_clk sdr_clk_sft}] \
    -group [get_clocks {pixel_clk pixel_clk_5x}]

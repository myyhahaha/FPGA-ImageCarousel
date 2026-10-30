create_clock -name sys_clk -period 20.000 [get_ports {sys_clk}]
derive_clocks
rename_clock -name pixel_clk_5x [get_clocks {u_clk_wize/pll_inst.clkc[0]}]
rename_clock -name pixel_clk [get_clocks {u_clk_wize/pll_inst.clkc[1]}]
set_clock_groups -asynchronous -group [get_clocks {sys_clk}] -group [get_clocks {pixel_clk pixel_clk_5x}]

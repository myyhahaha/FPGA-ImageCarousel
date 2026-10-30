$ErrorActionPreference='Stop'
$projectRoot=Split-Path $PSScriptRoot -Parent
$td='C:/Anlogic/TD_6.2.1_Engineer_6.2.168.116/bin/td_commands_prompt.exe'
$iv=Join-Path $env:USERPROFILE 'iverilog/bin/iverilog.exe'
$vvp=Join-Path $env:USERPROFILE 'iverilog/bin/vvp.exe'
Push-Location $projectRoot
try {
 & $td 'ab_verify/export_cache_ctrl.tcl' *> 'ab_verify/results/cache_export.log'
 if($LASTEXITCODE-ne 0 -or !(Select-String -LiteralPath 'ab_verify/results/cache_export.log' -Pattern '^CACHE_EXPORT_PASS$' -Quiet)){throw 'Cache netlist export failed.'}
 $s=Get-Content -LiteralPath 'ab_verify/cache_map.v' -Raw
 $s=$s.Replace('module ab_image_cache_ctrl ','module cache_mapped ')
 Set-Content -LiteralPath 'ab_verify/results/cache_mapped.v' -Value $s -Encoding utf8NoBOM
 & $iv -g2005 -s tb_cache_equiv -o 'ab_verify/results/tb_cache_equiv.vvp' 'RTL_1/bridge/abc_hdmi_top.v' 'ab_verify/results/cache_mapped.v' 'ab_verify/td_cache_cells.v' 'ab_verify/vendor_al_map_lut.v' 'ab_verify/video_adder.v' 'ab_verify/tb_cache_equiv.v' *> 'ab_verify/results/tb_cache_equiv_compile.log'
 if($LASTEXITCODE-ne 0){throw 'Cache equivalence compile failed.'}
 & $vvp 'ab_verify/results/tb_cache_equiv.vvp' *> 'ab_verify/results/tb_cache_equiv_sim.log'
 if($LASTEXITCODE-ne 0 -or !(Select-String -LiteralPath 'ab_verify/results/tb_cache_equiv_sim.log' -Pattern '^PASS mapped cache equivalence:' -Quiet)){throw 'Mapped cache did not match RTL.'}
 Get-Content -LiteralPath 'ab_verify/results/tb_cache_equiv_sim.log'
 & $iv -g2005 -s tb_preview_handoff -o 'ab_verify/results/tb_preview_handoff.vvp' 'RTL_1/bridge/abc_hdmi_top.v' 'ab_verify/results/cache_mapped.v' 'ab_verify/td_cache_cells.v' 'ab_verify/vendor_al_map_lut.v' 'ab_verify/video_adder.v' 'ab_verify/tb_preview_handoff.sv' *> 'ab_verify/results/tb_preview_handoff_compile.log'
 if($LASTEXITCODE-ne 0){throw 'Mapped preview handoff compile failed.'}
 & $vvp 'ab_verify/results/tb_preview_handoff.vvp' *> 'ab_verify/results/tb_preview_handoff_sim.log'
 if($LASTEXITCODE-ne 0 -or !(Select-String -LiteralPath 'ab_verify/results/tb_preview_handoff_sim.log' -Pattern '^PASS mapped preview handoff boot=1:' -Quiet)){throw 'Mapped preview/fade/CDC handoff failed.'}
 Get-Content -LiteralPath 'ab_verify/results/tb_preview_handoff_sim.log'
} finally {Pop-Location}

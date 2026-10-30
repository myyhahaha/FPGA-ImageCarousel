param([switch]$Quick)
$ErrorActionPreference='Stop'
$projectRoot=Split-Path $PSScriptRoot -Parent
$results=Join-Path $PSScriptRoot 'results'
New-Item -ItemType Directory -Path $results -Force | Out-Null
$iv=Join-Path $env:USERPROFILE 'iverilog\bin\iverilog.exe'
$vvp=Join-Path $env:USERPROFILE 'iverilog\bin\vvp.exe'
if(!(Test-Path -LiteralPath $iv)) { throw "Icarus Verilog not found: $iv" }
function Run-Test($top,$files,$generation='2012',$extra=@()) {
 $compile=Join-Path $results ($top+'_compile.log')
 $run=Join-Path $results ($top+'_sim.log')
 $binary=Join-Path $results ($top+'.vvp')
 & $iv ('-g'+$generation) -s $top @extra -o $binary @files *> $compile
 if($LASTEXITCODE -ne 0) { throw "Compile failed: $top ($compile)" }
 & $vvp $binary *> $run
 if($LASTEXITCODE -ne 0 -or !(Select-String -LiteralPath $run -Pattern '^PASS ' -Quiet)) { throw "Simulation failed: $top ($run)" }
 Get-Content -LiteralPath $run | Select-Object -Last 2
}
Push-Location $projectRoot
try {
 $python=Join-Path $env:USERPROFILE '.cache/codex-runtimes/codex-primary-runtime/dependencies/python/python.exe'
 if(!(Test-Path -LiteralPath $python)) { $python=(Get-Command python -ErrorAction Stop).Source }
 & $python (Join-Path $PSScriptRoot 'osd_reference.py')
 if($LASTEXITCODE -ne 0) { throw 'OSD reference generation failed.' }
 Run-Test 'tb_brightness' @('RTL_1/a_core/abc_brightness.v','ab_verify/tb_brightness.sv')
 Run-Test 'tb_osd_engine' @('RTL_1/abc_audio/abc_audio_waveform.v','RTL_1/a_core/ab_osd_overlay.v','RTL_1/a_core/ab_osd_font_rom.v','ab_verify/tb_osd_engine.v')
 Run-Test 'tb_video_start' @('RTL_1/abc_audio/abc_audio_waveform.v','RTL_1/a_core/ab_osd_overlay.v','RTL_1/a_core/ab_osd_font_rom.v','ab_verify/tb_video_start.v')
 Run-Test 'tb_osd_clock' @('RTL_1/abc_audio/abc_audio_waveform.v','RTL_1/a_core/ab_osd_overlay.v','RTL_1/a_core/ab_osd_font_rom.v','ab_verify/tb_osd_clock.v')
 Run-Test 'tb_tmds_standard' @('RTL_1/a_core/TMDSEncoder.v','ab_verify/tb_tmds_standard.v')
 Run-Test 'tb_legacy_repro' @('ab_verify/baseline_encoder_map.v','ab_verify/td_map_cells.v','ab_verify/vendor_al_map_lut.v','ab_verify/video_adder.v','RTL_1/a_core/TMDSEncoder.v','ab_verify/tb_legacy_repro.v') '2005'
 Run-Test 'tb_blend_word' @('RTL_1/a_core/frame_read.v','ab_verify/tb_blend_word.v')
 Run-Test 'tb_fade_ctrl' @('RTL_1/bridge/abc_hdmi_top.v','ab_verify/tb_fade_ctrl.v')
 Run-Test 'tb_cache' @('RTL_1/bridge/abc_hdmi_top.v','ab_verify/tb_cache.v')
 Run-Test 'tb_preview_controls' @('RTL_1/bridge/abc_hdmi_top.v','RTL_1/a_core/abc_brightness.v','ab_verify/tb_preview_controls.sv')
 Run-Test 'tb_controls' @('RTL_1/bridge/abc_hdmi_top.v','ab_verify/tb_controls.v')
 Run-Test 'tb_controls_actual_limits' @('RTL_1/bridge/abc_hdmi_top.v','ab_verify/tb_controls_actual_limits.sv')
 Run-Test 'tb_spi_speed' @('rtl/spi_master.v','ab_verify/tb_spi_speed.sv')
 Run-Test 'tb_fifo' @('RTL_1/a_core/afifo_24x256.v','ab_verify/tb_fifo.v')
 foreach($half in @('9.8','10.0','10.2')) {
  Run-Test 'tb_reload_cdc' @('RTL_1/bridge/abc_hdmi_top.v','ab_verify/tb_reload_cdc.v') '2012' @('-Ptb_reload_cdc.DST_HALF='+$half)
 }
 Run-Test 'tb_all_files' @('rtl/sd_bmp_stream_top.v','rtl/fat32_bmp_reader.v','rtl/bmp_pixel_stream.v','rtl/pixel_fifo_bridge.v','ab_verify/sd_card_model.v','ab_verify/tb_all_files.v')
 $expected=Get-Content -LiteralPath (Join-Path $PSScriptRoot 'controller_source_sha256.json') -Raw | ConvertFrom-Json
 foreach($entry in $expected.PSObject.Properties) {
  if((Get-FileHash -LiteralPath $entry.Name -Algorithm SHA256).Hash.ToLower() -ne $entry.Value) { throw "SDRAM model source changed: $($entry.Name). Re-export the controller netlist before simulation." }
 }
 $pin=@('ab_verify/sdr_map.v','ab_verify/td_map_cells.v','ab_verify/vendor_al_map_lut.v','ab_verify/vendor_al_map_adder.v','ab_verify/sdram_pin_model.v','ab_verify/tb_pin_transactions.v','RTL_1/a_core/frame_read.v','RTL_1/bridge/ab_bmp_sdram_writer.v','RTL_1/bridge/abc_hdmi_top.v')
 foreach($case in @(@('1.5','0'),@('4.5','0'),@('5.0','4.5'))) {
  Run-Test 'tb_pin_transactions' $pin '2005' @((('-Ptb_pin_transactions.MEM_TAC=')+$case[0]),(('-Ptb_pin_transactions.CLK_DELAY=')+$case[1]))
  Copy-Item -LiteralPath (Join-Path $results 'tb_pin_transactions_sim.log') -Destination (Join-Path $results ('pin_'+$case[0]+'_'+$case[1]+'.log')) -Force
 }
 foreach($weight in @('7','25')) {
  Run-Test 'tb_pin_transactions' $pin '2005' @('-Ptb_pin_transactions.MIX_ALPHA='+$weight)
  Copy-Item -LiteralPath (Join-Path $results 'tb_pin_transactions_sim.log') -Destination (Join-Path $results ('pin_weight_'+$weight+'.log')) -Force
 }
 Run-Test 'tb_pin_transactions' $pin '2005' @('-Ptb_pin_transactions.MIX_ENABLE=0')
 Copy-Item -LiteralPath (Join-Path $results 'tb_pin_transactions_sim.log') -Destination (Join-Path $results 'pin_direct.log') -Force
 $linePin=$pin | ForEach-Object { $_.Replace('vendor_al_map_adder.v','video_adder.v').Replace('tb_pin_transactions.v','tb_pin_line.v') }
 foreach($case in @(@('1.5','0'),@('4.5','0'),@('5.0','4.5'))) {
  Run-Test 'tb_pin_line' $linePin '2005' @((('-Ptb_pin_line.MEM_TAC=')+$case[0]),(('-Ptb_pin_line.CLK_DELAY=')+$case[1]))
  Copy-Item -LiteralPath (Join-Path $results 'tb_pin_line_sim.log') -Destination (Join-Path $results ('line400_'+$case[0]+'_'+$case[1]+'.log')) -Force
 }
 foreach($weight in @('7','25')) {
  Run-Test 'tb_pin_line' $linePin '2005' @('-Ptb_pin_line.MIX_ALPHA='+$weight)
  Copy-Item -LiteralPath (Join-Path $results 'tb_pin_line_sim.log') -Destination (Join-Path $results ('line400_weight_'+$weight+'.log')) -Force
 }
 Run-Test 'tb_pin_line' $linePin '2005' @('-Ptb_pin_line.MIX_ENABLE=0')
 Copy-Item -LiteralPath (Join-Path $results 'tb_pin_line_sim.log') -Destination (Join-Path $results 'line400_direct.log') -Force
 if(!$Quick) {
  & (Join-Path $PSScriptRoot 'verify_cache_mapped.ps1')
  $fastRoot=$env:VERILATOR_ROOT
  $localTools=Join-Path $PSScriptRoot 'local_tools.json'
  if(!$fastRoot -and (Test-Path -LiteralPath $localTools)) { $fastRoot=(Get-Content -LiteralPath $localTools -Raw | ConvertFrom-Json).VerilatorRoot }
  $python=Join-Path $env:USERPROFILE '.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe'
  if(!(Test-Path -LiteralPath $python)) { $python=(Get-Command python -ErrorAction Stop).Source }
  & $python (Join-Path $PSScriptRoot 'prepare_images.py')
  if($LASTEXITCODE -ne 0) { throw 'Preparing original BMP test memories failed.' }
  if(!$fastRoot -or !(Test-Path -LiteralPath (Join-Path $fastRoot 'bin/verilator_bin.exe'))) {
   throw 'Full image/HDMI verification requires VerilatorRoot in local_tools.json or VERILATOR_ROOT.'
  }
  & $python (Join-Path $PSScriptRoot 'abc_prepare_music_vectors.py')
  if($LASTEXITCODE -ne 0){throw 'Music reference generation failed.'}
  & (Join-Path $PSScriptRoot 'abc_verify_audio.ps1') -VerilatorRoot $fastRoot
  & (Join-Path $PSScriptRoot 'verify_real.ps1') -VerilatorRoot $fastRoot
  & (Join-Path $PSScriptRoot 'verify_pin_full.ps1') -VerilatorRoot $fastRoot
  & (Join-Path $PSScriptRoot 'verify_hdmi.ps1') -VerilatorRoot $fastRoot
  & (Join-Path $PSScriptRoot 'verify_diag.ps1') -VerilatorRoot $fastRoot
 }
 Write-Host 'ALL REQUESTED SIMULATIONS PASS.'
} finally { Pop-Location }

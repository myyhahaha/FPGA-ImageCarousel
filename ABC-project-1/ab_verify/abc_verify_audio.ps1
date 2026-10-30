param([string]$VerilatorRoot,[string[]]$Tests=@('fifo','wave','axis','file','playback','bandwidth'))
$ErrorActionPreference='Stop'
$projectRoot=Split-Path $PSScriptRoot -Parent
$results=Join-Path $PSScriptRoot 'results'
New-Item -ItemType Directory -Path $results -Force | Out-Null
$iv=Join-Path $env:USERPROFILE 'iverilog/bin/iverilog.exe'
$vvp=Join-Path $env:USERPROFILE 'iverilog/bin/vvp.exe'
if(!$VerilatorRoot){$VerilatorRoot=(Get-Content -LiteralPath (Join-Path $PSScriptRoot 'local_tools.json') -Raw|ConvertFrom-Json).VerilatorRoot}
$env:VERILATOR_ROOT=$VerilatorRoot.Replace('\','/')
$verilator=Join-Path $VerilatorRoot 'bin/verilator_bin.exe'
$cmake='C:/Program Files/Microsoft Visual Studio/2022/Enterprise/Common7/IDE/CommonExtensions/Microsoft/CMake/CMake/bin/cmake.exe'
function Native($top,$files){
 & $iv -g2012 -s $top -o "ab_verify/results/$top.vvp" @files *> "ab_verify/results/${top}_compile.log"
 if($LASTEXITCODE-ne 0){throw "Compile failed: $top"}
 & $vvp "ab_verify/results/$top.vvp" *> "ab_verify/results/${top}_sim.log"
 if($LASTEXITCODE-ne 0 -or !(Select-String -LiteralPath "ab_verify/results/${top}_sim.log" -Pattern '^PASS ' -Quiet)){throw "Simulation failed: $top"}
 Get-Content -LiteralPath "ab_verify/results/${top}_sim.log" -Tail 2
}
function Fast($top,$files){
 $buildDir=Join-Path $PSScriptRoot "verilated_$top"
 New-Item -ItemType Directory -Path $buildDir -Force|Out-Null
 & $verilator --cc --timing --main --exe --top-module $top -Wno-fatal --Mdir $buildDir @files *> "ab_verify/results/${top}_verilator_compile.log"
 if($LASTEXITCODE-ne 0){throw "Verilation failed: $top"}
 Copy-Item -LiteralPath (Join-Path $PSScriptRoot 'verilator_CMakeLists.txt') -Destination (Join-Path $buildDir 'CMakeLists.txt') -Force
 & $cmake -S $buildDir -B "$buildDir/build" -G 'Visual Studio 17 2022' -A x64 ("-DVROOT="+$env:VERILATOR_ROOT) *> "ab_verify/results/${top}_cmake.log"
 if($LASTEXITCODE-ne 0){throw "CMake failed: $top"}
 & $cmake --build "$buildDir/build" --config Release --parallel 4 *> "ab_verify/results/${top}_build.log"
 if($LASTEXITCODE-ne 0){throw "C++ build failed: $top"}
 & "$buildDir/build/Release/ab_sim.exe" *> "ab_verify/results/${top}_sim.log"
 if($LASTEXITCODE-ne 0 -or !(Select-String -LiteralPath "ab_verify/results/${top}_sim.log" -Pattern '^PASS ' -Quiet)){throw "Simulation failed: $top"}
 Get-Content -LiteralPath "ab_verify/results/${top}_sim.log" -Tail 5
}
Push-Location $projectRoot
try{
 if('fifo'-in $Tests){Native 'abc_tb_pcm_fifo' @('RTL_1/abc_audio/abc_pcm_fifo.v','ab_verify/abc_tb_pcm_fifo.v')}
 if('wave'-in $Tests){Native 'abc_tb_audio_waveform' @('RTL_1/abc_audio/abc_audio_waveform.v','ab_verify/abc_tb_audio_waveform.v')}
 if('axis'-in $Tests){Native 'abc_tb_axis_fifo' @('RTL_1/abc_audio/abc_video_axis_fifo.v','ab_verify/abc_tb_axis_fifo.v')}
 if('file'-in $Tests){Fast 'abc_tb_music_file' @('rtl/abc_sd_sector_arbiter.v','rtl/abc_wav_find.v','rtl/abc_wav_stream.v','ab_verify/abc_tb_music_file.sv')}
 if('playback'-in $Tests){Fast 'abc_tb_pcm_playback' @('RTL_1/abc_audio/abc_pcm_playback.v','RTL_1/abc_audio/abc_acr_calc.v','ab_verify/abc_tb_pcm_playback.sv')}
 if('bandwidth'-in $Tests){Fast 'abc_tb_media_bandwidth' @('+define+REAL_MUSIC','rtl/abc_sd_sector_arbiter.v','rtl/abc_wav_find.v','rtl/abc_wav_stream.v','rtl/abc_sd_media.v','rtl/sd_bmp_stream_top.v','rtl/fat32_bmp_reader.v','rtl/bmp_pixel_stream.v','rtl/pixel_fifo_bridge.v','RTL_1/abc_audio/abc_pcm_fifo.v','RTL_1/abc_audio/abc_pcm_playback.v','ab_verify/sd_card_model.v','ab_verify/abc_tb_media_bandwidth.sv')}
 Write-Host 'ALL REQUESTED AUDIO TESTS PASS.'
}finally{Pop-Location}

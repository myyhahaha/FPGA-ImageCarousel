param([string]$VerilatorRoot)
$ErrorActionPreference='Stop'
$projectRoot=Split-Path $PSScriptRoot -Parent
if(!$VerilatorRoot) { $VerilatorRoot=$env:VERILATOR_ROOT }
if(!$VerilatorRoot) { throw 'Supply -VerilatorRoot or set VERILATOR_ROOT.' }
$verilator=Join-Path $VerilatorRoot 'bin/verilator_bin.exe'
if(!(Test-Path -LiteralPath $verilator)) { throw "Verilator not found: $verilator" }
$cmake='C:\Program Files\Microsoft Visual Studio\2022\Enterprise\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin\cmake.exe'
if(!(Test-Path -LiteralPath $cmake)) { $cmake=(Get-Command cmake -ErrorAction Stop).Source }
$env:VERILATOR_ROOT=$VerilatorRoot.Replace('\','/')
$buildDir=Join-Path $PSScriptRoot 'verilated'
$results=Join-Path $PSScriptRoot 'results'
New-Item -ItemType Directory -Path $buildDir,$results -Force | Out-Null
Push-Location $projectRoot
try {
 $manifest=Get-Content -LiteralPath (Join-Path $PSScriptRoot 'integration_manifest.json') -Raw | ConvertFrom-Json
 if($manifest[0] -is [string]) { $files=@($manifest[1]) } else { $files=@($manifest[0][1]) }
 & $verilator --cc --timing --main --exe --top-module tb_continuous -Wno-fatal --Mdir $buildDir @files *> (Join-Path $results 'verilator_compile.log')
 if($LASTEXITCODE -ne 0) { throw 'Verilation failed.' }
 Copy-Item -LiteralPath (Join-Path $PSScriptRoot 'verilator_CMakeLists.txt') -Destination (Join-Path $buildDir 'CMakeLists.txt') -Force
 & $cmake -S $buildDir -B (Join-Path $buildDir 'build') -G 'Visual Studio 17 2022' -A x64 ('-DVROOT='+$env:VERILATOR_ROOT) *> (Join-Path $results 'verilator_cmake.log')
 if($LASTEXITCODE -ne 0) { throw 'CMake configuration failed.' }
 & $cmake --build (Join-Path $buildDir 'build') --config Release --parallel 4 *> (Join-Path $results 'verilator_build.log')
 if($LASTEXITCODE -ne 0) { throw 'C++ simulation build failed.' }
 $runLog=Join-Path $results 'continuous_verilator.log'
 & (Join-Path $buildDir 'build/Release/ab_sim.exe') *> $runLog
 if($LASTEXITCODE -ne 0 -or !(Select-String -LiteralPath $runLog -Pattern '^PASS continuous' -Quiet)) { throw 'Full RTL simulation failed.' }
 Get-Content -LiteralPath $runLog | Select-Object -Last 5
} finally { Pop-Location }

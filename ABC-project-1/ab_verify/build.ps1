$ErrorActionPreference='Stop'
$projectRoot=Split-Path $PSScriptRoot -Parent
$tool='C:\Anlogic\TD_6.2.1_Engineer_6.2.168.116\bin\td_commands_prompt.exe'
if(!(Test-Path -LiteralPath $tool)) { throw "Anlogic TD not found: $tool" }
$buildDir=Join-Path $PSScriptRoot 'td_static'
New-Item -ItemType Directory -Path $buildDir -Force | Out-Null
$xml=Get-Content -LiteralPath (Join-Path $projectRoot 'ABC-project-1.al') -Raw
$xml=$xml -replace ' Path="[^"]*"(?=>\s*<Project_Created_Time>)',''
$xml=$xml.Replace('<File Path="','<File Path="../../')
Set-Content -LiteralPath (Join-Path $buildDir 'ABC-project-1.prj') -Value $xml -Encoding UTF8
Push-Location $buildDir
try {
 Write-Host 'Synthesis... (td_static/td_synth.log)'
 & $tool 'synth.tcl' *> 'td_synth.log'
 if(!(Select-String -LiteralPath 'td_synth.log' -Pattern '^SYNTHESIS_PASS$' -Quiet)) { throw 'Synthesis failed. See td_synth.log.' }
 Write-Host 'Place, route and bit generation... (td_static/td_physical.log)'
 & $tool 'physical.tcl' *> 'td_physical.log'
 if(!(Select-String -LiteralPath 'td_physical.log' -Pattern '^BITSTREAM_GENERATED$' -Quiet)) { throw 'Physical build failed. See td_physical.log.' }
 $timing=Get-Content -LiteralPath 'ABC-project-1_phy.ts' -Raw
 $setup=[regex]::Match($timing,'SWNS:\s*(-?[\d.]+)ns')
 $hold=[regex]::Match($timing,'HWNS:\s*(-?[\d.]+)ns')
 if(!$setup.Success -or !$hold.Success -or [double]$setup.Groups[1].Value -lt 0 -or [double]$hold.Groups[1].Value -lt 0) { throw "Timing did not pass: $timing" }
 Copy-Item -LiteralPath 'ABC-project-1.bit' -Destination (Join-Path $projectRoot 'ABC-project-1.bit') -Force
 Remove-Item -LiteralPath (Join-Path $buildDir 'ABC-project-1.bit') -Force
 Write-Host 'PASS. New bitstream: ABC-project-1.bit'
 Write-Host $timing
} finally { Pop-Location }


$ErrorActionPreference='Stop'
$projectRoot=Split-Path $PSScriptRoot -Parent
$tool='C:\Anlogic\TD_6.2.1_Engineer_6.2.168.116\bin\td_commands_prompt.exe'
$buildDir=Join-Path $PSScriptRoot 'td_diag'
New-Item -ItemType Directory -Path $buildDir -Force | Out-Null
$xml=Get-Content -LiteralPath (Join-Path $projectRoot 'ABC-project-1.al') -Raw
$addition='<File Path="RTL_1/bridge/ab_video_diag_top.v"><FileInfo><Attr Name="UsedInSyn" Val="true"/><Attr Name="UsedInP&R" Val="true"/><Attr Name="BelongTo" Val="design_1"/><Attr Name="CompileOrder" Val="1"/></FileInfo></File>'
$xml=$xml.Replace('</Verilog>',$addition+'</Verilog>')
$xml=$xml -replace ' Path="[^"]*"(?=>\s*<Project_Created_Time>)',''
$xml=$xml.Replace('<File Path="','<File Path="../../')
Set-Content -LiteralPath (Join-Path $buildDir 'ABC-project-1.prj') -Value $xml -Encoding UTF8
Push-Location $buildDir
try {
 & $tool 'synth.tcl' *> 'td_synth.log'
 if(!(Select-String -LiteralPath 'td_synth.log' -Pattern '^SYNTHESIS_PASS$' -Quiet)) { throw 'Diagnostic synthesis failed.' }
 & $tool 'physical.tcl' *> 'td_physical.log'
 if(!(Select-String -LiteralPath 'td_physical.log' -Pattern '^BITSTREAM_GENERATED$' -Quiet)) { throw 'Diagnostic physical build failed.' }
 $timing=Get-Content -LiteralPath 'ABC-project-1_phy.ts' -Raw
 foreach($name in @('SWNS','HWNS')) {
  $match=[regex]::Match($timing,($name+':\s*(-?[\d.]+)ns'))
  if(!$match.Success -or [double]$match.Groups[1].Value -lt 0) { throw 'Diagnostic timing failed.' }
 }
 Copy-Item -LiteralPath 'ABC-video-diagnostic.bit' -Destination $projectRoot -Force
 Write-Host 'PASS diagnostic bitstream and routed timing.'
 Write-Host $timing
} finally { Pop-Location }

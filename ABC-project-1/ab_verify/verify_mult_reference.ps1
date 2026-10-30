$ErrorActionPreference='Stop'
$projectRoot=Split-Path $PSScriptRoot -Parent
$vendor='C:\Anlogic\TD_6.2.1_Engineer_6.2.168.116\sim_release\eg4\eg_phy_mult18.v'
$iv=Join-Path $env:USERPROFILE 'iverilog/bin/iverilog.exe'
$vvp=Join-Path $env:USERPROFILE 'iverilog/bin/vvp.exe'
$results=Join-Path $PSScriptRoot 'results'
New-Item -ItemType Directory -Path $results -Force|Out-Null
$reference=Get-Content -LiteralPath $vendor -Raw
$footer=([string][char]96)+'pragma protect'
$offset=$reference.IndexOf($footer)
if($offset -gt 0){$reference=$reference.Substring(0,$offset)}
# Use the installed, public functional module, with only its module name
# changed to coexist with the fast model. No encrypted payload is decoded.
$reference=$reference.Replace('module EG_PHY_MULT18 (','module EG_PHY_MULT18_VENDOR (')
[System.IO.File]::WriteAllText((Join-Path $results 'vendor_mult18_reference.v'),$reference,[System.Text.UTF8Encoding]::new($false))
Push-Location $projectRoot
try {
 & $iv -g2005 -s tb_mult_reference -s glbl -o ab_verify/results/tb_mult_reference.vvp ab_verify/td_osd_cells.v ab_verify/results/vendor_mult18_reference.v ab_verify/tb_mult_reference.sv *> ab_verify/results/tb_mult_reference_compile.log
 if($LASTEXITCODE -ne 0){throw 'Multiplier reference compile failed.'}
 & $vvp ab_verify/results/tb_mult_reference.vvp *> ab_verify/results/tb_mult_reference_sim.log
 if($LASTEXITCODE -ne 0 -or !(Select-String -LiteralPath ab_verify/results/tb_mult_reference_sim.log -Pattern '^PASS multiplier reference:' -Quiet)){throw 'Multiplier vendor comparison failed.'}
 Get-Content -LiteralPath ab_verify/results/tb_mult_reference_sim.log -Tail 1
}finally{Pop-Location}

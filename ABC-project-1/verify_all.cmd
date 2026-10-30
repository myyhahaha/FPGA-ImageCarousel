@echo off
pwsh -NoProfile -ExecutionPolicy Bypass -File "%~dp0ab_verify\verify.ps1" %*
pause

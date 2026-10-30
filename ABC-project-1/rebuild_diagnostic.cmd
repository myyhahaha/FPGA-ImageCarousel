@echo off
pwsh -NoProfile -ExecutionPolicy Bypass -File "%~dp0ab_verify\build_diagnostic.ps1"
pause

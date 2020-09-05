@echo off

title %~n0
cd /d "%~dp0"

setlocal enabledelayedexpansion

call "%common%sync.bat" true "from" "to"

pause
exit /b 0
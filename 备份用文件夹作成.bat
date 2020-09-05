@echo off

title %~n0

setlocal enabledelayedexpansion

set rootPath=%~dp0

set backSlash=\
if "%rootPath:~-1,1%" neq "%backSlash%" set rootPath=%rootPath%%backSlash%

if not exist "%rootPath%" exit

set nowDate=%date:/=%
set nowDate=%nowDate:~0,8%
set nowTime=%time::=%
set nowTime=%nowTime: =0%
set nowTime=%nowTime:~0,6%

set toFolder=%rootPath%%nowDate:~0,4%\%nowDate:~4,4%\%nowTime%\
if not exist "%toFolder%" md "%toFolder%"

start "" explorer "%toFolder%"
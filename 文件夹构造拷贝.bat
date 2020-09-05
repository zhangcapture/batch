@echo off

title %~n0

setlocal enabledelayedexpansion

set inFile=INPUT_fileList.txt
if not exist "%inFile%" exit

echo Please Input The Path You Want To Get.
set /p inputFolder=
if not defined inputFolder exit
if not exist "%inputFolder%" exit

set strSlash=\
if "%inputFolder:~-1,1%" neq "%strSlash%" (
	set inputFolder=%inputFolder%\
)

set outFolder=OUTPUT
if exist "%outFolder%" rd /s /q "%outFolder%"
md "%outFolder%"

set outFile=OUTPUT_folderTree.txt
type nul> "%outFile%"

echo.
echo ******  Sample ******
echo    X:file not founded.
echo    D:duplicate file
echo.
echo ******copy start****** !date! !time!

set inputRecNo=1
for /f "delims=" %%i in (%inFile%) do (
	call :copyFile "%%i"
	
	if "!flgFileExist!" equ "0" (
		echo X line !inputRecNo! : %%i
	) else (
		if "!flgFileExist!" equ "2" (
			echo D line !inputRecNo! : %%i
		)
	)
	
	set /a "inputRecNo += 1"
)

tree /f "%outFolder%" > "%outFile%"

echo.
echo ******copy   end****** !date! !time!

pause
exit


:copyFile

set flgFileExist=0

for /r "%inputFolder%" %%z in ("*%~1*") do (
	if /i "%%~nxz" equ "%~1" (
		set flgFileExist=1
		set fileFolder=%%~dpz
		call set fileFolder=^!fileFolder:%inputFolder%=^!
		set fileFolder=%outFolder%\!fileFolder!
		
		if not exist "!fileFolder!" md "!fileFolder!"
		
		if exist "!fileFolder!%%~nxz" (
			set flgFileExist=2
			goto copyFileEnd
		) else (
			copy "%%z" "!fileFolder!%%~nxz"> nul
		)
	)
)

:copyFileEnd
exit /b 0
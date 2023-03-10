@echo off

SET NX_RELEASE=%1
SET UNIT_PATH=%2
SET HC_FLAG=%3
SET UNIT_BAT="C:\apps\devop_tools\UDU\tools\bin\wnt\unit.bat"
echo "at start"

if %HC_FLAG%==false (
	call %UNIT_BAT% add -b -p @%NX_RELEASE% -t DEV -w SUB %UNIT_PATH% -R y -O y -DO_LINK_OPT y
) else (
	echo "at start"
	call %UNIT_BAT% add -b -p @%NX_RELEASE% -t DEV -w SUB %UNIT_PATH% -R y -O y -DO_LINK_OPT y
	echo "i am here"
	SET WIN_PATH=%UNIT_PATH:/=\%
	SET "ONE=1"
	SET "ZERO=0"
	SET initFile=%WIN_PATH%\init.def
	
	( for /f "tokens=1,2* delims=: " %%A in (
		'findstr /N "^" %initFile%'
	  )  do (
		if "%%B"=="DO_TARI_RECOMPILES" (
			echo=%%B	%ONE%
		)>%UNIT_PATH%/initbk1.txt
		REM else if "%%B"=="DO_SOURCE_RECOMPILES" (
			REM echo=%%B	%ONE%
		REM )else if "%%B"=="DO_LINK_OPT" (
			REM echo=%%B	%ONE%
		REM )else if "%%B"=="DO_QAZ" (
			REM echo=%%B	%ONE%
		REM )else if "%%B"=="DO_DLL_COMPARISON" (
			REM echo=%%B	%ONE%
		REM )else if "%%B"=="DO_DEBUG" (
			REM echo=%%B	%ZERO%
		REM ) else (
			REM echo=%%B	%%C
		REM )
	)>%UNIT_PATH%/initbk2.txt
	)>%UNIT_PATH%/initbk3.txt
	echo "i am here2"
	rem del %initFile%
	rem rename %UNIT_PATH%//initbk.def "init.def"
) 
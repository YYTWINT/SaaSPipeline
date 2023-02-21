@echo off

SET NX_RELEASE=%1
SET UNIT_PATH=%2
SET HC_FLAG=%3
SET UNIT_BAT="C:\apps\devop_tools\UDU\tools\bin\wnt\unit.bat"


if %HC_FLAG%==false (
	call %UNIT_BAT% add -b -p @%NX_RELEASE% -t DEV -w SUB %UNIT_PATH% -R y -O y -DO_LINK_OPT y
) else (
	call %UNIT_BAT% add -b -p @%NX_RELEASE% -t DEV -w SUB %UNIT_PATH% -R y -O y -DO_LINK_OPT y
	REM SET "ONE=1"
	REM SET "ZERO=0"
	REM SET initFile=%UNIT_PATH%/init.def

	REM ( for /f "tokens=1,2* delims=: " %%A in (
		REM 'findstr /N "^" %initFile%'
	  REM )  do (
		REM if "%%B"=="DO_TARI_RECOMPILES" (
			REM echo=%%B	%ONE%
		REM ) else if "%%B"=="DO_SOURCE_RECOMPILES" (
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
	REM )
	REM ) >%UNIT_PATH%/init_bk.def
	REM del %initFile%
	REM rename %UNIT_PATH%/init_bk.def "init.def"
		REM SET initFile=%UNIT_PATH%/init.def
	REM sed -i 's/DO_TARI_RECOMPILES.*/DO_TARI_RECOMPILES       1/g' %initFile%
	REM sed -i 's/DO_SOURCE_RECOMPILES.*/DO_SOURCE_RECOMPILES       1/g' %initFile%
	REM sed -i 's/DO_LINK_OPT.*/DO_LINK_OPT       1/g' %initFile%
	REM sed -i 's/DO_DEBUG.*/DO_DEBUG       0/g' %initFile%
	REM sed -i 's/DO_QAZ.*/DO_QAZ       1/g' %initFile%
	REM sed -i 's/DO_DLL_COMPARISON.*/DO_DLL_COMPARISON       1/g' %initFile%
) 
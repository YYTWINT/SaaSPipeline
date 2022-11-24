@echo off

SET NX_RELEASE=%1
SET UNIT_PATH=%2
SET HC_FLAG=%3
SET UNIT_BAT="C:\apps\devop_tools\UDU\tools\bin\wnt\unit.bat"


if %HC_FLAG%==false (
	call %UNIT_BAT% add -b -p @%NX_RELEASE% -t DEV -w SUB %UNIT_PATH% -R y -O y -DO_LINK_OPT y
) else (
	call %UNIT_BAT% add -b -p @%NX_RELEASE% -t DEV -w SUB %UNIT_PATH% -R y -O y -DO_LINK_OPT y

	REM SET initFile=%UNIT_PATH%/init.def
	REM sed -i 's/DO_TARI_RECOMPILES.*/DO_TARI_RECOMPILES       1/g' %initFile%
	REM sed -i 's/DO_SOURCE_RECOMPILES.*/DO_SOURCE_RECOMPILES       1/g' %initFile%
	REM sed -i 's/DO_LINK_OPT.*/DO_LINK_OPT       1/g' %initFile%
	REM sed -i 's/DO_DEBUG.*/DO_DEBUG       0/g' %initFile%
	REM sed -i 's/DO_QAZ.*/DO_QAZ       1/g' %initFile%
	REM sed -i 's/DO_DLL_COMPARISON.*/DO_DLL_COMPARISON       1/g' %initFile%
) 
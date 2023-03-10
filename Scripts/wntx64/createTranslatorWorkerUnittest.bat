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
	xcopy /s /i /Y "%UNIT_PATH%/init.def" "%UNIT_PATH%/init_bk.def"
	
	( for /f "tokens=1,2* delims=: " %%A in (
		'findstr /N "^" %initFile%'
	  )  do (
		if "%%B"=="DO_TARI_RECOMPILES" (
			echo=%%B	%ONE%
		) else if "%%B"=="DO_SOURCE_RECOMPILES" (
			echo=%%B	%ONE%
		)else if "%%B"=="DO_LINK_OPT" (
			echo=%%B	%ONE%
		)else if "%%B"=="DO_QAZ" (
			echo=%%B	%ONE%
		)else if "%%B"=="DO_DLL_COMPARISON" (
			echo=%%B	%ONE%
		)else if "%%B"=="DO_DEBUG" (
			echo=%%B	%ZERO%
		) else (
			echo=%%B	%%C
		)
	)
	)>"%UNIT_PATH%/init_bk.def"
	echo "i am here2"
	del %initFile%
	rename %WIN_PATH%\init_bk.def "init.def"
) 
@echo off

rem "executeTranslatorWorkerTest.sh called with incorrect number of arguments."
rem "executeTranslatorWorkerTest.sh <UnitPath>"
rem "For example; executeTranslatorWorkerTest.sh /plm/pnnas/ppic/users/<unit_name>"

SET UNIT_PATH=%1
SET UNIT_BAT="C:\apps\devop_tools\UDU\tools\bin\wnt\unit.bat"
call %UNIT_BAT% run %UNIT_PATH% devtest runtest NXTranslators.rep:TranslatorWorker.set -p 6
for /F "tokens=2 delims=:" %%a in ('findstr /I "Number of tests:" "%UNIT_PATH%\dt\runs\devtestLastRunFails.txt"') do set "casesFailed=%%a"  
if %casesFailed% NEQ 0 (
	call %UNIT_BAT% run %UNIT_PATH% devtest runfails -p 6 -keep -local -parent
	for /F "tokens=2 delims=:" %%a in ('findstr /I "Number of tests:" "%UNIT_PATH%\dt\runs\devtestLastRunFails.txt"') do set "casesFailed=%%a"  
	if %casesFailed% NEQ 0 (
		echo "Number of auto test cases failed = %casesFailed%...Exiting with error."
		exit 1
	)
) else (
	 echo "No test case failed. So skipping re-run of devtest."
)

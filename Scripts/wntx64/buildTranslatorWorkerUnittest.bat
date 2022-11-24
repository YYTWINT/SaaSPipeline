@echo off

SET UNIT_PATH=%1
SET CP_NUMBER=%2
SET HC_FLAG=%3
SET UNIT_BAT="C:\apps\devop_tools\UDU\tools\bin\wnt\unit.bat"
if %HC_FLAG%==false (
  call %UNIT_BAT% run %UNIT_PATH% b product TranslatorWorker
  call %UNIT_BAT% run %UNIT_PATH% b product validate_worker TranslatorWorker
  echo "here in windows hc false"
) else (
  call %UNIT_BAT% run %UNIT_PATH% C:\\apps\\devop_tools\\bin\\dtcmd.pl cli set -C -A %CP_NUMBER%
  call %UNIT_BAT% run %UNIT_PATH% b
  call %UNIT_BAT% run %UNIT_PATH% b image ugtopv
  call %UNIT_BAT% run %UNIT_PATH% b product TranslatorWorker
  call %UNIT_BAT% run %UNIT_PATH% b product validate_worker TranslatorWorker
  echo "here in windows hc true"
)
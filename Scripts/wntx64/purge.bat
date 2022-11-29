@echo off

SET WORK_DIR=$1
SET NumberOfBackups=5

echo "Purging dir %WORK_DIR%"

cd %WORK_DIR%
for /F "skip=%NumberOfBackups% eol=| delims=" %%I in ('dir /ad /B /O-D 2^>nul') do rd /s /q "%%I"
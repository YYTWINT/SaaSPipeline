@echo off

REM "stage_and_deploy_artifacts.bat called with incorrect number of arguments."
REM "stage_and_deploy_artifacts.bat <unitPaht> <StageBaseDir> <CustomerArtifactDir> <DeployFlag>"
REM "For example; stage_and_deploy_artifacts.bat /plm/pnnas/ppic/users/<unit_name> /plm/pnnas/ppic/users/<Win_STAGE_DIR> <Artifacts>"

echo "Executing stage_and_deploy_artifacts.bat for windows..."

SET UNIT_PATH=%1
SET STAGE_BASE_DIR=%2
SET CUSTOMER_ARTIFACTS_DIR=%3

SET INIT_DEF_FILE=%UNIT_PATH%\init.def
for /F "tokens=2" %%a in ('findstr /I "DMS_PARENT_BASELINE" "%INIT_DEF_FILE%"') do set "RELEASE_IP=%%a"  
SET orig=%RELEASE_IP%
for /f "tokens=1 delims=." %%A in ("%RELEASE_IP%") do set "NXVersion=%%A
for /f "tokens=2 delims=." %%A in ("%RELEASE_IP%") do set "NXIP=%%A

rem #############################################
rem #Windows Staging
rem #############################################

SET Win_STAGE_DIR=%STAGE_BASE_DIR%/wntx64/TranslatorBinaries/
SET Win_SOURCE_PATH=%UNIT_PATH%/wntx64/Products/TranslatorWorker

if not exist %Win_STAGE_DIR% mkdir %Win_STAGE_DIR%

rem Copy all 
xcopy /s %Win_SOURCE_PATH% %Win_STAGE_DIR%

rem Then remove selected iteams
IF EXIST %Win_STAGE_DIR%/debug DEL /F %Win_STAGE_DIR%/debug
IF EXIST %Win_STAGE_DIR%/license DEL /F %Win_STAGE_DIR%/license
IF EXIST %Win_STAGE_DIR%/dockerfile DEL /F %Win_STAGE_DIR%/dockerfile

SET CONFIG_FILE_MULTICAD_WIN=%Win_STAGE_DIR%/tessUG_multicad.config
SET CONFIG_FILE_VIS_WIN=%Win_STAGE_DIR%/tessUG_vis.config
SET RUN_UGTOPV_MULTICAD_WIN=%Win_STAGE_DIR%/run_ugtopv_multicad.bat
SET RUN_UGTOPV_VIS_WIN=%Win_STAGE_DIR%/run_ugtopv_vis.bat

xcopy /s %CUSTOMER_ARTIFACTS_DIR%/wntx64/%NXVersion%/run_ugtopv_multicad.bat %RUN_UGTOPV_MULTICAD_WIN%
xcopy /s %CUSTOMER_ARTIFACTS_DIR%/wntx64/%NXVersion%/run_ugtopv_vis.bat %RUN_UGTOPV_VIS_WIN%
xcopy /s %CUSTOMER_ARTIFACTS_DIR%/wntx64/%NXVersion%/tessUG_multicad.config %CONFIG_FILE_MULTICAD_WIN%
xcopy /s %CUSTOMER_ARTIFACTS_DIR%/wntx64/%NXVersion%/tessUG_vis.config %CONFIG_FILE_VIS_WIN%
xcopy /s %CUSTOMER_ARTIFACTS_DIR%/wntx64/%NXVersion%/NXJT_Translator_README.txt %STAGE_BASE_DIR%/wntx64/

rem copy the staging folder to common location
SET FolderName=%NXVersion%_TranslatorWorker.%NXIP%
if not exist "\\plm\pnnas\ppic\Data_Exchange\SaaS_distributions\NXJT\%FolderName%\wntx64" mkdir "\\plm\pnnas\ppic\Data_Exchange\SaaS_distributions\NXJT\%FolderName%\wntx64"
xcopy /s "%STAGE_BASE_DIR%/wntx64/" "\\plm\pnnas\ppic\Data_Exchange\SaaS_distributions\NXJT\%FolderName%\wntx64\"
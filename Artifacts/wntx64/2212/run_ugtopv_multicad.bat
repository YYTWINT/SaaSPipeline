@rem  run_ugtopv_multicad
@rem  Copyright 2014 Siemens Product Lifecycle Management Software Inc.
@rem  This script selects an appropriate version of UG translator

@if not defined UGII_BASE_DIR goto :no_ug
@if not exist  "%UGII_BASE_DIR%" goto :no_ug

@if not defined SPLM_LICENSE_SERVER goto :no_license

@set PATH=%UGII_BASE_DIR%\nxbin;%PATH%

@"%UGII_BASE_DIR%\pvtrans\ugtopv.exe" -enable_hybrid_saas -single_part -config=%UGII_BASE_DIR%\tessUG_multicad.config %*

@endlocal

@goto :end

:no_ug
@echo "The environment variable UGII_BASE_DIR is not set"
@echo "Please set this environment variable before running the translator"
@echo "Exiting..."
@goto :end

:no_license
@echo "The environment variable SPLM_LICENSE_SERVER environment is not set"
@echo "Please set this environment variable before running the translator"
@echo "Exiting..."
@goto :end

:end

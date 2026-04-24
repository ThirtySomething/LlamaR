@REM ***************************************************************************
@REM * re.bat
@REM ***************************************************************************
@REM * Script to download latest Llama program from GitHub,
@REM * extract the archive and decompile the dex file.
@REM ***************************************************************************
@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION

@REM ***************************************************************************
@REM * Setting of base variables
@REM ***************************************************************************
SET "DIR_BASE=%~dp0"
SET "DIR_WORK=%DIR_BASE%work"
SET "DIR_WORK_JADX=%DIR_WORK%\jadx"
SET "DIR_WORK_LLAMA=%DIR_WORK%\LlamaR"
SET "FILE_APK_LLAMA_RAW=Llama.1.2014.11.20.2330.apk"
SET "FILE_APK_LLAMA=%DIR_BASE%assets\%FILE_APK_LLAMA_RAW%"
SET "FILE_JADX_ARCHIVE=%DIR_WORK%\jadx.zip"
SET "FILE_JADX_BAT=%DIR_WORK_JADX%\bin\jadx.bat"
SET "FILE_LLAMA_DEX=%DIR_WORK%\%FILE_NAME_CLASS_DEX%"
SET "FILE_NAME_CLASS_DEX=classes.dex"
SET "FILE_SCRIPT=%~nx0"
SET "URL_JADX_RAW=https://api.github.com/repos/skylot/jadx/releases/latest"

@REM ***************************************************************************
@REM * Check for admin privileges
@REM ***************************************************************************
NET SESSION >NUL 2>&1
IF  %ERRORLEVEL% NEQ 0 (
    ECHO.
    ECHO.[%FILE_SCRIPT%] requires administrator privileges.
    ECHO.Please run the script as an administrator.
    ECHO.
    GOTO :END_SCRIPT
)

@REM ***************************************************************************
@REM * Prepare working directory
@REM ***************************************************************************
ECHO.Ensure empty working directory [%DIR_WORK%]
IF EXIST "%DIR_WORK%" (
    RMDIR /s /q "%DIR_WORK%"
)
MKDIR "%DIR_WORK%"

@REM ***************************************************************************
@REM * Set case sensitivity for the working directory
@REM ***************************************************************************
ECHO.Set case sensitivity for working directory [%DIR_WORK%]
FSUTIL file setCaseSensitiveInfo "%DIR_WORK%" enable >NUL 2>&1
PUSHD "%DIR_WORK%"

@REM ***************************************************************************
@REM * Download latest JADX from GitHub
@REM ***************************************************************************
ECHO.Fetching latest JADX release info from GitHub...
FOR /f "usebackq delims=" %%A IN (`
  POWERSHELL -NoLogo -NoProfile -Command ^
    "$r = Invoke-RestMethod '%URL_JADX_RAW%';" ^
    "$asset = $r.assets | Where-Object { $_.name -match 'jadx.*\.zip' } | Select-Object -First 1;" ^
    "if ($asset) { $asset.browser_download_url }"
`) DO (
    SET "URL_JADX_VERSION=%%A"
)
IF NOT DEFINED URL_JADX_VERSION (
    ECHO.ERROR: Could not determine latest JADX download URL, abort
    GOTO :END_SCRIPT
)
ECHO.Latest JADX is [%URL_JADX_VERSION%], downloading...
CURL -s -S -L -o "%FILE_JADX_ARCHIVE%" "%URL_JADX_VERSION%" >NUL 2>&1
IF %ERRORLEVEL% NEQ 0 (
    ECHO.ERROR: Download of [%URL_JADX_VERSION%] failed, abort
    GOTO :END_SCRIPT
)

@REM ***************************************************************************
@REM * Extract JADX archive
@REM ***************************************************************************
ECHO.Extract JADX to [%DIR_WORK_JADX%]
UNZIP "%FILE_JADX_ARCHIVE%" -d "%DIR_WORK_JADX%" >NUL 2>&1

@REM ***************************************************************************
@REM * Decompile Llama APK using JADX
@REM ***************************************************************************
ECHO.Decompile [%FILE_APK_LLAMA_RAW%] to [%DIR_WORK_LLAMA%] using JADX
"%FILE_JADX_BAT%" "%FILE_APK_LLAMA%" -d "%DIR_WORK_LLAMA%" >NUL 2>&1

:END_SCRIPT
POPD

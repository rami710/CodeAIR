@echo off
setlocal EnableExtensions
cd /d "%~dp0"

where bun >nul 2>nul
if errorlevel 1 (
  echo Bun is required. Install it from https://bun.sh, then run this file again.
  exit /b 1
)

set "OPENCODE_CHANNEL=dev"
set "OPENCODE_TARGET=windows-x64"
set "OPENCODE_DESKTOP_APP="

 echo Installing project dependencies...
call bun install
if errorlevel 1 goto failed

echo Building the desktop application...
call bun run --cwd packages/desktop build
if errorlevel 1 goto failed

echo Packaging the Windows application...
call bun run --cwd packages/desktop pack
if errorlevel 1 goto failed

rem pack.bat's second pass clears dist/desktop, so stage the unpacked app outside that directory.
set "STAGED_APP=%TEMP%\codeair-desktop-%RANDOM%-%RANDOM%"
robocopy "%~dp0dist\desktop\app" "%STAGED_APP%" /E /NFL /NDL /NJH /NJS /NC /NS >nul
if errorlevel 8 goto failed

set "OPENCODE_DESKTOP_APP=%STAGED_APP%"
call bun run --cwd packages/desktop pack
set "BUILD_EXIT=%ERRORLEVEL%"
set "OPENCODE_DESKTOP_APP="
rmdir /s /q "%STAGED_APP%" >nul 2>nul
if not "%BUILD_EXIT%"=="0" goto failed

echo.
echo Installer created: %~dp0dist\desktop\opencode-desktop-win-x64.exe
pause
exit /b 0

:failed
echo.
echo Build failed. Review the error above, then try again.
pause
exit /b 1

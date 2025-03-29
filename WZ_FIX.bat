@echo off
setlocal enabledelayedexpansion

REM Check if running with administrative privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Error. Run with admin
    pause
    exit /b
)

REM Store service states to restore them later
set "SRVCNAME=WinDivert"
set WINDIVERT_RUNNING=0
set WINDIVERT14_RUNNING=0
set WINDIVERT32_RUNNING=0
set WINDIVERT64_RUNNING=0
set GOODBYEDPI_RUNNING=0
set ZAPRET_RUNNING=0

sc query "WinDivert" >nul 2>&1
if %errorlevel% equ 0 set WINDIVERT_RUNNING=1

sc query "WinDivert14" >nul 2>&1
if %errorlevel% equ 0 set WINDIVERT14_RUNNING=1

sc query "WinDivert32" >nul 2>&1
if %errorlevel% equ 0 set WINDIVERT32_RUNNING=1

sc query "WinDivert64" >nul 2>&1
if %errorlevel% equ 0 set WINDIVERT64_RUNNING=1

sc query "GoodbyeDPI" >nul 2>&1
if %errorlevel% equ 0 set GOODBYEDPI_RUNNING=1

sc query "zapret" >nul 2>&1
if %errorlevel% equ 0 set ZAPRET_RUNNING=1

REM Save service states to a temp file to handle script closure
echo WINDIVERT_RUNNING=!WINDIVERT_RUNNING!>"%TEMP%\wz_fix_services.tmp"
echo WINDIVERT14_RUNNING=!WINDIVERT14_RUNNING!>>"%TEMP%\wz_fix_services.tmp"
echo WINDIVERT32_RUNNING=!WINDIVERT32_RUNNING!>>"%TEMP%\wz_fix_services.tmp"
echo WINDIVERT64_RUNNING=!WINDIVERT64_RUNNING!>>"%TEMP%\wz_fix_services.tmp"
echo GOODBYEDPI_RUNNING=!GOODBYEDPI_RUNNING!>>"%TEMP%\wz_fix_services.tmp"
echo ZAPRET_RUNNING=!ZAPRET_RUNNING!>>"%TEMP%\wz_fix_services.tmp"

REM Create a cleanup script that will run on exit
echo @echo off>"%TEMP%\wz_fix_cleanup.bat"
echo setlocal enabledelayedexpansion>>"%TEMP%\wz_fix_cleanup.bat"
echo for /f "tokens=1,2 delims==" %%%%a in ('type "%%TEMP%%\wz_fix_services.tmp"') do (>>"%TEMP%\wz_fix_cleanup.bat"
echo   set %%%%a=%%%%b>>"%TEMP%\wz_fix_cleanup.bat"
echo )>>"%TEMP%\wz_fix_cleanup.bat"
echo if !WINDIVERT_RUNNING! equ 1 net start "WinDivert" ^>nul 2^>^&1>>"%TEMP%\wz_fix_cleanup.bat"
echo if !WINDIVERT14_RUNNING! equ 1 net start "WinDivert14" ^>nul 2^>^&1>>"%TEMP%\wz_fix_cleanup.bat"
echo if !WINDIVERT32_RUNNING! equ 1 net start "WinDivert32" ^>nul 2^>^&1>>"%TEMP%\wz_fix_cleanup.bat"
echo if !WINDIVERT64_RUNNING! equ 1 net start "WinDivert64" ^>nul 2^>^&1>>"%TEMP%\wz_fix_cleanup.bat"
echo if !GOODBYEDPI_RUNNING! equ 1 net start "GoodbyeDPI" ^>nul 2^>^&1>>"%TEMP%\wz_fix_cleanup.bat"
echo if !ZAPRET_RUNNING! equ 1 net start "zapret" ^>nul 2^>^&1>>"%TEMP%\wz_fix_cleanup.bat"
echo echo Services restored. Cleanup complete.>>"%TEMP%\wz_fix_cleanup.bat"
echo del "%%TEMP%%\wz_fix_services.tmp">>"%TEMP%\wz_fix_cleanup.bat"
echo timeout /t 3 ^>nul>>"%TEMP%\wz_fix_cleanup.bat"
echo exit>>"%TEMP%\wz_fix_cleanup.bat"

REM Register the cleanup script to run when this script exits
reg add "HKCU\Software\Microsoft\Command Processor" /v AutoRun /d "cmd.exe /c \"%TEMP%\wz_fix_cleanup.bat\" && reg delete \"HKCU\Software\Microsoft\Command Processor\" /v AutoRun /f" /f >nul 2>&1

REM Your existing commands for stopping processes and services
taskkill /IM winws.exe /F >nul 2>&1
taskkill /IM goodbyedpi.exe /F >nul 2>&1
net stop %SRVCNAME% >nul 2>&1
net stop "WinDivert" >nul 2>&1
net stop "WinDivert14" >nul 2>&1
net stop "WinDivert32" >nul 2>&1
net stop "WinDivert64" >nul 2>&1
net stop "GoodbyeDPI" >nul 2>&1
net stop "zapret" >nul 2>&1

REM Start the game
start steam://rungameid/1962663

REM Display a message and minimize the window
title WZ_FIX - Services stopped
echo Services stopped. Window minimized to background.
echo Press ENTER to restore services and close the script.
powershell -command "(New-Object -ComObject Shell.Application).MinimizeAll()"

REM Wait for user input
pause >nul

REM Restore services that were running before
if %WINDIVERT_RUNNING% equ 1 net start "WinDivert" >nul 2>&1
if %WINDIVERT14_RUNNING% equ 1 net start "WinDivert14" >nul 2>&1
if %WINDIVERT32_RUNNING% equ 1 net start "WinDivert32" >nul 2>&1
if %WINDIVERT64_RUNNING% equ 1 net start "WinDivert64" >nul 2>&1
if %GOODBYEDPI_RUNNING% equ 1 net start "GoodbyeDPI" >nul 2>&1
if %ZAPRET_RUNNING% equ 1 net start "zapret" >nul 2>&1

REM Clean up the AutoRun registry key
reg delete "HKCU\Software\Microsoft\Command Processor" /v AutoRun /f >nul 2>&1
del "%TEMP%\wz_fix_cleanup.bat" >nul 2>&1
del "%TEMP%\wz_fix_services.tmp" >nul 2>&1

echo Services restored. Script is shutting down.
timeout /t 3 >nul
exit /b
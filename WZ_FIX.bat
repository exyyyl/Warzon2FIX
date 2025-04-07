 @echo off
setlocal enabledelayedexpansion

REM Check if running with administrative privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Error: This script requires administrative privileges.
    echo Please right-click and select "Run as administrator".
    pause
    exit /b
)

REM Define variables
set "SRVCNAME=WinDivert"
set WINDIVERT_RUNNING=0
set WINDIVERT14_RUNNING=0
set WINDIVERT32_RUNNING=0
set WINDIVERT64_RUNNING=0
set GOODBYEDPI_RUNNING=0
set ZAPRET_RUNNING=0

REM Check which services are running
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

REM Save service states to a temp file
echo WINDIVERT_RUNNING=!WINDIVERT_RUNNING!>"%TEMP%\wz_fix_services.tmp"
echo WINDIVERT14_RUNNING=!WINDIVERT14_RUNNING!>>"%TEMP%\wz_fix_services.tmp"
echo WINDIVERT32_RUNNING=!WINDIVERT32_RUNNING!>>"%TEMP%\wz_fix_services.tmp"
echo WINDIVERT64_RUNNING=!WINDIVERT64_RUNNING!>>"%TEMP%\wz_fix_services.tmp"
echo GOODBYEDPI_RUNNING=!GOODBYEDPI_RUNNING!>>"%TEMP%\wz_fix_services.tmp"
echo ZAPRET_RUNNING=!ZAPRET_RUNNING!>>"%TEMP%\wz_fix_services.tmp"

REM Stop VPN and anti-censorship services
taskkill /IM winws.exe /F >nul 2>&1
taskkill /IM goodbyedpi.exe /F >nul 2>&1
net stop %SRVCNAME% >nul 2>&1
net stop "WinDivert" >nul 2>&1
net stop "WinDivert14" >nul 2>&1
net stop "WinDivert32" >nul 2>&1
net stop "WinDivert64" >nul 2>&1
net stop "GoodbyeDPI" >nul 2>&1
net stop "zapret" >nul 2>&1

REM Start the game (uncomment the line below if you want to start the game automatically)
REM start steam://rungameid/1962663

REM Display a message and minimize the window
title WZ_FIX - Services stopped
echo Services stopped. Window minimized to background.
echo Press ENTER to restore services and close the script.

REM Wait for user input
pause >nul

REM Restore services that were running before
if %WINDIVERT_RUNNING% equ 1 net start "WinDivert" >nul 2>&1
if %WINDIVERT14_RUNNING% equ 1 net start "WinDivert14" >nul 2>&1
if %WINDIVERT32_RUNNING% equ 1 net start "WinDivert32" >nul 2>&1
if %WINDIVERT64_RUNNING% equ 1 net start "WinDivert64" >nul 2>&1
if %GOODBYEDPI_RUNNING% equ 1 net start "GoodbyeDPI" >nul 2>&1
if %ZAPRET_RUNNING% equ 1 net start "zapret" >nul 2>&1

REM Clean up
del "%TEMP%\wz_fix_services.tmp" >nul 2>&1

echo Services restored. Script is shutting down.
timeout /t 3 >nul
exit /b
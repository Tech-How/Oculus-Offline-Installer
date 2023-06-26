@echo off
title Reset Oculus Backup

goto integrity
:integrityfail
cls
echo Integrity check failed.
echo.
echo Please re-download this program from GitHub, making sure to extract all files and disable any software that could
echo interfere with extraction.
echo.
echo.
echo View minimized command window in taskbar for more info...
echo Press any key to exit...
timeout -1 >nul
exit
:integrity
echo Verifying integrity...
del /q "%temp%\IntegrityVerification.store" >nul 2>&1
del /q "%temp%\IntegrityVerificationDone.store" >nul 2>&1
start "INTEGRITY" /min "%cd%\Integrity.cmd"
:integritywait
timeout 1 /nobreak >nul
if not exist "%temp%\IntegrityVerificationDone.store" goto integritywait
if not exist "%temp%\IntegrityVerification.store" goto integrityfail
cls

Redistributables\NirCmd.exe qboxcom "You are about to reset the currently stored configuration, which will delete this backup from your hard drive. The current Oculus installation will not be affected.~n~nProceed?" "Reset Oculus Backup" inisetval "Redistributables\Reset.ini" "section1" "TestValue" "1"
if exist Redistributables\Reset.ini goto reset
exit

:reset
del /q Redistributables\Reset.ini
echo Reset in progress...
rd /s /q Oculus >nul 2>&1
md Oculus >nul 2>&1
rd /s /q AppData >nul 2>&1
md AppData >nul 2>&1
echo.
echo.
echo Reset Complete.
Redistributables\NirCmd.exe infobox "Reset Complete." "Reset Oculus Backup"
exit
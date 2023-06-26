@echo off
title Oculus Backup Tool

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
timeout 1 /nobreak >nul
if not exist "%temp%\IntegrityVerificationDone.store" goto integrity
if not exist "%temp%\IntegrityVerification.store" goto integrityfail
cls

if exist Oculus\Support Redistributables\NirCmd.exe infobox "Configuration data from a previous backup is still present. Please run the Reset script to clear any previously backed up data before proceeding." "Oculus Backup Tool" && exit
if exist AppData\Local Redistributables\NirCmd.exe infobox "Configuration data from a previous backup is still present. Please run the Reset script to clear any previously backed up data before proceeding." "Oculus Backup Tool" && exit
if exist AppData\Roaming Redistributables\NirCmd.exe infobox "Configuration data from a previous backup is still present. Please run the Reset script to clear any previously backed up data before proceeding." "Oculus Backup Tool" && exit
if not exist "C:\Program Files\Oculus\Support" Redistributables\NirCmd.exe infobox "Oculus was not detected on this computer. No data found to backup.~n~nPlease note:~nOnly the default installation directory is supported. You can use another directory by creating a symbolic link to the default installation directory, however it's not recommended nor supported." "Oculus Backup Tool" && exit
Redistributables\NirCmd.exe infobox "This utility will backup your current Oculus data, including your installed software version and headset configuration. In order for the restore process to complete successfully, please ensure you are signed in to the Oculus Client and have configured your headset.~n~nPlease note: All downloaded software will be included in the backup, which can significantly extend the backup time. To avoid this, uninstall items from your Oculus library before running this utility.~n~n~nPress OK to start the backup process." "Oculus Backup Tool"
set "installpath=C:\Program Files\Oculus\"
echo Backing up Oculus...
Xcopy /E "%installpath%." "%cd%\Oculus\" /y >nul 2>&1
echo.
echo Backing up User Data...
Xcopy /E "%LocalAppData%\Oculus" "%cd%\AppData\Local\Oculus\" /y >nul 2>&1
Xcopy /E "%AppData%\Oculus" "%cd%\AppData\Roaming\Oculus\" /y >nul 2>&1
Xcopy /E "%AppData%\OculusClient" "%cd%\AppData\Roaming\OculusClient\" /y >nul 2>&1
echo.
echo.
echo Backup Complete.
Redistributables\NirCmd.exe infobox "Backup complete. Use the Install script to install this configuration on another machine." "Oculus Backup Tool"
pause
exit
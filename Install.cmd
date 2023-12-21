@echo off
title Oculus Setup

if exist "%temp%\BypassIntegrityCheck.store" del /q "%temp%\BypassIntegrityCheck.store" && goto BypassIntegrityCheck
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
echo BypassIntegrity > "%temp%\BypassIntegrityCheck.store"
:BypassIntegrityCheck

set "args=%~dp0." && if "%*" neq "" set "args=%*"
net file 1>nul 2>nul
if errorlevel 1 echo Requesting administrative privileges... && powershell -Command "Start-Process -FilePath \"%0\" -ArgumentList \"%args%\" -Verb runas" >nul 2>&1 & exit /b
cd /d %~dp0
  
title Oculus Setup
set "installpath=C:\Program Files\Oculus\"
md TestDir >nul 2>&1
if errorlevel 1 Redistributables\NirCmd.exe infobox "Oculus Setup doesn't work on write-protected disks. Please remove the write-protection and try again." "Oculus Setup" && exit
rd TestDir >nul 2>&1

if not exist Oculus\Support Redistributables\NirCmd.exe infobox "There is no backup to install from. Please follow the instructions on GitHub and run the Backup script on a machine with Oculus already installed to prepare this utility for installation." "Oculus Setup" && exit
if not exist AppData\Local Redistributables\NirCmd.exe infobox "There is no backup to install from. Please follow the instructions on GitHub and run the Backup script on a machine with Oculus already installed to prepare this utility for installation." "Oculus Setup" && exit
if not exist AppData\Roaming Redistributables\NirCmd.exe infobox "There is no backup to install from. Please follow the instructions on GitHub and run the Backup script on a machine with Oculus already installed to prepare this utility for installation." "Oculus Setup" && exit
if exist "%installpath%Support" Redistributables\NirCmd.exe infobox "Oculus is already installed on this machine." "Oculus Setup" && exit
Redistributables\NirCmd.exe qboxcom "Ready to install.~n~nAfter installation, your computer will reboot.~nWould you like to proceed with the installation now?" "Oculus Setup" inisetval "Redistributables\Install.ini" "section1" "TestValue" "1"
if not exist Redistributables\Install.ini exit
del /q Redistributables\Install.ini
Redistributables\NirCmd.exe qboxcom "Would you like to block communication with Facebook and Oculus? This can be removed later by running the uninstaller.~n~nUse this mode if you only want the Oculus dash and headset drivers installed, and don't plan on using the store." "Oculus Setup" inisetval "Redistributables\BlockNet.ini" "section1" "TestValue" "1"
if exist Redistributables\BlockNet.ini goto blockcomms
:resumesetup
:: Restore registry entries
regedit /s "%cd%\Registry\Oculus.reg"
regedit /s "%cd%\Registry\Uninstall.reg"
:: Copy Oculus software
echo Copying Oculus Software...
Xcopy /E "%cd%\Oculus" "%installpath%" /y >nul 2>&1
Xcopy /E "%cd%\Shortcuts\programdataStartMenu\Oculus" "%programdata%\Microsoft\Windows\Start Menu\Oculus\" >nul 2>&1
Xcopy /E "%cd%\Shortcuts\publicDesktop" "%systemdrive%\Users\Public\Desktop\" >nul 2>&1
:: Restore AppData backup
echo. 
echo Copying User Data...
Xcopy /E "%cd%\AppData\Local\Oculus" "%LocalAppData%\Oculus\" /y >nul 2>&1
Xcopy /E "%cd%\AppData\Roaming\Oculus" "%AppData%\Oculus\" /y >nul 2>&1
Xcopy /E "%cd%\AppData\Roaming\OculusClient" "%AppData%\OculusClient\" /y >nul 2>&1
:: Add Environment Variables
echo.
echo Setting Environment Paths...
reg add "HKCU\Software\Oculus VR, LLC\Oculus\Libraries" /f >nul 2>&1
setx /M PATH "%PATH%;%installpath%Support\oculus-runtime" >nul 2>&1
setx /M OculusBase "%installpath%\" >nul 2>&1
echo.
echo Setting Up Librarian...
cacls "%installpath%Software" /e /p "%username%":f >nul 2>&1
regedit /s Registry\OVRLibraryService.reg >nul 2>&1
echo.
echo Installing Redistributables...
"%cd%\Redistributables\visual-cpp-2013.exe" /install /quiet /norestart
"%cd%\Redistributables\visual-cpp-2013-x86.exe" /install /quiet /norestart
echo.
echo Installing Drivers...
:: Install Drivers
"%installpath%Support\oculus-drivers\oculus-driver.exe"
:: Install OVRService
"%installpath%Support\oculus-runtime\OVRServiceLauncher.exe" -install -start
shutdown /r /t 0
timeout -1 /nobreak >nul 2>&1

:blockcomms
echo Applying Network Settings...
echo.
del /q Redistributables\BlockNet.ini
copy %windir%\System32\drivers\etc\hosts "Network Backup" /y >nul 2>&1
timeout 1 /nobreak >nul 2>&1
echo 127.0.0.1 graph.oculus.com >> "%windir%\System32\drivers\etc\hosts"
timeout 1 /nobreak >nul 2>&1
echo 127.0.0.1 edge-mqtt.facebook.com >> "%windir%\System32\drivers\etc\hosts"
timeout 1 /nobreak >nul 2>&1
echo 127.0.0.1 scontent.oculuscdn.com >> "%windir%\System32\drivers\etc\hosts"
timeout 1 /nobreak >nul 2>&1
echo 127.0.0.1 securecdn.oculus.com >> "%windir%\System32\drivers\etc\hosts"
timeout 1 /nobreak >nul 2>&1
echo 127.0.0.1 graph.facebook.com >> "%windir%\System32\drivers\etc\hosts"
timeout 1 /nobreak >nul 2>&1
goto resumesetup
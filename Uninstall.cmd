@echo off
title Uninstall Oculus

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
:integritywait
timeout 1 /nobreak >nul
if not exist "%temp%\IntegrityVerificationDone.store" goto integritywait
if not exist "%temp%\IntegrityVerification.store" goto integrityfail
cls
echo BypassIntegrity > "%temp%\BypassIntegrityCheck.store"
:BypassIntegrityCheck

:: https://stackoverflow.com/questions/1894967/how-to-request-administrator-access-inside-a-batch-file
:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------  
@echo off
title Uninstall Oculus
Redistributables\NirCmd.exe qboxcom "Uninstall Oculus?~n~nThis will remove the Oculus app from your PC, as well as any software you've downloaded through the Oculus store." "Oculus Setup" inisetval "Redistributables\Uninstall.ini" "section1" "TestValue" "1"
if exist Redistributables\Uninstall.ini goto uninstall
exit

:uninstall
del /q Redistributables\Uninstall.ini
echo Uninstalling Oculus...
Redistributables\NirCmd.exe win max ititle "Uninstall Oculus"
Redistributables\NirCmd.exe win settopmost ititle "Uninstall Oculus" 1
"%oculusbase%OculusSetup.exe" /uninstall /unattended
if exist "Network Backup\hosts" copy "Network Backup\hosts" %windir%\System32\drivers\etc\hosts /y && del /q "Network Backup\hosts" >nul 2>&1 && start "" Redistributables\NirCmd.exe infobox "Communication with Facebook and Oculus servers has been set to default." "Oculus Setup"
exit
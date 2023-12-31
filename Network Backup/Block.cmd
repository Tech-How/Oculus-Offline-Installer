@echo off
title Oculus Setup
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
echo Applying Network Settings...
copy %windir%\System32\drivers\etc\hosts /y >nul 2>&1
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
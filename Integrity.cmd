@echo off
del /q "%temp%\IntegrityVerification.store" >nul 2>&1
del /q "%temp%\IntegrityVerificationDone.store" >nul 2>&1
set integrityverification=2
if not exist "AppData" set integrityverification=1 && echo Missing "AppData"
if not exist "Network Backup" set integrityverification=1 && echo Missing "Network Backup"
if not exist "Network Backup\Block.cmd" set integrityverification=1 && echo Missing "Network Backup\Block.cmd"
if not exist "Network Backup\Restore.cmd" set integrityverification=1 && echo Missing "Network Backup\Restore.cmd"
if not exist "Oculus" set integrityverification=1 && echo Missing "Oculus"
if not exist "Redistributables" set integrityverification=1 && echo Missing "Redistributables"
if not exist "Redistributables\NirCmd.exe" set integrityverification=1 && echo Missing "Redistributables\NirCmd.exe"
if not exist "Redistributables\visual-cpp-2013.exe" set integrityverification=1 && echo Missing "Redistributables\visual-cpp-2013.exe"
if not exist "Redistributables\visual-cpp-2013-x86.exe" set integrityverification=1 && echo Missing "Redistributables\visual-cpp-2013-x86.exe"
if not exist "Registry" set integrityverification=1 && echo Missing "Registry"
if not exist "Registry\Oculus.reg" set integrityverification=1 && echo Missing "Registry\Oculus.reg"
if not exist "Registry\OVRLibraryService.reg" set integrityverification=1 && echo Missing "Registry\OVRLibraryService.reg"
if not exist "Registry\Uninstall.reg" set integrityverification=1 && echo Missing "Registry\Uninstall.reg"
if not exist "Shortcuts" set integrityverification=1 && echo Missing "Shortcuts"
if not exist "Shortcuts\programdataStartMenu" set integrityverification=1 && echo Missing "Shortcuts\programdataStartMenu"
if not exist "Shortcuts\programdataStartMenu\Oculus" set integrityverification=1 && echo Missing "Shortcuts\programdataStartMenu\Oculus"
if not exist "Shortcuts\programdataStartMenu\Oculus\Oculus Support.lnk" set integrityverification=1 && echo Missing "Shortcuts\programdataStartMenu\Oculus\Oculus Support.lnk"
if not exist "Shortcuts\programdataStartMenu\Oculus\Oculus.lnk" set integrityverification=1 && echo Missing "Shortcuts\programdataStartMenu\Oculus\Oculus.lnk"
if not exist "Shortcuts\programdataStartMenu\Oculus\Uninstall Oculus.lnk" set integrityverification=1 && echo Missing "Shortcuts\programdataStartMenu\Oculus\Uninstall Oculus.lnk"
if not exist "Shortcuts\publicDesktop" set integrityverification=1 && echo Missing "Shortcuts\publicDesktop"
if not exist "Shortcuts\publicDesktop\Oculus.lnk" set integrityverification=1 && echo Missing "Shortcuts\publicDesktop\Oculus.lnk"
if not exist Backup.cmd set integrityverification=1 && echo Missing "Backup.cmd"
if not exist Install.cmd set integrityverification=1 && echo Missing "Install.cmd"
if not exist Reset.cmd set integrityverification=1 && echo Missing "Reset.cmd"
if not exist Uninstall.cmd set integrityverification=1 && echo Missing "Uninstall.cmd"
if not exist Integrity.cmd set integrityverification=1 && echo Missing "Integrity.cmd"
echo Done > "%temp%\IntegrityVerificationDone.store"
if %integrityverification% equ 1 echo. && pause && exit
echo IntegrityPassed > "%temp%\IntegrityVerification.store"
exit
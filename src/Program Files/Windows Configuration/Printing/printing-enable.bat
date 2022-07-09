@echo off
setlocal ENABLEDELAYEDEXPANSION

:: CHECK FOR ADMIN PRIVILEGES
dism >nul 2>&1 || ( echo This script must be Run as Administrator. && pause && exit /b 1 )

:: ENABLE PRINTING DEVICES
devcon enable "=Printer" >nul 2>&1
devcon enable "=PrintQueue" >nul 2>&1

:: ENABLE PRINTING SERVICES
sc config Spooler start=auto >nul 2>&1
sc config PrintNotify start=demand >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PrintWorkflowUserSvc" /v "Start" /t REG_DWORD /d "3" /f >nul 2>&1

:: ENABLE PRINTING FEATURES
dism /online /Enable-Feature /FeatureName:Printing-Foundation-Features >nul 2>&1
dism /online /Enable-Feature /FeatureName:Printing-Foundation-InternetPrinting-Client >nul 2>&1

echo Printing has been enabled.
echo Install your printer's driver, then restart your computer.
pause

exit /b 0
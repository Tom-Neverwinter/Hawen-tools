@echo off

REM Get admin privileges
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else (
    goto gotAdmin
)

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"="
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    if exist "%temp%\getadmin.vbs" (
        del "%temp%\getadmin.vbs"
    )
    pushd "%CD%"
    CD /D "%~dp0"

REM Ask for the Hawken main folder for installation
SET /P hawkenInstallPath=Please enter the path to your main Hawken installation folder (e.g., C:\Program Files (x86)\Hawken): 

REM Copy the files to the Hawken installation path
xcopy /s /y PAXPlus\HawkenGame "%hawkenInstallPath%"

echo Files successfully copied to "%hawkenInstallPath%".

REM Graphics presets installation
echo Now we will install the graphic presets.
echo 1 - LowGraphicsPreset
echo 2 - MediumGraphicsPreset
echo 3 - HighGraphicsPreset
echo 4 - UltraGraphicsPreset
SET /P choice=Please enter the number of your choice: 
if %choice%==1 (
    move /y LowGraphicsPreset.ini "%hawkenInstallPath%\HawkenSystemSettings.ini"
) else if %choice%==2 (
    move /y MediumGraphicsPreset.ini "%hawkenInstallPath%\HawkenSystemSettings.ini"
) else if %choice%==3 (
    move /y HighGraphicsPreset.ini "%hawkenInstallPath%\HawkenSystemSettings.ini"
) else if %choice%==4 (
    move /y UltraGraphicsPreset.ini "%hawkenInstallPath%\HawkenSystemSettings.ini"
)
echo Graphics preset installed.

REM Inform about the typical robots.u location
echo The robots.u file and decompress.exe should be in the following directory: hawken\Hawken-PC-Shipping\HawkenGame\CookedPC

REM Ask for the robots.u location and run decompressor
SET /P robotsPath=Please enter the path to your robots.u file: 
cd "%robotsPath%"
copy robots.u robots.u.bak
decompress.exe robots.u
if not exist unpacked (
    echo Error in decompressing robots.u file. The "unpacked" folder was not created. Please check if decompressor.exe and robots.u are in the correct path.
    pause
    exit /b
)
echo Decompression completed 

REM Switch to the unpacked folder for patching
cd unpacked

REM Ask for the patch file location and run deltapatcher
SET /P patchPath=Please enter the path to your patch file: 
deltapatcher.exe robots.u "%patchPath%"
if errorlevel 1 (
    echo Error in patching robots.u file. Please check if deltapatcher.exe and patchfile.xdelta are in the correct path.
    pause
    exit /b
)
echo Patching completed 

REM Copy the patched robots.u back to the original location
move /y robots.u.patched "%robotsPath%\robots.u"

echo Installation process completed. 
pause

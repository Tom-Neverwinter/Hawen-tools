@echo off
cls
:type splash.txt
timeout /t 3 >nul

if exist resolution.txt (
    set /p choice=<resolution.txt
    goto CHOICE
) else (
    goto MENU
)

:MENU
cls
echo ==================================
echo Hawken Resolution Changer
echo ==================================
echo Choose a screen resolution:
echo 1) 1280x720
echo 2) 1366x768
echo 3) 1600x900
echo 4) 1920x1080
echo 5) 2560x1440
echo 6) 3840x2160
echo 7) Exit
echo 8) Change Resolution
echo ==================================
set /p choice=Enter your choice (1-8):

:CHOICE
if "%choice%" == "1" set resx=1280&set resy=720&goto RUN
if "%choice%" == "2" set resx=1366&set resy=768&goto RUN
if "%choice%" == "3" set resx=1600&set resy=900&goto RUN
if "%choice%" == "4" set resx=1920&set resy=1080&goto RUN
if "%choice%" == "5" set resx=2560&set resy=1440&goto RUN
if "%choice%" == "6" set resx=3840&set resy=2160&goto RUN
if "%choice%" == "7" goto EXIT
if "%choice%" == "8" del resolution.txt&goto MENU
echo Invalid choice. Try again.
goto MENU

:RUN
echo %choice% > resolution.txt
echo Launching Hawken with %resx%x%resy% resolution...
start "" "%~dp0HawkenGame-Win32-Shipping.exe" -FULLSCREEN -resx=%resx% -resy=%resy%
goto EXIT

:EXIT
exit

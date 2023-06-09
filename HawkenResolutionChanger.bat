@echo off
cls
:type splash.txt
:timeout /t 3 >nul
goto MENU

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
echo ==================================
set /p choice=Enter your choice (1-7):
if "%choice%" == "1" set resx=1280&set resy=720&goto MENU_DX
if "%choice%" == "2" set resx=1366&set resy=768&goto MENU_DX
if "%choice%" == "3" set resx=1600&set resy=900&goto MENU_DX
if "%choice%" == "4" set resx=1920&set resy=1080&goto MENU_DX
if "%choice%" == "5" set resx=2560&set resy=1440&goto MENU_DX
if "%choice%" == "6" set resx=3840&set resy=2160&goto MENU_DX
if "%choice%" == "7" goto EXIT
goto MENU

:MENU_DX
cls
echo ==================================
echo Choose DirectX version:
echo 1) DirectX 9
echo 2) DirectX 11
echo ==================================
set /p choice=Enter your choice (1-2):
if "%choice%" == "1" set dxversion=-dx9&goto RUN
if "%choice%" == "2" set dxversion=-dx11&goto RUN
goto MENU_DX

:RUN
echo Launching Hawken with %resx%x%resy% resolution and %dxversion%...
start "" "%~dp0HawkenGame-Win32-Shipping.exe" -FULLSCREEN -resx=%resx% -resy=%resy% %dxversion%
goto EXIT

:EXIT
exit

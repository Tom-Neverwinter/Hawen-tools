@echo off
setlocal enabledelayedexpansion

REM Ask the user for their settings
set /p MotionBlur="Should MotionBlur be enabled? (True/False): "
set /p Bloom="Should Bloom be enabled? (True/False): "

set "textfile=D:\Hawken\pax-client\pax-client\hawken\Hawken-PC-Shipping\Engine\Config\BaseSystemSettings.ini"
set "newfile=D:\Hawken\pax-client\pax-client\hawken\Hawken-PC-Shipping\Engine\Config\BaseSystemSettings.tmp"

REM Replace the MotionBlur line
set "search=MotionBlur=True"
set "replace=MotionBlur=%MotionBlur%"
(for /f "delims=" %%i in (%textfile%) do (
    set "line=%%i"
    setlocal enabledelayedexpansion
    echo(!line:%search%=%replace%!>>"%newfile%"
    endlocal
)) 

move /Y "%newfile%" "%textfile%"

REM Replace the Bloom line
set "search=Bloom=True"
set "replace=Bloom=%Bloom%"
(for /f "delims=" %%i in (%textfile%) do (
    set "line=%%i"
    setlocal enabledelayedexpansion
    echo(!line:%search%=%replace%!>>"%newfile%"
    endlocal
)) 

move /Y "%newfile%" "%textfile%"

echo Changes made successfully.
endlocal

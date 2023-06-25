@echo off
set /p src_dir="Please enter the source directory: "
set /p dst_dir="Please enter the destination directory: "

REM If backup already exists, delete it
if exist "%src_dir%\robots.u.bak" del /F "%src_dir%\robots.u.bak"

REM Backup robots.u to robots.u.bak
copy "%src_dir%\robots.u" "%src_dir%\robots.u.bak"

REM Move all files from source to destination directory
move /Y "%src_dir%\*.*" "%dst_dir%\"

echo Files moved successfully.

REM Creating the VBScript to make a shortcut
echo Set oWS = WScript.CreateObject("WScript.Shell") > CreateShortcut.vbs
echo sLinkFile = "%USERPROFILE%\Desktop\Hawken Resolution Changer.lnk" >> CreateShortcut.vbs
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> CreateShortcut.vbs
echo oLink.TargetPath = "%~dp0\HawkenResolutionChanger.bat" >> CreateShortcut.vbs
echo oLink.Save >> CreateShortcut.vbs

REM Running the VBScript
cscript CreateShortcut.vbs
del CreateShortcut.vbs

pause

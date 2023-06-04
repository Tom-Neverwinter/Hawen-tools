@echo off
setlocal enabledelayedexpansion

:menu
cls
echo.
echo Select a map:
echo 1. Alleys_DM
echo 2. Andromeda_DM
echo 3. Andromeda_Siege
echo 4. Sahara_DM_E3
set /p mapChoice=Enter the map number: 

if "%mapChoice%"=="1" set map=Alleys_DM
if "%mapChoice%"=="2" set map=Andromeda_DM
if "%mapChoice%"=="3" set map=Andromeda_Siege
if "%mapChoice%"=="4" set map=Sahara_DM_E3

echo.
set /p numPlayers=Enter the number of players (1-32): 

echo.
set /p goalScore=Enter the goal score: 

echo.
set /p timeLimit=Enter the time limit (in minutes): 

echo.
echo Select a game mode:
echo 1. Team Deathmatch
echo 2. Deathmatch
set /p gameMode=Enter the game mode number: 

if "%gameMode%"=="1" set game=Robots.R_TeamDeathmatch
if "%gameMode%"=="2" set game=Robots.R_Deathmatch

:start_server
echo Starting Hawken server with the selected options...
start HawkenGame-Win32-Shipping.exe Server %map%?NumPublicConnections=%numPlayers%?GoalScore=%goalScore%?TimeLimit=%timeLimit%?bIsLanMatch=True?game=%game% -log
echo Server started.
pause


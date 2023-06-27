@echo off
setlocal enabledelayedexpansion

:menu
cls
echo.
echo Select a map:
echo 1. Alleys_DM
echo 2. Andromeda_DM
echo 3. Andromeda_Siege [Only supports Siege mode]
echo 4. Sahara_DM_E3
set /p mapChoice=Enter the map number: 

if "%mapChoice%"=="1" set map=Alleys_DM
if "%mapChoice%"=="2" set map=Andromeda_DM
if "%mapChoice%"=="3" set map=Andromeda_Siege
if "%mapChoice%"=="4" set map=Sahara_DM_E3

:players
echo.
echo Enter the number of players:
echo (Expected range is 1-32)
set /p numPlayers=

:: Validate number of players
if %numPlayers% lss 1 (
  echo Invalid input. Number of players should be between 1 and 32. Please try again.
  goto players
)
if %numPlayers% gtr 32 (
  echo Invalid input. Number of players should be between 1 and 32. Please try again.
  goto players
)

:goal_score
echo.
echo Enter the goal score:
echo (For a full server of 5v5, a score of around 40000 is fairly standard. Expected range is 1000-80000.)
set /p goalScore=

:: Validate goal score
if %goalScore% lss 1000 (
  echo Invalid input. Goal score should be between 1000 and 80000. Please try again.
  goto goal_score
)
if %goalScore% gtr 80000 (
  echo Invalid input. Goal score should be between 1000 and 80000. Please try again.
  goto goal_score
)

:time_limit
echo.
echo Enter the time limit (in minutes):
echo (Expected range is 5-120)
set /p timeLimit=

:: Validate time limit
if %timeLimit% lss 5 (
  echo Invalid input. Time limit should be between 5 and 120 minutes. Please try again.
  goto time_limit
)
if %timeLimit% gtr 120 (
  echo Invalid input. Time limit should be between 5 and 120 minutes. Please try again.
  goto time_limit
)

:game_mode
echo.
echo Select a game mode:
if "%map%"=="Andromeda_Siege" (
    echo 1. Siege
    set /p gameMode=Enter the game mode number: 
    if "%gameMode%"=="1" set game=Robots.R_Siege
) else (
    echo 1. Team Deathmatch
    echo 2. Deathmatch
    set /p gameMode=Enter the game mode number: 
    if "%gameMode%"=="1" set game=Robots.R_TeamDeathmatch
    if "%gameMode%"=="2" set game=Robots.R_Deathmatch
)

echo.
set /p serverName=Enter the server name: 

:start_server
echo Starting Hawken server with the selected options...
start HawkenGame-Win32-Shipping.exe Server %map%?NumPublicConnections=%numPlayers%?GoalScore=%goalScore%?TimeLimit=%timeLimit%?bIsLanMatch=True?game=%game%?ServerName=%serverName% -log
echo Server started.
pause

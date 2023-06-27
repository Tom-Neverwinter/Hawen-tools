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
set /p numPlayers=Enter the number of players (1-32): 

:: Validate number of players
if %numPlayers% lss 1 (
  echo Number of players should be between 1 and 32. Please try again.
  goto players
)
if %numPlayers% gtr 32 (
  echo Number of players should be between 1 and 32. Please try again.
  goto players
)

:goal_score
echo.
set /p goalScore=Enter the goal score (1000-80000): 

:: Validate goal score
if %goalScore% lss 1000 (
  echo Goal score should be between 1000 and 80000. Please try again.
  goto goal_score
)
if %goalScore% gtr 80000 (
  echo Goal score should be between 1000 and 80000. Please try again.
  goto goal_score
)

:time_limit
echo.
set /p timeLimit=Enter the time limit (in minutes, 5-120): 

:: Validate time limit
if %timeLimit% lss 5 (
  echo Time limit should be between 5 and 120 minutes. Please try again.
  goto time_limit
)
if %timeLimit% gtr 120 (
  echo Time limit should be between 5 and 120 minutes. Please try again.
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

@echo off
set SERVER_EXE="%~dp0BattleRogueServer.exe"
set PORT=8888
set MAXPLAYERS=2
set LOGFILE="%~dp0ServerLog.txt"

echo [Start Dedicated Server] ArenaMap 로딩…
start "" %SERVER_EXE% ^
    ArenaMap?MaxPlayers=%MAXPLAYERS%?Port=%PORT% ^
    -log > %LOGFILE% 2>&1

exit

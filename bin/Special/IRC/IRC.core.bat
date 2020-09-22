@ECHO off
REM Variables naming rule: <irc#varname>
SETLOCAL EnableExtensions EnableDelayedExpansion
CHCP 65001 > nul 2>nul

SET irc#title=sIRC Client
SET irc#path_local=%_local%\irc
SET irc#cols=100
SET irc#lines=30
SET irc#cur_channel=#main
SET irc#ln=^


REM 2 empty lines above
ECHO * * * Connecting to local freenode IRC server * * *
FOR /L %%l IN (1,1,2) DO (
	TITLE %irc#title% ^| Status: connecting
	CALL bin\Special\Functions delay,r,200
	TITLE %irc#title% ^| Status: connecting.
	CALL bin\Special\Functions delay,r,200
	TITLE %irc#title% ^| Status: connecting..
	CALL bin\Special\Functions delay,r,200
	TITLE %irc#title% ^| Status: connecting...
	CALL bin\Special\Functions delay,r,200
)
ECHO.
ECHO | SET /p ".=Connected to "
CALL bin\IO\Print colored,black,lpurple,"Local freenode IRC server",1
ECHO.
TITLE %irc#title% ^| Status: Connected to local freenode. Initializing...
FOR /L %%l IN (1,1,2) DO (
	TITLE %irc#title% ^| Status: Connected to local freenode. Initializing
	CALL bin\Special\Functions delay,r,200
	TITLE %irc#title% ^| Status: Connected to local freenode. Initializing.
	CALL bin\Special\Functions delay,r,200
	TITLE %irc#title% ^| Status: Connected to local freenode. Initializing..
	CALL bin\Special\Functions delay,r,200
	TITLE %irc#title% ^| Status: Connected to local freenode. Initializing...
	CALL bin\Special\Functions delay,r,200
)
ECHO * * * Logging in * * *
FOR /L %%l IN (1,1,2) DO (
	TITLE %irc#title% ^| Status: Connected to local freenode. Retrieving data
	CALL bin\Special\Functions delay,r,200
	TITLE %irc#title% ^| Status: Connected to local freenode. Retrieving data.
	CALL bin\Special\Functions delay,r,200
	TITLE %irc#title% ^| Status: Connected to local freenode. Retrieving data..
	CALL bin\Special\Functions delay,r,200
	TITLE %irc#title% ^| Status: Connected to local freenode. Retrieving data...
	CALL bin\Special\Functions delay,r,200
)
TITLE %irc#title% ^| freenode ^| #main

:welcome
MODE CON cols=%irc#cols% lines=%irc#lines%

ECHO | SET /p ".=Welcome to %irc#title%! | Local freenode IRC server | "
CALL bin\IO\Print colored,black,lyellow,%irc#cur_channel%,1
ECHO.
ECHO | SET /p ".=Type "
CALL bin\IO\Print colored,white,blue,#roomname,0
ECHO  to open one of the following rooms:
SET irc#n=0
FOR /D %%d IN (bin\Game\*) DO (
	SET /a irc#n+=1
	ECHO !irc#n!^) #%%~nxd
)
ECHO.
ECHO | SET /p ".=Type "
CALL bin\IO\Print colored,black,lpurple,exit,0
ECHO  to terminate %irc#title%.
SET /a irc#n=%irc#lines%+%irc#n%-23

FOR /L %%l IN (%irc#n%,1,%irc#lines%) DO ECHO.

SET /p "irc#input=> "
IF [%irc#input%] EQU [exit] (exit)
CLS
IF EXIST "bin\Game\%irc#input:~1%\%irc#input:~1%#main.bat" (
	TITLE %irc#title% ^| freenode ^| %irc#input%
	SET #channel=%irc#input:~1%
	SET #path_save=%_local%\!#channel!
	SET #path_core=bin\Game\!#channel!
	MD !#path_save! > nul 2>nul
	CALL "bin\Game\!#channel!\!#channel!#main.bat"
)

GOTO :welcome
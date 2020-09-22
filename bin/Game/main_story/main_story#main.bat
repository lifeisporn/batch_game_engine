REM Variables naming rule: <#varname>
SETLOCAL EnableExtensions EnableDelayedExpansion
CHCP 65001>nul

:start
CLS
CALL bin\Game\GF message,r,"mr.FR@nK","Hey. Are you that newbie?"
CALL bin\Game\GF choice,#ans,"Yes, it's me. What should I do?","Who are you?"

IF [%#ans%] EQU [1] (
	CALL bin\Game\GF message,r,"mr.FR@nK","To start, let us tell you about ourself."
)

:about_us
CALL bin\Game\GF message,r,"mr.FR@nK","We are freedom fighters."
CALL bin\Game\GF message,r,"mr.FR@nK","blah blah blah."
CALL bin\Game\GF message,r,"mr.FR@nK","and so blah blah blah."

CALL bin\Game\GF choice,#ans,"OK","What?"

IF [%#ans%] EQU [2] GOTO :about_us

CALL bin\Game\GF message,r,"mr.FR@nK","Let's start."

pause
goto :start
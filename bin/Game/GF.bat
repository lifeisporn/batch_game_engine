REM Variables naming rule: <gf#varname>

SETLOCAL EnableExtensions EnableDelayedExpansion
SET "gf#_RESULT="
GOTO %1

::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ================================================== ::
:: ================= Functions list ================= ::
:: ================================================== ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ┌----------------┬---------------┬---------------┬---------------┬---------------┐
:: |     [name]     |      [%3]     |      [%4]     |      [%5]     |      [%6]    	|
:: ├----------------┼---------------┼---------------┼---------------┼---------------┤
:: | choice			| "answer1"		| "answer2"		| "answer3"		| "answer4"		|
:: ├----------------┼---------------┼---------------┼---------------┼---------------┤
:: | message		| "message"		| 				|				|				|
:: └----------------┴---------------┴---------------┴---------------┴---------------┘
::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ================================================== ::
:: ===================== choice ===================== ::
:: ================================================== ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:choice => public function("message"[%3])
SET gf#param1=%3
SET gf#param2=%4
SET gf#param3=%5
SET gf#param4=%6

SET "gf#answer_list_nums="
SET "gf#answer_list_str="
FOR /L %%n IN (1,1,4) DO (
	IF DEFINED gf#param%%n (
		SET "gf#answer_list_nums=!gf#answer_list_nums!%%n"
		SET "gf#answer_list_str=!gf#answer_list_str!  [%%n] !gf#param%%n:~1,-1!"
	)
)
REM 2 leading spaces
SET "gf#answer_list_str=%gf#answer_list_str:~2%
CALL bin\Special\Functions length,gf#answer_list_str_length,"%gf#answer_list_str%"

IF %gf#answer_list_str_length% GTR %irc#cols% (
	SET /a gf#newcols=%gf#answer_list_str_length%+5
	rem MODE CON cols=!gf#newcols! lines=%irc#lines%
) ELSE (
	SET gf#newcols=%irc#cols%
)

FOR /F %%a IN ('ECHO prompt $H ^| cmd') DO SET "gf#backspace=%%a"
SET "gf#trash_string="
FOR /F "delims=" %%a IN ('ECHO.^|xcopy /w "%~f0" "%~f0" 2^>nul') DO IF NOT DEFINED gf#trash_string SET "gf#trash_string=%%a"

<nul set /p=%gf#answer_list_str%

:choice_loop
SET "gf#char="
FOR /F "delims=" %%a IN ('xcopy /w "%~f0" "%~f0" 2^>nul') DO IF NOT DEFINED gf#char SET "gf#char=%%a"
SET gf#char=!gf#char:%gf#trash_string%=!

IF NOT DEFINED gf#param%gf#char% GOTO :choice_loop

SET "s="
FOR /L %%n IN (1,1,%gf#newcols%) DO SET s=!s!%gf#backspace% %gf#backspace%
<nul SET /p=%s%

REM Already with quotes
CALL bin\Game\GF message,r,"",!gf#param%gf#char%!

SET gf#_RESULT=%gf#char%

rem MODE CON cols=%irc#cols% lines=%irc#lines%
GOTO :return

::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ================================================== ::
:: ===================== message ==================== ::
:: ================================================== ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:message => public function("message"[%3])
<nul SET /p=[%time:~0,-3%]
IF [%3] EQU [""] (
	CALL bin\IO\Print colored,black,aqua," you"
) ELSE (
	CALL bin\Special\Functions delay,r,1000
	CALL bin\IO\Print colored,black,lred," %~3"
)
rem ECHO : %~4
CALL bin\IO\Print typing,": %~4",1

GOTO :return

::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:return
ENDLOCAL & SET %~2=%gf#_RESULT%
GOTO :eof
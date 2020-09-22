REM Variables naming rule: <ip#varname>
SETLOCAL EnableExtensions EnableDelayedExpansion
CHCP 65001>nul
SET "ip#_RESULT="
GOTO %1

::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ================================================== ::
:: ================= Functions list ================= ::
:: ================================================== ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ┌----------------┬-----------------------┐
:: |     [name]     |          [%2]         |
:: ├----------------┼-----------------------┼
:: | prompt_line	| 						|
:: ├----------------┼-----------------------┼
:: | password		| "char_filler" = ""	|
:: └----------------┴-----------------------┘
::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ================================================== ::
:: =================== prompt_line ================== ::
:: ================================================== ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:prompt_line => public function()
ECHO | SET /p ".=[%_CUR_USER%@%_CUR_ADDR%:"
CALL bin\IO\Print colored,black,aqua,"%_CUR_PATH%"
ECHO | SET /p ".=] $  "
GOTO :eof

::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ================================================== ::
:: ==================== password ==================== ::
:: ================================================== ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:password => public function("char_filler"[%3] = "")
SET ip#pass_length=0

REM We remember the invitation line to press the key (to then delete it and leave only the pressed key)
SET "ip#trash_string="
FOR /F "delims=" %%a IN ('ECHO.^|xcopy /w "%~f0" "%~f0" 2^>nul') DO IF NOT DEFINED ip#trash_string SET "ip#trash_string=%%a"
REM Special characters
FOR /F %%a IN ('COPY /z "%~f0" nul') DO SET "ip#_char[enter]=%%a"
FOR /F %%a IN ('ECHO prompt $H ^| CMD') DO SET "ip#_char[backspace]=%%a"

REM Ask user to enter a password
SET /p ".=Password: " < nul

:password_loop
SET "ip#char="
FOR /F "delims=" %%a IN ('xcopy /w "%~f0" "%~f0" 2^>nul') DO IF NOT DEFINED ip#char SET "ip#char=%%a"
SET ip#char=!ip#char:%ip#trash_string%=!

REM Exclamation mark is not saved
:: If add, the result will be empty
::IF NOT DEFINED char (
::	SETLOCAL DisableDelayedExpansion
::	FOR /F "delims=" %%c IN ('ECHO ^!') DO SET "char=%%c"
::	SETLOCAL EnableDelayedExpansion
::)

REM Finish input when ENTER is pressed
IF [!ip#char!] EQU [!ip#_char[enter]!] (
	IF !ip#pass_length! GTR 0 (
		ECHO.
		GOTO :return
	)
	GOTO :password_loop
)

REM Process BACKSPACE
IF [!ip#char!] EQU [!ip#_char[backspace]!] (
	IF !ip#pass_length! GTR 0 (
		SET "ip#_RESULT=!ip#_RESULT:~0,-1!"
		SET /a ip#pass_length-=1
	)
) ELSE (
	REM Add new char to password string
	IF [%~3] NEQ [] ECHO | SET /p ".=%~3"
	SET "ip#_RESULT=!ip#_RESULT!!ip#char!"
	SET /a ip#pass_length+=1
)

GOTO :password_loop

::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:return
ENDLOCAL & SET %~2=%ip#_RESULT%
GOTO :eof
@ECHO off
REM Variables naming rule: <sg#varname>
SETLOCAL EnableExtensions EnableDelayedExpansion
CHCP 65001>nul
TITLE Serenity Batch Engine

REM Initial setting
SET "_tmp=%cd%\tmp"
RD "%_tmp%" /s /q > nul 2>nul

CALL bin\Sugar\TurnOn

:login_input
CLS
SET /p "login=login: "
IF [%login%] EQU [] GOTO :login_input

REM Environment variables
SET "_CUR_PATH=~"
SET "_CUR_ADDR=localhost"
SET "_CUR_USER=%login%"

REM Constants
SET "_root=%cd%\usr\%_CUR_USER%\~"
SET "_logs=%_root%\logs"
SET "_etc=%_root%\etc"
SET "_local=%_root%\local"
SET "_cache=%_root%\cache"

REM User's sandbox filesystem
MD "%_logs%" > nul 2>nul
MD "%_etc%" > nul 2>nul
MD "%_local%" > nul 2>nul
MD "%_cache%" > nul 2>nul

:password_input
CALL bin\Special\Functions getPass,sg#w
IF [%sg#w%] EQU [] (
	CHOICE /n /m "User `%login%` is not registered yet. Do you want to create a new profile (y/n)?:"
	ECHO.
	IF [!errorlevel!] EQU [2] (
		RD "%_root:~0,-2%" /s /q
		GOTO :login_input
	)
	CALL bin\Special\Functions newPass,sg#res,1
	IF [!sg#res!] NEQ [ok] GOTO :login_input
) ELSE (
	CALL bin\IO\Input password,sg#pass
	IF [!sg#pass!] NEQ [%sg#w%] (
		ECHO Login credentials are incorrect^^!
		ECHO.
		GOTO :login_input
	)
)

:login_success
CLS
CALL bin\Sugar\Welcome

:user_input
CALL bin\IO\Input prompt_line

SET /p "sg#input="
REM <sg#cmd_result> must be reset, otherwise the script will return the old result
SET "sg#cmd_result="
CALL bin\IO\CommandsHandler sg#cmd_result,"%sg#input%"
IF [%sg#cmd_result%] EQU [] (
	ECHO Command not found.
) ELSE (
	IF [%sg#cmd_result%] EQU [logout] (
		ECHO.
		GOTO :login_input
	) ELSE (
		IF [%sg#cmd_result%] EQU [err] (
			ECHO The specified params are invalid
		)
	)
)

GOTO :user_input
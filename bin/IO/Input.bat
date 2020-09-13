::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: %1 - имя функции                                   ::
:: %~2 - переменная возврата                          ::
:: %3,%4,... - параметры функции                      ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::
REM Префикс для переменных: ip#имя_переменной
::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ================================================== ::
:: ==================== Параметры =================== ::
:: ================================================== ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::

SETLOCAL EnableExtensions EnableDelayedExpansion
CHCP 65001>nul
SET "ip#_RESULT="
GOTO %1

::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ================================================== ::
:: ===================== Функции ==================== ::
:: ================================================== ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:: prompt_line(username,address,path)
:: password(char_filler)

::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ================================================== ::
:: === function prompt_line(username,address,path) == ::
:: ================================================== ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:prompt_line
SET ip#c_username=%2
SET ip#c_address=%3
SET ip#c_path=%~4

ECHO | SET /p ".=[%ip#c_username%@%ip#c_address%:"
CALL bin\IO\Print colored,black,aqua,"%ip#c_path%"
ECHO | SET /p ".=] $  "
GOTO :eof

::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ================================================== ::
:: ========= function password(char_filler) ========= ::
:: ================================================== ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:password
SET ip#pass_length=0

REM Запоминаем приглашение нажать клавишу (чтобы потом удалять его и оставлять только нажатую клавишу)
SET "ip#trash_string="
REM В команде xcopy дважды повторяем полное имя файла, иначе копия этого батника создастся в корне
FOR /F "delims=" %%a IN ('ECHO.^|xcopy /w "%~f0" "%~f0" 2^>nul') DO IF NOT DEFINED ip#trash_string SET "ip#trash_string=%%a"
REM Запоминаем спецсимволы
FOR /F %%a IN ('COPY /z "%~f0" nul') DO SET "ip#_char[enter]=%%a"
FOR /F %%a IN ('ECHO prompt $H ^| CMD') DO SET "ip#_char[backspace]=%%a"

REM Просим ввести пароль
SET /p ".=Password: " < nul

:password_loop
REM Запоминаем нажатую клавишу и удаляем мусор (%trash_string%) (условие из-за цикла, ибо он выполняется трижды)
SET "ip#char="
FOR /F "delims=" %%a IN ('xcopy /w "%~f0" "%~f0" 2^>nul') DO IF NOT DEFINED ip#char SET "ip#char=%%a"
SET ip#char=!ip#char:%ip#trash_string%=!

REM Восклицательный знак не сохраняется
:: Если добавлять, то на выходе в вызывающем скрипте весь результат будет пустым
::IF NOT DEFINED char (
::	SETLOCAL DisableDelayedExpansion
::	FOR /F "delims=" %%c IN ('ECHO ^!') DO SET "char=%%c"
::	SETLOCAL EnableDelayedExpansion
::)

REM Завершаем ввод, если нажат ENTER (или игнорируем)
IF [!ip#char!] EQU [!ip#_char[enter]!] (
	IF !ip#pass_length! GTR 0 (
		ECHO.
		GOTO :return
	)
	GOTO :password_loop
)

REM Удаляем последний символ из сохранённого пароля, если нажат BACKSPACE
IF [!ip#char!] EQU [!ip#_char[backspace]!] (
	IF !ip#pass_length! GTR 0 (
		SET "ip#_RESULT=!ip#_RESULT:~0,-1!"
		SET /a ip#pass_length-=1
	)
) ELSE (
	REM Добавляем символ к сохранённому паролю
	IF [%~3] NEQ [] ECHO | SET /p ".=%~3"
	SET "ip#_RESULT=!ip#_RESULT!!ip#char!"
	SET /a ip#pass_length+=1
)

GOTO :password_loop

::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:return
ENDLOCAL & SET %~2=%ip#_RESULT%
GOTO :eof
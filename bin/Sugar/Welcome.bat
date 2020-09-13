REM Префикс для переменных: wc#имя_переменной

SET "wc#current_login=%date% %time:~0,-3% on %COMPUTERNAME%/%_CUR_ADDR%"

MD "%_logs%" > nul 2>nul
IF EXIST "%_logs%\last_login.dat" (
	SET /p wc#last_login=<"%_logs%\last_login.dat"
	ECHO Last login: !wc#last_login!
) ELSE (
	ECHO Last login: %wc#current_login%
)

ECHO %wc#current_login%>"%_logs%\last_login.dat"
ECHO Welcome to Serenity Batch Engine (BATCH/Console cmd.exe x86_x64)
ECHO.
ECHO    * Documentation:    https://engine.lifeis.porn/
ECHO    * Owner:            Life Is Porn
ECHO    * Support:          support@lifeis.porn
ECHO.
CALL bin\Special\Functions getUpdates,count_updates
CALL bin\Special\Functions getFixes,count_fixes
IF [%count_updates%] EQU [0] (SET color1=gray) ELSE (SET color1=lyellow)
IF [%count_fixes%] EQU [0] (SET color2=gray) ELSE (SET color2=lyellow)
CALL bin\IO\Print colored,black,%color1%,"%count_updates% updates required.",1
CALL bin\IO\Print colored,black,%color2%,"%count_fixes% critical fixes available.",1
ECHO.
ECHO.
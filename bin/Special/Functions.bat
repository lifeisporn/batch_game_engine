::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: %1 - имя функции                                   ::
:: %~2 - переменная возврата                          ::
:: %3,%4,... - параметры функции                      ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::
REM Префикс для переменных: fs#имя_переменной
::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ================================================== ::
:: ==================== Параметры =================== ::
:: ================================================== ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::

SETLOCAL EnableExtensions EnableDelayedExpansion
SET fs#_hex_set_lower=0123456789abcdef
SET fs#_hex_set=0123456789ABCDEF
SET fs#_hex_len=16
SET "fs#_RESULT="
GOTO %1

::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ================================================== ::
:: ===================== Функции ==================== ::
:: ================================================== ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:: newPass([new_user=0])
:: setPass(newpass)
:: getPass()
:: getUpdates()
:: getFixes()
:: multiplyString(string,multiplier)
:: randomItem(list)
:: length(string)
:: countItems(list)
:: randomURI()
:: delay(milliseconds)
:: random(min,max[,offset])
:: hex_rand(length[,lowercase=0])
:: dec2hex(decimal[,lowercase=0])

::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ================================================== ::
:: ========= function newPass([new_user=0]) ========= ::
:: ================================================== ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:newPass
IF [%3] EQU [1] GOTO :newPass_new
ECHO | SET /p ".=(Current) "
CALL bin\IO\Input password,fs#pass0
CALL bin\Special\Functions getPass,fs#w
IF [%fs#pass0%] NEQ [%fs#w%] (
	ECHO Wrong password. Action cancelled.
	GOTO :return
)

:newPass_new
ECHO | SET /p ".=(New) "
CALL bin\IO\Input password,fs#pass1
ECHO | SET /p ".=(Re-type) "
CALL bin\IO\Input password,fs#pass2
IF [%fs#pass1%] NEQ [%fs#pass2%] (
	ECHO Password mismatch. Action cancelled.
	ECHO.
	GOTO :return
)

CALL bin\Special\Functions setPass,fs#res,"%fs#pass1%"
IF [%fs#res%] EQU [err] (
	ECHO You cannot use this password! Please, use more simple.
	ECHO.
	GOTO :newPass
)

SET fs#_RESULT=ok
GOTO :return

::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ================================================== ::
:: ============ function setPass(newpass) =========== ::
:: ================================================== ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:setPass
SET "fs#newpass=%~3"
IF [%fs#newpass:"=%] EQU [] (
	SET fs#_RESULT=err
) ELSE (
	(ECHO %fs#newpass:"=%) >"%_etc%\passwd"
	SET fs#_RESULT=ok
)
GOTO :return

::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ================================================== ::
:: =============== function getPass() =============== ::
:: ================================================== ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:getPass
IF EXIST "%_etc%\passwd" SET /p fs#_RESULT=<"%_etc%\passwd"
GOTO :return

::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ================================================== ::
:: ============== function getUpdates() ============= ::
:: ================================================== ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:getUpdates
SET fs#_RESULT=0
GOTO :return

::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ================================================== ::
:: =============== function getFixes() ============== ::
:: ================================================== ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:getFixes
SET fs#_RESULT=0
GOTO :return

::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ================================================== ::
:: ==== function multiplyString(string,multiplier) == ::
:: ================================================== ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:multiplyString
SET fs#string=%~3
SET fs#count=%4
FOR /L %%i IN (1,1,%fs#count%) DO CALL :multiplyString_add
GOTO :return

:multiplyString_add
SET fs#_RESULT=%fs#_RESULT%%fs#string%
GOTO :eof

::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ================================================== ::
:: ============ function randomItem(list) =========== ::
:: ================================================== ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:randomItem
CALL bin\Special\Functions countItems,fs#count,%3
CALL bin\Special\Functions random,fs#rand_index,1,%fs#count%
SET fs#n=0
FOR %%i IN (%~3) DO (
	SET /a fs#n+=1
	IF [%fs#rand_index%] EQU [!fs#n!] SET fs#_RESULT=%%i
)

GOTO :return

::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ================================================== ::
:: ============= function length(string) ============ ::
:: ================================================== ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:length
SET fs#string=%~3

:length_loop
IF [!fs#string:~%fs#_RESULT%!] NEQ [] (
	SET /a fs#_RESULT+=1
	GOTO :length_loop
)

GOTO :return

::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ================================================== ::
:: ============ function countItems(list) =========== ::
:: ================================================== ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:countItems
FOR %%i IN (%~3) DO SET /a fs#_RESULT+=1
GOTO :return

::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ================================================== ::
:: ============== function randomURI() ============== ::
:: ================================================== ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:randomURI
SET fs#protocols_list=https http ftp sftp ssh dhcp irc cops xmpp socks telnet tftp ftps ssl tls sip
REM Нумерация в обратном порядке из-за цикла
SET fs#domains1_list=www www1 www2
SET fs#domains2_list=ns1 ns2 s1 s2 r1 r2 one two
SET fs#domains3_list=gain nails pack api naive native laboratory service web dns
SET fs#domains4_list=safeblock-company security-corporation s-corp guarantor-company scorp-safe safety-me llc-seckeys
SET fs#domains5_list=com ru net org xyz de ua

CALL bin\Special\Functions randomItem,fs#protocol,"%fs#protocols_list%"
SET "fs#_RESULT=%fs#protocol%://"

REM Записываем выбранные значения в строку
SET fs#n=0
FOR /F "tokens=2 delims==" %%d IN ('SET fs#domains') DO (
	SET /a fs#n+=1
	CALL bin\Special\Functions randomItem,fs#res,"%%d"
	IF !fs#n! GTR 1 SET fs#_RESULT=!fs#_RESULT!^.
	SET fs#_RESULT=!fs#_RESULT!!fs#res!
)

GOTO :return

::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ================================================== ::
:: ========== function delay(milliseconds) ========== ::
:: ================================================== ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:delay
REM Минимум - 50мс, дальше скрипт не успевает; погрешность ~10мс
SET fs#call_delay_fix=5
CALL :delay_get_ms "%time%",fs#time_start_ms

:delay_loop
CALL :delay_get_ms "%time%",fs#time_current_ms
SET /a fs#time_diff=%fs#time_current_ms%-%fs#time_start_ms%+%fs#call_delay_fix%
IF %fs#time_diff% GTR %3 GOTO :return
IF %fs#time_diff% LSS 0 GOTO :return
GOTO :delay_loop

:delay_get_ms
FOR /f "tokens=3,4 delims=:," %%a IN ("%~1") DO (
	SET /a "fs#_RESULT=%%a*1000+%%b*10" 2>nul || SET /p ".=" <nul & SET /p ".=" <nul
)
GOTO :return

::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ================================================== ::
:: ======== function random(min,max[,offset]) ======= ::
:: ================================================== ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:random
IF [%5] EQU [] (
	SET fs#offset=0
) ELSE (
	SET fs#offset=%5
)
SET /a fs#_RESULT=%random%%%(%4-%3+1)+%3+%fs#offset%
GOTO :return

::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ================================================== ::
:: ===== function hex_rand(length[,lowercase=0]) ==== ::
:: ================================================== ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:hex_rand
IF [%4] EQU [1] SET fs#_hex_set=%fs#_hex_set_lower%
FOR /L %%i IN (1,1,%3) DO CALL :hex_rand_add
GOTO :return

:hex_rand_add
CALL bin\Special\Functions random,fs#rand,1,%fs#_hex_len%,-1
SET fs#_RESULT=%fs#_RESULT%!fs#_hex_set:~%fs#rand%,1!
GOTO :eof

::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ================================================== ::
:: ===== function dec2hex(decimal[,lowercase=0]) ==== ::
:: ================================================== ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:dec2hex
IF [%4] EQU [1] SET fs#_hex_set=%fs#_hex_set_lower%
SET "fs#hexstr="
SET "fs#prefix="

IF [%3] EQU [] (
	SET fs#_RESULT=0
	GOTO :eof
)

SET /a fs#A=%3 || EXIT /b 1
IF %fs#A% LSS 0 (
	SET /a fs#A=0xFFFFFFF+%fs#A%+1
	SET fs#prefix=F
)

:dec2hex_loop
SET /a fs#B=%fs#A% %% %fs#_hex_len% & SET /a fs#A=%fs#A%/%fs#_hex_len%
SET fs#hexstr=!fs#_hex_set:~%fs#B%,1!%fs#hexstr%
IF %fs#A% GTR 0 GOTO :dec2hex_loop
SET fs#_RESULT=%fs#prefix%%fs#hexstr%
GOTO :return

::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:return
ENDLOCAL & SET %~2=%fs#_RESULT%
GOTO :eof
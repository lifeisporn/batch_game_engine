REM Variables naming rule: <fs#varname>

SETLOCAL EnableExtensions EnableDelayedExpansion
SET fs#_hex_set_lower=0123456789abcdef
SET fs#_hex_set=0123456789ABCDEF
SET fs#_hex_len=16
SET "fs#_RESULT="
GOTO %1

::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ================================================== ::
:: ================= Functions list ================= ::
:: ================================================== ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ┌----------------┬---------------┬---------------┬---------------┐
:: |     [name]     |      [%3]     |      [%4]     |      [%5]     |
:: ├----------------┼---------------┼---------------┼---------------┤
:: | colsCount		| 				| 				|				|
:: ├----------------┼---------------┼---------------┼---------------┤
:: | newPass		| new_user = 0	| 				|				|
:: ├----------------┼---------------┼---------------┼---------------┤
:: | getPass		| 				|				|				|
:: ├----------------┼---------------┼---------------┼---------------┤
:: | getUpdates		| 				|				|				|
:: ├----------------┼---------------┼---------------┼---------------┤
:: | getFixes		| 				|				|				|
:: ├----------------┼---------------┼---------------┼---------------┤
:: | repeatString	| "string"		| multiplier	| 				|
:: ├----------------┼---------------┼---------------┼---------------┤
:: | randomItem		| "list"		|				|				|
:: ├----------------┼---------------┼---------------┼---------------┤
:: | length			| "string"		|				|				|
:: ├----------------┼---------------┼---------------┼---------------┤
:: | countItems		| "list"		|				|				|
:: ├----------------┼---------------┼---------------┼---------------┤
:: | randomURL		| 				|				|				|
:: ├----------------┼---------------┼---------------┼---------------┤
:: | delay			| milliseconds	|				|				|
:: ├----------------┼---------------┼---------------┼---------------┤
:: | random			| min			| max			| offset = 0	|
:: ├----------------┼---------------┼---------------┼---------------┤
:: | hex_rand		| length		| lowercase = 0	|				|
:: ├----------------┼---------------┼---------------┼---------------┤
:: | dec2hex		| decimal		| lowercase = 0 |				|
:: └----------------┴---------------┴---------------┴---------------┘
::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ================================================== ::
:: ==================== colsCount =================== ::
:: ================================================== ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:colsCount => public function()
FOR /F "tokens=2 delims= " %%a IN ('MODE con') DO (
	IF NOT DEFINED fs#_RESULT (
		SET /a pr#n+=1
		IF [!pr#n!] EQU [3] SET /a fs#_RESULT=%%a
	)
)
GOTO :return

::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ================================================== ::
:: ===================== newPass ==================== ::
:: ================================================== ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:newPass => public function(new_user[%3] = 0)
IF [%3] EQU [1] GOTO :newPass_prompt
ECHO | SET /p ".=(Current) "
CALL bin\IO\Input password,fs#pass0
CALL bin\Special\Functions getPass,fs#w
IF [%fs#pass0%] NEQ [%fs#w%] (
	ECHO Wrong password. Action cancelled.
	GOTO :return
)

:newPass_prompt
ECHO | SET /p ".=(New) "
CALL bin\IO\Input password,fs#pass1
IF [%fs#pass1%] EQU [] (
	ECHO Wrong Input. Be sure you are using only a-Z,0-9,_ chars set.
	ECHO.
	GOTO :newPass_prompt
)
ECHO | SET /p ".=(Re-type) "
CALL bin\IO\Input password,fs#pass2
IF [%fs#pass1%] NEQ [%fs#pass2%] (
	ECHO Password mismatch. Action cancelled.
	ECHO.
	GOTO :return
)

MD "%_etc%" > nul 2>nul
(ECHO %fs#pass1%) >"%_etc%\passwd"
SET fs#_RESULT=ok
GOTO :return

::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ================================================== ::
:: ===================== getPass ==================== ::
:: ================================================== ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:getPass => public function()
IF EXIST "%_etc%\passwd" SET /p fs#_RESULT=<"%_etc%\passwd"
GOTO :return

::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ================================================== ::
:: =================== getUpdates =================== ::
:: ================================================== ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:getUpdates => public function()
SET fs#_RESULT=0
GOTO :return

::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ================================================== ::
:: ==================== getFixes ==================== ::
:: ================================================== ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:getFixes => public function()
SET fs#_RESULT=0
GOTO :return

::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ================================================== ::
:: ================== repeatString ================== ::
:: ================================================== ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:repeatString => public function("string"[%3], multiplier[%4])
SET fs#string=%~3
SET fs#count=%4
FOR /L %%i IN (1,1,%fs#count%) DO SET "fs#_RESULT=!fs#_RESULT!%fs#string%"
GOTO :return

::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ================================================== ::
:: =================== randomItem =================== ::
:: ================================================== ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:randomItem => public function("list"[%3])
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
:: ===================== length ===================== ::
:: ================================================== ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:length => public function("string"[%3])
SET fs#string=%~3

:length_loop
IF [!fs#string:~%fs#_RESULT%!] NEQ [] (
	SET /a fs#_RESULT+=1
	GOTO :length_loop
)

GOTO :return

::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ================================================== ::
:: =================== countItems =================== ::
:: ================================================== ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:countItems => public function("list"[%3])
FOR %%i IN (%~3) DO SET /a fs#_RESULT+=1
GOTO :return

::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ================================================== ::
:: ==================== randomURL =================== ::
:: ================================================== ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:randomURL => public function()
SET fs#protocols_list=https http ftp sftp ssh dhcp irc cops xmpp socks telnet tftp ftps ssl tls sip
SET fs#domains1_list=www www1 www2
SET fs#domains2_list=ns1 ns2 s1 s2 r1 r2 one two
SET fs#domains3_list=gain nails pack api naive native laboratory service web dns
SET fs#domains4_list=safeblock-company security-corporation s-corp guarantor-company scorp-safe safety-me llc-seckeys
SET fs#domains5_list=com ru net org xyz de ua

CALL bin\Special\Functions randomItem,fs#protocol,"%fs#protocols_list%"
SET "fs#_RESULT=%fs#protocol%://"

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
:: ====================== delay ===================== ::
:: ================================================== ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:delay => public function(milliseconds[%3])
REM Minimum delay - 50ms; error spread ~10ms
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
:: ===================== random ===================== ::
:: ================================================== ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:random => public function(min[%3], max[%4], offset[%5] = 0)
IF [%5] EQU [] (
	SET fs#offset=0
) ELSE (
	SET fs#offset=%5
)
SET /a fs#_RESULT=%random%%%(%4-%3+1)+%3+%fs#offset%
GOTO :return

::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ================================================== ::
:: ==================== hex_rand ==================== ::
:: ================================================== ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:hex_rand => public function(length[%3], lowercase[%4] = 0)
IF [%4] EQU [1] SET fs#_hex_set=%fs#_hex_set_lower%
FOR /L %%i IN (1,1,%3) DO CALL :hex_rand_add
GOTO :return

:hex_rand_add
CALL bin\Special\Functions random,fs#rand,1,%fs#_hex_len%,-1
SET fs#_RESULT=%fs#_RESULT%!fs#_hex_set:~%fs#rand%,1!
GOTO :eof

::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ================================================== ::
:: ===================== dec2hex ==================== ::
:: ================================================== ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:dec2hex => public function(decimal[%3], lowercase[%4] = 0)
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
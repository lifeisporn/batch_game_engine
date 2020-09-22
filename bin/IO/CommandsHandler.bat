REM Variables naming rule: <ch#varname>
SETLOCAL EnableExtensions EnableDelayedExpansion
CHCP 65001 > nul 2>nul

SET "ch#help_filler=------------------------------------------------------------------------"

REM Trying to delete symbols that can crash console. Quotes replacement should be the last.
SET ch#raw=%2
SET ch#raw=%ch#raw:,=%
SET ch#raw=%ch#raw:|=%
SET ch#raw=%ch#raw:>=%
SET ch#raw=%ch#raw:<=%
SET ch#raw=%ch#raw:"=%

REM Explode raw data into command and params
FOR /F "tokens=1* delims= " %%a IN ("%ch#raw%") DO (
	SET "ch#cmd=%%a"
	SET ch#params="%%b"
)

REM Using local vars for change globals
SET "ch#_CUR_PATH=%_CUR_PATH%"
SET "ch#_CUR_USER=%_CUR_USER%"
SET "ch#_CUR_ADDR=%_CUR_ADDR%"

GOTO %ch#cmd% > nul 2>nul

::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ================================================== ::
:: ================= Functions list ================= ::
:: ================================================== ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:: help()
:: news(irc_channel)
:: irc()
:: pass()
:: whoami()
:: cd(newpath)
:: ls()
:: cls()
:: logout()
:: shutdown()

::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ================================================== ::
:: ====================== HELP ====================== ::
:: ================================================== ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:help
REM ----------------------------------------------------
ECHO %ch#help_filler%
ECHO   You can use the following commands:
ECHO      HELP         Show commands list.
ECHO      NEWS         Open special news feed.
ECHO      IRC          Open IRC client.
ECHO      PASS         Change password.
ECHO      CD           Change current directory.
ECHO      LS           List files and subdirectories of current directory.
ECHO      CLS          Clear console.
ECHO      LOGOUT       Log out.
ECHO      SHUTDOWN     Shut down the system.
ECHO %ch#help_filler%
REM ----------------------------------------------------
GOTO :return

::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ================================================== ::
:: ======================= NEWS ====================== ::
:: ================================================== ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:news
IF [%ch#params:-h=%] NEQ [%ch#params%] (
	ECHO %ch#help_filler%
	ECHO   Usage:
	ECHO          NEWS [-h][channel]
	ECHO.
	ECHO   Info:
	ECHO          Open special news feed.
	ECHO.
	ECHO   Parameters:
	ECHO          -h        Show this help.
	ECHO          channel   Use "channel" as news provider. News feed will
	ECHO                    be provided by the specified IRC channel
	ECHO                    (enter channel name without sharp sign^).
	ECHO %ch#help_filler%
	
	GOTO :return
)
IF [%ch#params:-=%] NEQ [%ch#params%] (
	SET ch#cmd=err
	GOTO :return
)
IF [%ch#params:"=%] EQU [] (
	SET ch#cmd=err
	GOTO :return
)
REM ----------------------------------------------------
START bin\Special\News\News.core %ch#params%
REM ----------------------------------------------------
GOTO :return

::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ================================================== ::
:: ======================= IRC ====================== ::
:: ================================================== ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:irc
IF [%ch#params:-h=%] NEQ [%ch#params%] (
	ECHO %ch#help_filler%
	ECHO   Usage:
	ECHO          IRC [-h]
	ECHO.
	ECHO   Info:
	ECHO          Open IRC client.
	ECHO.
	ECHO   Parameters:
	ECHO          -h        Show this help.
	ECHO.
	ECHO   Notes: 
	ECHO          • System will connect to local freenode server.
	ECHO %ch#help_filler%
	
	GOTO :return
)
IF [%ch#params:-=%] NEQ [%ch#params%] (
	SET ch#cmd=err
	GOTO :return
)
REM ----------------------------------------------------
START bin\Special\IRC\IRC.core
REM ----------------------------------------------------
GOTO :return

::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ================================================== ::
:: ====================== PASS ====================== ::
:: ================================================== ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:pass
IF [%ch#params:-h=%] NEQ [%ch#params%] (
	ECHO %ch#help_filler%
	ECHO   Usage:
	ECHO          PASS [-h]
	ECHO.
	ECHO   Info:
	ECHO          Change password.
	ECHO.
	ECHO   Parameters:
	ECHO          -h        Show this help.
	ECHO %ch#help_filler%
	
	GOTO :return
)
IF [%ch#params:-=%] NEQ [%ch#params%] (
	SET ch#cmd=err
	GOTO :return
)
REM ----------------------------------------------------
CALL bin\Special\Functions newPass,ch#res
IF [%ch#res%] EQU [ok] (
	ECHO You have successfully changed your password^^!
	ECHO Please log in to your account using new password.
	SET ch#cmd=logout
)
REM ----------------------------------------------------
GOTO :return

::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ================================================== ::
:: ===================== WHOAMI ===================== ::
:: ================================================== ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:who
IF [%ch#params%] EQU [""] (
	SET "ch#cmd="
	GOTO :return
)
IF [%ch#params%] NEQ ["am i"] (
	SET ch#cmd=err
	GOTO :return
)
:whoami
REM ----------------------------------------------------
ECHO %_CUR_USER%
REM ----------------------------------------------------
GOTO :return

::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ================================================== ::
:: ======================= CD ======================= ::
:: ================================================== ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:cd
IF [%ch#params:-h=%] NEQ [%ch#params%] (
	ECHO %ch#help_filler%
	ECHO   Usage:
	ECHO          CD [.][..][path][-h]
	ECHO.
	ECHO   Info:
	ECHO          Change current directory.
	ECHO.
	ECHO   Parameters:
	ECHO          .         Go up to root directory.
	ECHO          ..        Go up to parent directory.
	ECHO          -h        Show this help.
	ECHO          path      Go to specified "path" (use backslash "\" for 
	ECHO                    separate directories^).
	ECHO.
	ECHO   Notes: 
	ECHO          • Please use only the following character set
	ECHO            in directory names: 0-9,a-b,A-Z,_
	ECHO %ch#help_filler%
	
	GOTO :return
)
IF [%ch#params:-=%] NEQ [%ch#params%] (
	SET ch#cmd=err
	GOTO :return
)
IF [%ch#params:"=%] EQU [] (
	GOTO :return
)
REM ----------------------------------------------------
SET "ch#path=%_root:~0,-2%\%_CUR_PATH%"

SET ch#params=%ch#params:"=%
IF [%ch#params%] EQU [.] (
	SET "ch#newpath=%_root:~0,-2%\~"
	GOTO :cd_save_path
)
IF [%ch#params%] EQU [..] (
	IF [%ch#path%] EQU [%_root%] GOTO :return
	:cd_loop1
	SET ch#path=!ch#path:~0,-1!
	IF DEFINED ch#found (
		SET "ch#newpath=%ch#path%"
		GOTO :cd_save_path
	)
	IF [!ch#path:~-1!] EQU [\] SET ch#found=1
	GOTO :cd_loop1
)
IF [%ch#params:~-1%] EQU [\] SET ch#params=%ch#params:~0,-1%
SET "ch#newpath=%ch#path%\%ch#params%"
IF NOT EXIST %ch#newpath%\* (
	ECHO Specified path does not exist.
	GOTO :return
)

:cd_save_path
SET "ch#_CUR_PATH=!ch#newpath:%_root:~0,-1%=!"
REM ----------------------------------------------------
GOTO :return

::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ================================================== ::
:: ======================= LS ======================= ::
:: ================================================== ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:ls
IF [%ch#params:-h=%] NEQ [%ch#params%] (
	ECHO %ch#help_filler%
	ECHO   Usage:
	ECHO          LS [-h]
	ECHO.
	ECHO   Info:
	ECHO          List files and subdirectories of current directory.
	ECHO.
	ECHO   Parameters:
	ECHO          -h        Show this help.
	ECHO.
	ECHO   Notes: 
	ECHO          • If there is a colon after the name of any file or subdirectory - 
	ECHO            this is a command bug, not a name part, do not pay attention.
	ECHO %ch#help_filler%
	
	GOTO :return
)
IF [%ch#params:-=%] NEQ [%ch#params%] (
	SET ch#cmd=err
	GOTO :return
)
REM ----------------------------------------------------
SET "ch#path=%_root:~0,-2%\%_CUR_PATH%"
SET "ch#spaces=   "
FOR /D %%e IN (%ch#path%\*) DO SET "ch#list_dirs=!ch#list_dirs!%ch#spaces%%%~nxe"
FOR %%e IN (%ch#path%\*) DO SET "ch#list_files=!ch#list_files!%ch#spaces%%%~nxe"
IF DEFINED ch#list_dirs CALL bin\IO\Print colored,black,aqua,"%ch#list_dirs%"
IF DEFINED ch#list_files CALL bin\IO\Print colored,black,laqua,"%ch#list_files%"
ECHO.
REM ----------------------------------------------------
GOTO :return

::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ================================================== ::
:: ======================= CLS ====================== ::
:: ================================================== ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:cls
IF [%ch#params:-h=%] NEQ [%ch#params%] (
	ECHO %ch#help_filler%
	ECHO   Usage:
	ECHO          CLS [-h]
	ECHO.
	ECHO   Info:
	ECHO          Clear console.
	ECHO.
	ECHO   Parameters:
	ECHO          -h        Show this help.
	ECHO %ch#help_filler%
	
	GOTO :return
)
IF [%ch#params:-=%] NEQ [%ch#params%] (
	SET ch#cmd=err
	GOTO :return
)
REM ----------------------------------------------------
CLS
REM ----------------------------------------------------
GOTO :return

::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ================================================== ::
:: ===================== LOGOUT ===================== ::
:: ================================================== ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:logout
IF [%ch#params:-h=%] NEQ [%ch#params%] (
	ECHO %ch#help_filler%
	ECHO   Usage:
	ECHO          LOGOUT [-h]
	ECHO.
	ECHO   Info:
	ECHO          Log out.
	ECHO.
	ECHO   Parameters:
	ECHO          -h        Show this help.
	ECHO %ch#help_filler%
	
	GOTO :return
)
IF [%ch#params:-=%] NEQ [%ch#params%] (
	SET ch#cmd=err
	GOTO :return
)
REM ----------------------------------------------------
REM do nothing
REM ----------------------------------------------------
GOTO :return

::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ================================================== ::
:: ==================== SHUTDOWN ==================== ::
:: ================================================== ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:shutdown
IF [%ch#params:-h=%] NEQ [%ch#params%] (
	ECHO %ch#help_filler%
	ECHO   Usage:
	ECHO          SHUTDOWN [-h]
	ECHO.
	ECHO   Info:
	ECHO          Shut down the system.
	ECHO.
	ECHO   Parameters:
	ECHO          -h        Show this help.
	ECHO %ch#help_filler%
	
	GOTO :return
)
IF [%ch#params:-=%] NEQ [%ch#params%] (
	SET ch#cmd=err
	GOTO :return
)
REM ----------------------------------------------------
CALL bin\Sugar\TurnOff
REM ----------------------------------------------------
GOTO :return

::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:return
ENDLOCAL & (
	SET "%~1=%ch#cmd%"
	
	SET "_CUR_PATH=%ch#_CUR_PATH%"
	SET "_CUR_USER=%ch#_CUR_USER%"
	SET "_CUR_ADDR=%ch#_CUR_ADDR%"
	
	GOTO :eof
)
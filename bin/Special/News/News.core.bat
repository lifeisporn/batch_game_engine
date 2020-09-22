@ECHO off
REM Variables naming rule: <news#varname>
SETLOCAL EnableExtensions EnableDelayedExpansion
CHCP 65001 > nul 2>nul

FOR /F %%a IN ('ECHO prompt $H ^| cmd') DO SET "news#bs=%%a"

SET news#cols=50
SET news#lines=25

MODE CON cols=%news#cols% lines=%news#lines%
TITLE News feed

SET news#channel=%~1
SET "news#load_stages0= /"
SET "news#load_stages1=──"
SET "news#load_stages2= \"
SET "news#load_stages3= |"
SET "news#load_stages4= /"
SET "news#load_stages5=──"
SET "news#load_stages6= \"
SET "news#load_stages7= |"

ECHO | SET /p ".=Provider channel "
CALL bin\IO\Print colored,white,blue,"#%news#channel%",0
ECHO | SET /p ".=: "
	
IF NOT EXIST "%_local%\%news#channel%" (
	CALL bin\IO\Print colored,black,lred,"404 Not Found",1
	ECHO.
	ECHO Press any key to exit...
	PAUSE > nul
	EXIT
) ELSE (
	CALL bin\IO\Print colored,black,laqua,"302 Found",0
	
	CALL bin\Special\Functions random,news#rand,7,21
	FOR /L %%i IN (1,1,!news#rand!) DO (
		IF NOT DEFINED news#load_stage (
			SET news#load_stage=0
			rem ECHO | SET /p ".=__"
		) ELSE (
			SET /a news#load_stage+=1
			IF !news#load_stage! GTR 7 SET news#load_stage=0
		)
		CALL SET "news#load_char=%%news#load_stages!news#load_stage!%%"
		rem ECHO | SET /p ".=%news#bs%%news#bs% !news#load_char!"
		TITLE News feed ^| Provider: #%news#channel%    !news#load_char!
		CALL bin\Special\Functions delay,r,200
	)
	
	TITLE News feed ^| Provider: #%news#channel%
	REM Length of message "302 Found"
	ECHO | SET /p ".=%news#bs%%news#bs%%news#bs%%news#bs%%news#bs%%news#bs%%news#bs%%news#bs%%news#bs%"
	CALL bin\IO\Print colored,black,green,"200 Success",0
	CALL bin\Special\Functions delay,r,1000
)

REM Clear console from colored background
CLS
COLOR 80

:news
MODE CON cols=%news#cols% lines=%news#lines%
TITLE News feed [#%news#channel%] ^| Loaded.

SET news#news_count=0
FOR %%f IN (%_local%\%news#channel%\news\news*.txt) DO SET /a news#news_count+=1
IF %news#news_count% GTR 3 SET /a news#news_count-=3

FOR %%f IN (%_local%\%news#channel%\news\news*.txt) DO (
	SET news#cur_news_name=%%~nf
	IF !news#cur_news_name:~4! GTR %news#news_count% (
		FOR /F "tokens=1,2 delims=;" %%l IN (%%f) DO (
			ECHO [%%l] %%m
		)
		ECHO.
	)
)

CALL bin\Special\Functions delay,r,2000

FOR /L %%i IN (5,-1,0) DO (
	IF %%i GTR 0 (
		TITLE News feed [#%news#channel%] ^| Refresh in %%i...
	) ELSE (
		TITLE News feed [#%news#channel%] ^| Updating...
	)
	CALL bin\Special\Functions delay,r,1000
)

GOTO :news
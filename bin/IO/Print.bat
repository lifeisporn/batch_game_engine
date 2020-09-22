REM Variables naming rule: <pr#varname>

SETLOCAL EnableExtensions EnableDelayedExpansion
FOR /F %%a IN ('ECHO prompt $H ^| cmd') DO SET "pr#_char[backspace]=%%a"
GOTO %1

::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ================================================== ::
:: ================= Functions list ================= ::
:: ================================================== ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ┌----------------┬---------------┬---------------┬---------------┬---------------┐
:: |     [name]     |      [%2]     |      [%3]     |      [%4]     |      [%5]     |
:: ├----------------┼---------------┼---------------┼---------------┤---------------┤
:: | table			| "header"		| "body"		|				|				|
:: ├----------------┼---------------┼---------------┼---------------┤---------------┤
:: | colored		| bg_color		| font_color	| "text"		| new_line = 0	|
:: ├----------------┼---------------┼---------------┼---------------┤---------------┤
:: | slowecho		| "text"		|				|				|				|
:: ├----------------┼---------------┼---------------┼---------------┤---------------┤
:: | updecho		| "text"		| 				| 				|				|
:: ├----------------┼---------------┼---------------┼---------------┼---------------┤
:: | typing			| "text"		| nex_line = 0	|				|				|
:: └----------------┴---------------┴---------------┴---------------┴---------------┘
::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ================================================== ::
:: ====================== table ===================== ::
:: ================================================== ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:table => public function("header"[%2], "body"[%3])
CHCP 65001>nul
REM Initial settings
SET "pr#_char[num]=№"
SET "pr#_char[line_hor]=─"
SET "pr#_char[line_ver]=|"
SET "pr#_char[left_top]=┌"
SET "pr#_char[left_mid]=├"
SET "pr#_char[left_bot]=└"
SET "pr#_char[top_mid]=┬"
SET "pr#_char[mid]=┼"
SET "pr#_char[bot_mid]=┴"
SET "pr#_char[right_top]=┐"
SET "pr#_char[right_mid]=┤"
SET "pr#_char[right_bot]=┘"

SET pr#header_data=%~2
SET pr#body_data=%~3
SET pr#header_data=%pr#header_data: =_%
SET pr#body_data=%pr#body_data: =_%

REM Get cols count + num col width
CALL bin\Special\Functions countItems,pr#cols_count,"%pr#header_data%"
SET /a pr#cols_count+=1

REM Inserting numbering in data
SET "pr#cells_data=%pr#_char[num]%;%pr#header_data%"

SET pr#cur_col=1
SET pr#cur_row=1
FOR %%e IN (%pr#body_data%) DO (
	IF [!pr#cur_col!] EQU [1] (
		SET "pr#cells_data=!pr#cells_data!;!pr#cur_row!"	
		SET /a pr#cur_col+=1
	)
	
	SET "pr#cells_data=!pr#cells_data!;%%e"
	SET /a pr#cur_col+=1
	
	IF !pr#cur_col! GTR %pr#cols_count% (
		SET pr#cur_col=1
		SET /a pr#cur_row+=1
	)
)

REM Fill empty cells by spaces
CALL bin\Special\Functions countItems,pr#cells_count,"%pr#cells_data%"
SET /a pr#empty_pr#cells_count=%pr#cols_count%-%pr#cells_count%%%%pr#cols_count%
IF [%pr#empty_pr#cells_count%] EQU [%pr#cols_count%] SET pr#empty_pr#cells_count=0
CALL bin\Special\Functions repeatString,pr#empty_cells_filler,";_",%pr#empty_pr#cells_count%
SET pr#cells_data=%pr#cells_data%%pr#empty_cells_filler%
SET /a rows_count=%pr#cells_count%/%pr#cols_count%
IF %pr#empty_pr#cells_count% GTR 0 SET /a rows_count+=1

REM Cols width
FOR /L %%c IN (1,1,%pr#cols_count%) DO CALL :table_get_max_col_length pr#max_col_length[%%c],"%pr#cells_data%",%pr#cols_count%,%%c

REM Center cells
SET pr#cur_cell=0
SET pr#cur_col=0
FOR %%e IN (%pr#cells_data%) DO (
	SET /a pr#cur_cell +=1
	SET /a pr#cur_col +=1
	CALL bin\Special\Functions length,pr#cur_cell_length,%%e
	IF !pr#cur_cell! LEQ %pr#cols_count% (
		CALL SET /a pr#filler_count=%%pr#max_col_length[!pr#cur_col!]%%-!pr#cur_cell_length!
		SET /a pr#pr#filler_right_count=!pr#filler_count!/2
		SET /a pr#pr#filler_left_count=!pr#pr#filler_right_count!+!pr#filler_count!%%2
		CALL bin\Special\Functions repeatString,pr#cell_pr#filler_left[!pr#cur_cell!]," ",!pr#pr#filler_left_count!
		CALL bin\Special\Functions repeatString,pr#cell_pr#filler_right[!pr#cur_cell!]," ",!pr#pr#filler_right_count!
	) ELSE (
		CALL SET /a pr#pr#filler_left_count=%%pr#max_col_length[!pr#cur_col!]%%-!pr#cur_cell_length!
		CALL bin\Special\Functions repeatString,pr#cell_pr#filler_left[!pr#cur_cell!]," ",!pr#pr#filler_left_count!
		SET "pr#cell_pr#filler_right[!pr#cur_cell!]="
	)
	IF [!pr#cur_col!] EQU [%pr#cols_count%] SET pr#cur_col=0
)

REM Middle filler
SET pr#mid_filler=%pr#_char[left_mid]%
FOR /L %%n IN (1,1,%pr#cols_count%) DO (
	CALL bin\Special\Functions repeatString,pr#res,%pr#_char[line_hor]%,!pr#max_col_length[%%n]!
	SET pr#mid_filler=!pr#mid_filler!!pr#res!%pr#_char[mid]%
)
SET pr#mid_filler=!pr#mid_filler:~0,-1!%pr#_char[right_mid]%

REM Print top edges
ECHO | SET /p ".=%pr#_char[left_top]%"

FOR /L %%c IN (1,1,%pr#cols_count%) DO (
	FOR /L %%l IN (1,1,!pr#max_col_length[%%c]!) DO ECHO | SET /p ".=%pr#_char[line_hor]%"
	IF %%c LSS %pr#cols_count% ECHO | SET /p ".=%pr#_char[top_mid]%"
)
ECHO | SET /p ".=%pr#_char[right_top]%"

ECHO.

REM Print cells
SET pr#cur_cell=1
SET pr#cur_col=1
SET pr#cur_row=1
FOR %%b IN (%pr#cells_data%) DO (
	CALL SET "pr#filler_left=%%pr#cell_pr#filler_left[!pr#cur_cell!]%%"
	CALL SET "pr#filler_right=%%pr#cell_pr#filler_right[!pr#cur_cell!]%%"
	SET pr#cell_data=%%b
	ECHO | SET /p ".=%pr#_char[line_ver]%!pr#filler_left!!pr#cell_data:_= !!pr#filler_right!"
	
	SET /a pr#cur_cell +=1
	SET /a pr#cur_col+=1
	IF !pr#cur_col! GTR %pr#cols_count% (
		IF !pr#cur_row! LSS %rows_count% (
			SET pr#cur_col=1
			SET /a pr#cur_row+=1
			ECHO ^%pr#_char[line_ver]%
			ECHO %pr#mid_filler%
		)
	)
)
ECHO ^|

REM Print bottom edges
ECHO | SET /p ".=%pr#_char[left_bot]%"

FOR /L %%c IN (1,1,%pr#cols_count%) DO (
	FOR /L %%l IN (1,1,!pr#max_col_length[%%c]!) DO ECHO | SET /p ".=%pr#_char[line_hor]%"
	IF %%c LSS %pr#cols_count% ECHO | SET /p ".=%pr#_char[bot_mid]%"
)
ECHO | SET /p ".=%pr#_char[right_bot]%"

ECHO.

GOTO :eof

:table_get_max_col_length
SETLOCAl
SET "pr#_RESULT="
SET pr#cur_col=0
SET pr#col_count=%3
SET pr#n_col=%4

FOR %%e IN (%~2) DO (
	SET /a pr#cur_col+=1
	IF [!pr#cur_col!] EQU [%pr#n_col%] (
		CALL bin\Special\Functions length,pr#res,%%e
		IF !pr#_RESULT! LSS !pr#res! SET pr#_RESULT=!pr#res!
	)
	IF [!pr#cur_col!] EQU [%pr#cols_count%] SET pr#cur_col=0
)

ENDLOCAL & SET %~1=%pr#_RESULT%

GOTO :eof

::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ================================================== ::
:: ===================== colored ==================== ::
:: ================================================== ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:colored => public function(bg_color[%2], font_color[%3], "text"[%4], new_line[%5] = 0)
SET "pr#tmp_path=%_tmp%\colored"
SET "pr#color_tmp_file_ext=.col"
REM Define colors codes
SET pr#colors_list=black blue green aqua red purple yellow white gray lblue lgreen laqua lred lpurple lyellow bwhite
SET pr#n=0
FOR %%c IN (%pr#colors_list%) DO (
	CALL bin\Special\Functions dec2hex,pr#color_%%c,!pr#n!
	SET /a pr#n+=1
)
SET pr#colors=!pr#color_%~2!!pr#color_%~3!

REM Define type of string (path or plain text); deleting ending backslash
SET "pr#raw=%pr#tmp_path%\%~4"
IF [%pr#raw:~-1%] EQU [\] (SET pr#raw=%pr#raw:~0,-1%)
IF ["%pr#raw:~-1%"] EQU ["~"] (
	SET "pr#raw=%pr#raw%\_"
	REM 1-colon length in `findstr` output, 
	REM 2-length of `\_` from SET above, 
	REM 4-length of tmp-file extension with dot (<pr#color_tmp_file_ext>)
	SET /a pr#backspaces_count=1+2+4
) ELSE (
	SET /a pr#backspaces_count=1+0+4
)

SET "pr#file_path="
SET "pr#file_name=%pr#raw%"
IF ["%pr#raw:\=%"] NEQ ["%pr#raw%"] (
	SET pr#is_path=1
	FOR /F "delims=" %%f IN ("%pr#raw%") DO (
		SET "pr#file_name=%%~nxf"
		SET "pr#file_path=%%~dpf"
		SET "pr#file_path=!pr#file_path:%~dp0=!"
		SET "pr#file_path=!pr#file_path:~0,-1!"
	)
)

CALL bin\Special\Functions repeatString,pr#backspaces,"%pr#_char[backspace]% %pr#_char[backspace]%",%pr#backspaces_count%

MD %pr#tmp_path% > nul 2>nul
PUSHD %pr#tmp_path%

IF [%pr#is_path%] EQU [1] (
	MD "%pr#file_path%" > nul 2>nul
	SET "pr#text=%pr#file_path%\%pr#file_name%"
) ELSE (
	SET "pr#text=%pr#file_name%"
)
SET pr#text=!pr#text:%pr#tmp_path%\=!%pr#color_tmp_file_ext%

ECHO | SET /p ".=%pr#backspaces%" > "%pr#text%"

findstr /v /a:%pr#colors% /r "^$" "%pr#text%" nul
DEL "%pr#text%" > nul 2>nul

POPD

IF [%5] EQU [1] ECHO.

GOTO :eof

::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ================================================== ::
:: ==================== tty_info ==================== ::
:: ================================================== ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:tty_info => private function(brackets_color[%2], inner_text_color[%3], "in_text"[%4], "out_text"[%5], new_line[%6] = 0)
CALL bin\IO\Print colored,black,%2,"[",0
CALL bin\IO\Print colored,black,%3," %~4",0
CALL bin\IO\Print colored,black,%2," ]",0
ECHO | SET /p ".=: %~5"
IF [%6] EQU [1] ECHO.

GOTO :eof

::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ================================================== ::
:: ==================== slowecho ==================== ::
:: ================================================== ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:slowecho => public function("text"[%2], new_line[%3] = 0)
FOR %%s IN (%~2) DO (
	CALL bin\Special\Functions random,pr#count,1,10000
	FOR /L %%i IN (1,1,!pr#count!) DO (ECHO 1>nul)
	ECHO | SET /p ".=%%s "
)
IF [%3] EQU [1] ECHO.

GOTO :eof

::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ================================================== ::
:: ===================== updecho ==================== ::
:: ================================================== ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:updecho => public function("text"[%2])
SET pr#text=%~2

REM Clear entire line
CALL bin\Special\Functions colsCount,pr#cmd_cols_count
REM <backspace><space><backspace> for replace old symbols with space
CALL bin\Special\Functions repeatString,pr#backspaces,"%pr#_char[backspace]% %pr#_char[backspace]%",%pr#cmd_cols_count%
ECHO | SET /p ".=%pr#backspaces%"

IF "%pr#text%" NEQ "" (
	ECHO | SET /p ".=%pr#text%"
)

GOTO :eof

::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ================================================== ::
:: ===================== typing ===================== ::
:: ================================================== ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:typing => public function("text"[%2], new_line[%3] = 0)
REM `!` should be escaped by `^^` in batch script.
CHCP 65001>nul
SETLOCAL DisableDelayedExpansion
SET pr#text=%~2
SET pr#text=%pr#text: =░%
SET pr#text=%pr#text:!=▒%
SETLOCAL EnableDelayedExpansion
CALL bin\Special\Functions length,pr#str_len,"%pr#text%"

:typing_loop
IF NOT DEFINED pr#cur_char_num (SET pr#cur_char_num=0) ELSE (SET /a pr#cur_char_num +=1)
IF %pr#cur_char_num% LSS %pr#str_len% (
	SET "pr#char=!pr#text:~%pr#cur_char_num%,1!"
	ECHO | SET /p ".=!pr#char!"
	IF [!pr#char!] EQU [░] ECHO | SET /p ".=%pr#_char[backspace]% "
	IF [!pr#char!] EQU [▒] (
		SETLOCAL DisableDelayedExpansion
		ECHO | SET /p ".=%pr#_char[backspace]%!"
		SETLOCAL EnableDelayedExpansion
	)
	CALL bin\Special\Functions delay,r,50
	GOTO :typing_loop
)
IF [%3] EQU [1] ECHO.

GOTO :eof
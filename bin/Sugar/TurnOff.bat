ECHO.
ECHO    * The system now is going down...
ECHO.
CALL bin\Special\Functions delay,r,1000

FOR /F "tokens=*" %%l IN (bin\Sugar\serenity_shutdown) DO (
	CALL bin\IO\Print tty_info,bwhite,lgreen,OK,"%%l",1
	CALL bin\Special\Functions delay,r,100
)
ECHO.

CALL bin\IO\Print tty_info,bwhite,lred,NOW,"Good night...",1

CALL bin\Special\Functions delay,r,500
COLOR 87
CALL bin\Special\Functions delay,r,1500

EXIT
IF EXIST bin\Sugar\TurnOn_flag.txt (
	CHOICE /N /M "Do you want to skip the turn on animation (y/n)? "
	IF [!errorlevel!] EQU [1] GOTO :eof
) ELSE (
	ECHO 1>bin\Sugar\TurnOn_flag.txt
)

CLS

SET "boot_path=.boot/CoreInstructions/Library/phs_x/serenity"

CALL bin\Special\Functions delay,r,1000
COLOR 97
CALL bin\Special\Functions delay,r,100
COLOR 17
CALL bin\Special\Functions delay,r,1200
COLOR 97
CALL bin\Special\Functions delay,r,100
COLOR 87

CALL bin\Special\Functions delay,r,1000
CLS

ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO  ________       _______       ________      _______       ________       ___      _________     ___    ___ 
ECHO ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
ECHO \ \  \___^|_    \ \   __/^|    \ \  \^|\  \   \ \   __/^|    \ \  \\ \  \   \ \  \   \^|___ \  \_^|  \ \  \/  / /
ECHO  \ \_____  \    \ \  \_^|/__   \ \   _  _\   \ \  \_^|/__   \ \  \\ \  \   \ \  \       \ \  \    \ \    / / 
ECHO   \^|____^|\  \    \ \  \_^|\ \   \ \  \\  \^|   \ \  \_^|\ \   \ \  \\ \  \   \ \  \       \ \  \    \/  /  /  
ECHO     ____\_\  \    \ \_______\   \ \__\\ _\    \ \_______\   \ \__\\ \__\   \ \__\       \ \__\ __/  / /    
ECHO    ^|\_________\    \^|_______^|    \^|__^|\^|__^|    \^|_______^|    \^|__^| \^|__^|    \^|__^|        \^|__^|^|\___/ /     
ECHO    \^|_________^|                                                                               \^|___^|/

CALL bin\Special\Functions delay,r,1000
CLS

ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO  ________       _______       ________      _______       ________       ___      _________     ___    ___ 
ECHO ^|\   ____\     ^|\  ___ \     ^|\   __  \    ^|\  ___ \    ░░░░░░░░░░░░ \    ^|\  \    ^|\___   ___\  ^|\  \  /  /^|
ECHO \ \  \___^|_    \ \   __/^|    \ \  \^|\  \   \ \   __/^|    \ \  \\ \  \   \ \  \   \^|___ \  \_^|  \ \  \/  / /
ECHO  \ \_____  \    \ \  \_^|/__   \ \   _  _\   \ \  \_^|/__   \ \  \\ \  \   \ \  \       \ \  \    \ \    / / 
ECHO   \^|____^|\  \    \░░░░░░░░░░░░\ \   \ \  \\  \^|   \ \  \_^|\ \   \ \  \\ \  \   \ \  \       \ \  \    \/  /  /  
ECHO     ____\_\  \    \ \_______\   \ \__\\ _\    \ \_______\   \ \__\\ \__\   \ \__\       \ \__\ __/  / /    
ECHO    ^|\_________\    \^|_______^|    \^|__^|\^|__^|    \^|_______^|    \^|__^| \^|__^|    \^|__^|        \^|__^|^|\___/ /     
ECHO    \^|_________^|                                                                               \^|___^|/

CALL bin\Special\Functions delay,r,1000
CLS

ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO  ________       _______       ________      _______       ________       ___      _________     ___    ___ 
ECHO ^|\   ____\     ^|\  ___ \     ^|\   __  \    ^|\  ___ \     ^|\   ___  \    ^|\  \    ^|\___   ___\  ^|\  \  /  /^|
ECHO \ \  \___^|_    \ \   __/^|    \ \  \^|\  \   \ \   __/^|  ░░░░░░░░░░░░  \ \  \   \^|___ \  \_^|  \ \  \/  / /
ECHO  \ \_____  \    \ \  \_^|/__   \ \   _  _\   \ \  \_^|/__   \ \  \\ \  \   \ \  \       \ \  \    \ \    / / 
ECHO   \^|____^|\  \    \ \  \_^|\ \  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░\\ \  \   \ \  \       \ \  \    \/  /  /  
ECHO     ____\_\  \    \ \_______\   \ \__\\ _\    \ \_______\   \ \__\\ \__\   \ \__\       \ \__\ __/  / /    
ECHO    ^|\_________\    \^|_______^|    \^|__^|\^|__^|    \^|_______^|    \^|__^| \^|__^|    \^|__^|        \^|__^|^|\___/ /     
ECHO    \^|_________^|                                                                               \^|___^|/


CALL bin\Special\Functions delay,r,500
CLS

ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO  ________   ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░    _________     ___    ___ 
ECHO ^|\   ____\     ^|\  ___ \     ^|\   __  \    ^|\  ___ \     ^|\   ___  \    ^|\  \    ^|\___   ___\  ^|\  \  /  /^|
ECHO \ \  \___^|_    \ \   __/^|    \ \  \^|\  \   \ \   __/^|  ░░░░░░░░░░░░  \ \  \   \^|___ \  \_^|  \ \  \/  / /
ECHO  \ \_____ ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ \  \_   \ \  \    \ \    / / 
ECHO   \^|____^|\  \    \ \  \_^|\ \  ░░░░░░░░░░░░\^|   \ \  \_^|\ \   \ \  \\ \  \   \ \  \       \ \  \    \/  /  /  
ECHO     ____\_\  \    \ \_______\   \ \__\\ _\    \ \_______\   \ \__\\ \__\   \ \__\       \ \__\ __/  / /    
ECHO    ^|\_________\    \^|_______^|    \^|__^|\^|__^|    \^|_______^|    \^|__^| \^|__^|    \^|__^|        \^|__^|^|\___/ /     
ECHO    \^|_________^|                                                                               \^|___^|/


CALL bin\Special\Functions delay,r,500
CLS
COLOR 07

CALL bin\Special\Functions delay,r,200
CLS

ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO  ________       _______       ________      _______       ________       ___      _________     ___    ___ 
ECHO ^|\   ____\     ^|\  ___ \     ^|\   __  \    ^|\  ___ \     ^|\   ___  \    ^|\  \    ^|\___   ___\  ^|\  \  /  /^|
ECHO \ \  \___^|_    \ \   __/^|    \ \  \^|\  \   \ \   __/^|    \ \  \\ \  \   \ \  \   \^|___ \  \_^|  \ \  \/  / /
ECHO  \ \_____  \    \ \  \_^|/__   \ \   _  _\   \ \  \_^|/__   \ \  \\ \  \   \ \  \       \ \  \    \ \    / / 
ECHO   \^|____^|\  \    \ \  \_^|\ \   \ \  \\  \^|   \ \  \_^|\ \   \ \  \\ \  \   \ \  \       \ \  \    \/  /  /  
ECHO     ____\_\  \    \ \_______\   \ \__\\ _\    \ \_______\   \ \__\\ \__\   \ \__\       \ \__\ __/  / /    
ECHO    ^|\_________\    \^|_______^|    \^|__^|\^|__^|    \^|_______^|    \^|__^| \^|__^|    \^|__^|        \^|__^|^|\___/ /     
ECHO    \^|_________^|                                                                               \^|___^|/
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.

CALL bin\Special\Functions delay,r,200
CLS

ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO  ________       _______       ________      _______       ________       ___      _________     ___    ___ 
ECHO ^|\   ____\     ^|\  ___ \     ^|\   __  \    ^|\  ___ \     ^|\   ___  \    ^|\  \    ^|\___   ___\  ^|\  \  /  /^|
ECHO \ \  \___^|_    \ \   __/^|    \ \  \^|\  \   \ \   __/^|    \ \  \\ \  \   \ \  \   \^|___ \  \_^|  \ \  \/  / /
ECHO  \ \_____  \    \ \  \_^|/__   \ \   _  _\   \ \  \_^|/__   \ \  \\ \  \   \ \  \       \ \  \    \ \    / / 
ECHO   \^|____^|\  \    \ \  \_^|\ \   \ \  \\  \^|   \ \  \_^|\ \   \ \  \\ \  \   \ \  \       \ \  \    \/  /  /  
ECHO     ____\_\  \    \ \_______\   \ \__\\ _\    \ \_______\   \ \__\\ \__\   \ \__\       \ \__\ __/  / /    
ECHO    ^|\_________\    \^|_______^|    \^|__^|\^|__^|    \^|_______^|    \^|__^| \^|__^|    \^|__^|        \^|__^|^|\___/ /     
ECHO    \^|_________^|                                                                               \^|___^|/
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.

CALL bin\Special\Functions delay,r,200
CLS

ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO  ________       _______       ________      _______       ________       ___      _________     ___    ___ 
ECHO ^|\   ____\     ^|\  ___ \     ^|\   __  \    ^|\  ___ \     ^|\   ___  \    ^|\  \    ^|\___   ___\  ^|\  \  /  /^|
ECHO \ \  \___^|_    \ \   __/^|    \ \  \^|\  \   \ \   __/^|    \ \  \\ \  \   \ \  \   \^|___ \  \_^|  \ \  \/  / /
ECHO  \ \_____  \    \ \  \_^|/__   \ \   _  _\   \ \  \_^|/__   \ \  \\ \  \   \ \  \       \ \  \    \ \    / / 
ECHO   \^|____^|\  \    \ \  \_^|\ \   \ \  \\  \^|   \ \  \_^|\ \   \ \  \\ \  \   \ \  \       \ \  \    \/  /  /  
ECHO     ____\_\  \    \ \_______\   \ \__\\ _\    \ \_______\   \ \__\\ \__\   \ \__\       \ \__\ __/  / /    
ECHO    ^|\_________\    \^|_______^|    \^|__^|\^|__^|    \^|_______^|    \^|__^| \^|__^|    \^|__^|        \^|__^|^|\___/ /     
ECHO    \^|_________^|                                                                               \^|___^|/
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.

CALL bin\Special\Functions delay,r,200
CLS

ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO  ________       _______       ________      _______       ________       ___      _________     ___    ___ 
ECHO ^|\   ____\     ^|\  ___ \     ^|\   __  \    ^|\  ___ \     ^|\   ___  \    ^|\  \    ^|\___   ___\  ^|\  \  /  /^|
ECHO \ \  \___^|_    \ \   __/^|    \ \  \^|\  \   \ \   __/^|    \ \  \\ \  \   \ \  \   \^|___ \  \_^|  \ \  \/  / /
ECHO  \ \_____  \    \ \  \_^|/__   \ \   _  _\   \ \  \_^|/__   \ \  \\ \  \   \ \  \       \ \  \    \ \    / / 
ECHO   \^|____^|\  \    \ \  \_^|\ \   \ \  \\  \^|   \ \  \_^|\ \   \ \  \\ \  \   \ \  \       \ \  \    \/  /  /  
ECHO     ____\_\  \    \ \_______\   \ \__\\ _\    \ \_______\   \ \__\\ \__\   \ \__\       \ \__\ __/  / /    
ECHO    ^|\_________\    \^|_______^|    \^|__^|\^|__^|    \^|_______^|    \^|__^| \^|__^|    \^|__^|        \^|__^|^|\___/ /     
ECHO    \^|_________^|                                                                               \^|___^|/
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.

CALL bin\Special\Functions delay,r,500
CLS

ECHO.
ECHO.
ECHO.
ECHO.
ECHO  ________       _______       ________      _______       ________       ___      _________     ___    ___ 
ECHO ^|\   ____\     ^|\  ___ \     ^|\   __  \    ^|\  ___ \     ^|\   ___  \    ^|\  \    ^|\___   ___\  ^|\  \  /  /^|
ECHO \ \  \___^|_    \ \   __/^|    \ \  \^|\  \   \ \   __/^|    \ \  \\ \  \   \ \  \   \^|___ \  \_^|  \ \  \/  / /
ECHO  \ \_____  \    \ \  \_^|/__   \ \   _  _\   \ \  \_^|/__   \ \  \\ \  \   \ \  \       \ \  \    \ \    / / 
ECHO   \^|____^|\  \    \ \  \_^|\ \   \ \  \\  \^|   \ \  \_^|\ \   \ \  \\ \  \   \ \  \       \ \  \    \/  /  /  
ECHO     ____\_\  \    \ \_______\   \ \__\\ _\    \ \_______\   \ \__\\ \__\   \ \__\       \ \__\ __/  / /    
ECHO    ^|\_________\    \^|_______^|    \^|__^|\^|__^|    \^|_______^|    \^|__^| \^|__^|    \^|__^|        \^|__^|^|\___/ /     
ECHO    \^|_________^|                                                                               \^|___^|/
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.

CALL bin\Special\Functions delay,r,100
CLS

ECHO.
ECHO.
ECHO.
ECHO  ________       _______       ________      _______       ________       ___      _________     ___    ___ 
ECHO ^|\   ____\     ^|\  ___ \     ^|\   __  \    ^|\  ___ \     ^|\   ___  \    ^|\  \    ^|\___   ___\  ^|\  \  /  /^|
ECHO \ \  \___^|_    \ \   __/^|    \ \  \^|\  \   \ \   __/^|    \ \  \\ \  \   \ \  \   \^|___ \  \_^|  \ \  \/  / /
ECHO  \ \_____  \    \ \  \_^|/__   \ \   _  _\   \ \  \_^|/__   \ \  \\ \  \   \ \  \       \ \  \    \ \    / / 
ECHO   \^|____^|\  \    \ \  \_^|\ \   \ \  \\  \^|   \ \  \_^|\ \   \ \  \\ \  \   \ \  \       \ \  \    \/  /  /  
ECHO     ____\_\  \    \ \_______\   \ \__\\ _\    \ \_______\   \ \__\\ \__\   \ \__\       \ \__\ __/  / /    
ECHO    ^|\_________\    \^|_______^|    \^|__^|\^|__^|    \^|_______^|    \^|__^| \^|__^|    \^|__^|        \^|__^|^|\___/ /     
ECHO    \^|_________^|                                                                               \^|___^|/
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.

CALL bin\Special\Functions delay,r,100
CLS

ECHO.
ECHO.
ECHO  ________       _______       ________      _______       ________       ___      _________     ___    ___ 
ECHO ^|\   ____\     ^|\  ___ \     ^|\   __  \    ^|\  ___ \     ^|\   ___  \    ^|\  \    ^|\___   ___\  ^|\  \  /  /^|
ECHO \ \  \___^|_    \ \   __/^|    \ \  \^|\  \   \ \   __/^|    \ \  \\ \  \   \ \  \   \^|___ \  \_^|  \ \  \/  / /
ECHO  \ \_____  \    \ \  \_^|/__   \ \   _  _\   \ \  \_^|/__   \ \  \\ \  \   \ \  \       \ \  \    \ \    / / 
ECHO   \^|____^|\  \    \ \  \_^|\ \   \ \  \\  \^|   \ \  \_^|\ \   \ \  \\ \  \   \ \  \       \ \  \    \/  /  /  
ECHO     ____\_\  \    \ \_______\   \ \__\\ _\    \ \_______\   \ \__\\ \__\   \ \__\       \ \__\ __/  / /    
ECHO    ^|\_________\    \^|_______^|    \^|__^|\^|__^|    \^|_______^|    \^|__^| \^|__^|    \^|__^|        \^|__^|^|\___/ /     
ECHO    \^|_________^|                                                                               \^|___^|/
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.

CALL bin\Special\Functions delay,r,200
CLS

ECHO.
ECHO  ________       _______       ________      _______       ________       ___      _________     ___    ___ 
ECHO ^|\   ____\     ^|\  ___ \     ^|\   __  \    ^|\  ___ \     ^|\   ___  \    ^|\  \    ^|\___   ___\  ^|\  \  /  /^|
ECHO \ \  \___^|_    \ \   __/^|    \ \  \^|\  \   \ \   __/^|    \ \  \\ \  \   \ \  \   \^|___ \  \_^|  \ \  \/  / /
ECHO  \ \_____  \    \ \  \_^|/__   \ \   _  _\   \ \  \_^|/__   \ \  \\ \  \   \ \  \       \ \  \    \ \    / / 
ECHO   \^|____^|\  \    \ \  \_^|\ \   \ \  \\  \^|   \ \  \_^|\ \   \ \  \\ \  \   \ \  \       \ \  \    \/  /  /  
ECHO     ____\_\  \    \ \_______\   \ \__\\ _\    \ \_______\   \ \__\\ \__\   \ \__\       \ \__\ __/  / /    
ECHO    ^|\_________\    \^|_______^|    \^|__^|\^|__^|    \^|_______^|    \^|__^| \^|__^|    \^|__^|        \^|__^|^|\___/ /     
ECHO    \^|_________^|                                                                               \^|___^|/
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.

CALL bin\Special\Functions delay,r,500
CLS

ECHO  ________       _______       ________      _______       ________       ___      _________     ___    ___ 
ECHO ^|\   ____\     ^|\  ___ \     ^|\   __  \    ^|\  ___ \     ^|\   ___  \    ^|\  \    ^|\___   ___\  ^|\  \  /  /^|
ECHO \ \  \___^|_    \ \   __/^|    \ \  \^|\  \   \ \   __/^|    \ \  \\ \  \   \ \  \   \^|___ \  \_^|  \ \  \/  / /
ECHO  \ \_____  \    \ \  \_^|/__   \ \   _  _\   \ \  \_^|/__   \ \  \\ \  \   \ \  \       \ \  \    \ \    / / 
ECHO   \^|____^|\  \    \ \  \_^|\ \   \ \  \\  \^|   \ \  \_^|\ \   \ \  \\ \  \   \ \  \       \ \  \    \/  /  /  
ECHO     ____\_\  \    \ \_______\   \ \__\\ _\    \ \_______\   \ \__\\ \__\   \ \__\       \ \__\ __/  / /    
ECHO    ^|\_________\    \^|_______^|    \^|__^|\^|__^|    \^|_______^|    \^|__^| \^|__^|    \^|__^|        \^|__^|^|\___/ /     
ECHO    \^|_________^|                                                                               \^|___^|/
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.

CALL bin\Special\Functions delay,r,1000
ECHO Starting...
CALL bin\Special\Functions delay,r,1500
CLS

CALL bin\IO\Print colored,black,yellow,"[",0
ECHO | SET /p ".=^!"
CALL bin\IO\Print colored,black,yellow,"]",0
CALL bin\IO\Print colored,black,red," ~",0
ECHO | SET /p .="/"
CALL bin\IO\Print colored,black,bwhite,"START_GAME",0
CALL bin\IO\Print colored,black,bwhite,".BAT",0
CALL bin\Special\Functions delay,r,500
CALL bin\IO\Print colored,black,gray," system.ACTION.EXECUTE",1
ECHO.
CALL bin\Special\Functions delay,r,500

CALL bin\Special\Functions delay,r,500

CALL bin\IO\Print slowecho,"efiboot loading from device",0
ECHO Acpi(devhd0,0)/PCI(SATA0, system.DRIVE.MASTER)/PCI(0^|0)/SATA1
ECHO.

CALL bin\IO\Print slowecho,"Reading boot instructions",0
CALL bin\Special\Functions delay,r,1500
ECHO | SET /p ".=| "
CALL bin\IO\Print colored,black,aqua,"EFI Loader",0
ECHO | SET /p ".=, boot file: ~/%boot_path%/bootimgfv001.efi"
ECHO.
CALL bin\Special\Functions delay,r,3000

CALL bin\Special\Functions random,count,5,10
FOR /L %%i IN (1,1,%count%) DO (
	CALL bin\Special\Functions random,multiplier,1,100
	CALL bin\Special\Functions repeatString,str,".",!multiplier!
	ECHO !str!
)
ECHO.
FOR /F "tokens=*" %%l IN (bin\Sugar\core_instructions) DO (
	CALL bin\IO\Print tty_info,gray,gray,asm,"%%l",1
)
ECHO.
FOR /L %%k IN (1,1,2) DO (
	FOR /L %%i IN (1,1,5) DO (
		CALL bin\Special\Functions repeatString,str,".",50
		ECHO !str!
	)
	ECHO.
)
FOR /L %%i IN (1,1,10) DO (
	CALL bin\Special\Functions delay,r,100
	ECHO.
)

FOR /F "tokens=*" %%l IN (bin\Sugar\serenity_core) DO (
	CALL bin\Special\Functions delay,r,10
	ECHO [core] %%l
)
ECHO.
FOR /F "tokens=*" %%l IN (bin\Sugar\serenity_debug) DO (
	CALL bin\Special\Functions delay,r,10
	ECHO [debug] %%l
)
ECHO.
FOR /F "tokens=*" %%l IN (bin\Sugar\serenity_config) DO (
	CALL bin\Special\Functions delay,r,10
	ECHO [config] %%l
)
CALL bin\Special\Functions delay,r,1000
ECHO.

FOR /L %%p IN (1,1,1) DO (
	FOR /L %%c IN (1,1,12) DO (
		CALL bin\Special\Functions delay,r,10
		CALL bin\Special\Functions hex_rand,hex,3,1
		ECHO [hardware] Phs_x CPU/%%p: ProcessorId=%%c LocalCPU_ID=0xf!hex! Enabled Starting---
	)
	ECHO.
)

COLOR 08
CALL bin\Special\Functions delay,r,500
COLOR 07
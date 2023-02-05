@echo off
TITLE DayZ SA Server - Status
    :: _______________________________________________________________
    SET SteamLogin=YOUR_STEAM_USERNAME YOUR_STEAM_PASSWORD                      <<-- EDIT (Then remove ALL of these edit texts)
    SET DayZBranch=223350
    SET DayZServerPath="C:\SteamCMD\SERVER\DayZ"		    		<<-- EDIT (Location of your SteamCMD DayZ installation)
    SET SteamCMDPath="C:\SteamCMD"			        	    	<<-- EDIT (Location of your SteamCMD installation)
    SET BECPath="C:\SteamCMD\SERVER\DayZ\BEC"			    		<<-- EDIT (Location of your BEC (if used? I do not))
    SET SteamWorkshopFolder=C:\SteamCMD\steamapps\workshop			<<-- EDIT (Location of your Steam Workshop Folder - NOTE: No speechmarks on THIS item..)
    SET DayZModList=(C:\SteamCMD\SERVER\DayZ\Modlist.txt)			<<-- EDIT (Location of your Modlist file, NOTE brackets INSTEAD of speechmarks on this)
    SET SteamCMDWorkshopPath="C:\SteamCMD\steamapps\workshop\content\221100"
    SET SteamCMDDelay=5
    :: SETlocal EnableDelayedExpansion                                          <<-- EDIT (This line is not need unless you'are running DayZ Expansion)
    :: _______________________________________________________________
GOTO checkServer

:checkServer
echo.
echo Checking server is still running...
echo.
tasklist /fi "imagename eq DayZServer_x64.exe">NUL | find /i /n "DayZServer_x64.exe">NUL
if "%ERRORLEVEL%"=="0" goto loopServer
echo.
time /T
echo Server is not running, taking care of it..
GOTO killServer

:loopServer
:: *** CHANGE THE 30 BELOW TO ALTER THE DELAY IN CHECKING IF THE SERVER IS STILL RUNNING ***
:: *****************************************************************************************
FOR /L %%s IN (30,-1,0) DO (
    echo Server is running. Checking again in %%s seconds.. 
    timeout 1 >nul
)
GOTO checkServer

:killServer
taskkill /f /im DayZServer_x64.exe
::taskkill /im bec.exe								<<-- Commented out, uncomment and remove this statement if using BEC
::taskkill /im dzsalauncher.exe                                                 <<-- Same (Uncomment) if you are running the DayZ SA launcher
GOTO updateServer

:updateServer
echo.
echo.
echo **********************************************
echo **                                          **
echo ** CHECK FOR GAME UPDATES? (Default is YES) **
echo **                                          **
echo **********************************************
echo.
choice /C YN /T 5 /D Y
echo.
IF "%ERRORLEVEL%" == "2" GOTO updateMods
IF "%ERRORLEVEL%" == "1" GOTO gameUpdate
GOTO updateServer

:gameUpdate
echo.
echo Updating DayZ SA Server in 3.
timeout 1 >nul
echo.
echo Updating DayZ SA Server in 2..
timeout 1 >nul
echo.
echo Updating DayZ SA Server in 1...
cd "%SteamCMDPath%"
steamcmd.exe +force_install_dir %DayZServerPath% +quit
steamcmd.exe +login %SteamLogin% +"app_update %DayZBranch%" +quit
GOTO updateMods

:startServer
:: *** MAKES BACKUP FILES ***
:: **************************
xcopy %DayZServerPath%\serverDZ.cfg %DayZServerPath%\serverDZ.trm /y
xcopy %DayZServerPath%\mpmissions\dayzOffline.chernarusplus\cfgeventspawns.xml %DayZServerPath%\mpmissions\dayzOffline.chernarusplus\cfgeventspawns.trm /y
xcopy %DayZServerPath%\mpmissions\dayzOffline.chernarusplus\cfgspawnabletypes.xml %DayZServerPath%\mpmissions\dayzOffline.chernarusplus\cfgspawnabletypes.trm /y
xcopy %DayZServerPath%\mpmissions\dayzOffline.chernarusplus\cfggameplay.json %DayZServerPath%\mpmissions\dayzOffline.chernarusplus\cfggameplay.trm /y
xcopy %DayZServerPath%\mpmissions\dayzOffline.chernarusplus\mapgroupproto.xml %DayZServerPath%\mpmissions\dayzOffline.chernarusplus\mapgroupproto.trm /y
xcopy %DayZServerPath%\mpmissions\dayzOffline.chernarusplus\cfgeconomycore.xml %DayZServerPath%\mpmissions\dayzOffline.chernarusplus\cfgeconomycore.trm /y
xcopy %DayZServerPath%\mpmissions\dayzOffline.chernarusplus\cfgeventspawns.xml %DayZServerPath%\mpmissions\dayzOffline.chernarusplus\cfgeventspawns.trm /y
xcopy %DayZServerPath%\mpmissions\dayzOffline.chernarusplus\db\events.xml %DayZServerPath%\mpmissions\dayzOffline.chernarusplus\db\events.trm /y
xcopy %DayZServerPath%\mpmissions\dayzOffline.chernarusplus\db\messages.xml %DayZServerPath%\mpmissions\dayzOffline.chernarusplus\db\messages.trm /y
xcopy %DayZServerPath%\mpmissions\dayzOffline.chernarusplus\db\types.xml %DayZServerPath%\mpmissions\dayzOffline.chernarusplus\db\types.trm /y
:: *** THE BELOW THREE LINES ARE ONLY FOR DAYZ EXPANSION ***
:: *********************************************************
:: xcopy %DayZServerPath%\mpmissions\dayzOffline.chernarusplus\expansion_ce\expansion_events.xml %DayZServerPath%\mpmissions\dayzOffline.chernarusplus\expansion_ce\expansion_events.trm /y
:: xcopy %DayZServerPath%\mpmissions\dayzOffline.chernarusplus\expansion_ce\expansion_spawnabletypes.xml %DayZServerPath%\mpmissions\dayzOffline.chernarusplus\expansion_ce\expansion_spawnabletypes.trm /y
:: xcopy %DayZServerPath%\mpmissions\dayzOffline.chernarusplus\expansion_ce\expansion_types.xml %DayZServerPath%\mpmissions\dayzOffline.chernarusplus\expansion_ce\expansion_types.trm /y
echo.
echo.
echo Starting DayZ SA Server in 3.
timeout 1 >nul
echo.
echo Starting DayZ SA Server in 2..
timeout 1 >nul
echo.
echo Starting DayZ SA Server in 1...
cd "%DayZServerPath%"
time /T
:: *********************************************************************************************************************************************************
::										vv-- You will DEFINATELY need to ammend the below start DayZ server settings
:::                                           Port number will probably be the same however mods definately will not be the same
::
DayZServer_x64.exe -config=serverDZ.cfg -port=2302 --dologs -adminlog -netlog -freezecheck -profiles=C:\SteamCMD\SERVER\DayZ\DayZServerprofiles "-mod=@CF;@VPPAdminTools;@DayZ-Expansion-Licensed;@DayZ-Expansion-Core;@DayZ-Expansion-Vehicles;@Dabs Framework;@Sleeping Pills (Diazepam);@DayZ-Expansion-Animations;@RedFalcon Mosquito Mk III;@BoomLay's Things"
:: *********************************************************************************************************************************************************
GOTO checkServer
 
:updateMods
echo.
echo *********************************************
echo **                                         **
echo ** CHECK FOR MOD UPDATES? (Default is YES) **
echo **                                         **
echo *********************************************
echo.
choice /C YN /T 5 /D Y
echo.
IF "%ERRORLEVEL%" == "2" GOTO startServer
IF "%ERRORLEVEL%" == "1" GOTO modUpdates
GOTO updateMods

:modUpdates
echo Updating DayZ Mods in 3.
timeout 1 >nul
echo.
echo Updating DayZ Mods in 2..
timeout 1 >nul
echo.
echo Updating DayZ Mods in 1...
echo.
echo.
echo Removing Any Workshop Leftovers...
:: *******************************************************************************************
:: Deleting Steam workshop folder as left over reminates have been know to cause the error;
:: CWorkThreadPool::~CWorkThreadPool: work processing queue not empty: x items discarded
::
cd %SteamWorkshopFolder%
rd /S /Q %SteamWorkshopFolder%
::
:: Because we're in the actual folder, we cannot remove the workshop folder using the rd 
:: command, we cannot surpress/hide its error with > nul, However, it's Okay, it does the job.
:: *******************************************************************************************
echo.
@ timeout 1 >nul
cd %SteamWorkshopFolder%
rd /S /Q %SteamWorkshopFolder%
echo.
echo Updating Steam Workshop Mods...
@ timeout 1 >nul
cd\
cd %SteamCMDPath%
for /f "tokens=1,2 delims=," %%g in %DayZModList% do steamcmd.exe +login %SteamLogin% +workshop_download_item 221100 "%%g" +quit
echo.
echo.
echo Steam Workshop files are up-to-date! Syncing Workshop source with server destination...
@ timeout 2 >nul
:: *** COPYING NEW MODS OVER HERE ***
:: **********************************
@ for /f "tokens=1,2 delims=," %%g in %DayZModList% do robocopy "%SteamCMDWorkshopPath%\%%g" "%DayZServerPath%\%%h" *.* /mir
@ for /f "tokens=1,2 delims=," %%g in %DayZModList% do forfiles /p "%DayZServerPath%\%%h" /m *.bikey /s /c "cmd /c copy @path %DayZServerPath%\keys"
timeout 5 >nul
GOTO startServer

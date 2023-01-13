:: ********************************************************************************************
:: YOU WILL MANUALLY NEED TO COPY THE FILES BELOW, ONLY ONCE.. BUT BEFORE USING THIS BATCHFILE!
:: ********************************************************************************************
:: This is in order to keep your 'modified' files in exactly the way you want them. It has been known for DayZ updates to reset your file ammendments.
:: I have not specified your exact DayZ path, for instance mine is C:\SteamCMD\Server\Dayz however yours may not be the same. Substitute your correct path 
:: and make copies of these essential 10-13 files. Then this batchfile will copy them back over before starting your DayZ server, thus preserving any changes.
:: Should you ever need to edit any of these files, just edit the .BAK file and your server will automatically implement it upon next restart.
::
:: copy \DayZ\serverDZ.cfg to \DayZ\serverDZ.bak
:: copy \DayZ\mpmissions\dayzOffline.chernarusplus\cfgeventspawns.xml		to \DayZ\mpmissions\dayzOffline.chernarusplus\cfgeventspawns.bak
:: copy \DayZ\mpmissions\dayzOffline.chernarusplus\cfgspawnabletypes.xml 	to \DayZ\mpmissions\dayzOffline.chernarusplus\cfgspawnabletypes.bak
:: copy \DayZ\mpmissions\dayzOffline.chernarusplus\cfggameplay.json		to \DayZ\mpmissions\dayzOffline.chernarusplus\cfggameplay.bak
:: copy \DayZ\mpmissions\dayzOffline.chernarusplus\mapgroupproto.xml 		to \DayZ\mpmissions\dayzOffline.chernarusplus\mapgroupproto.bak
:: copy \DayZ\mpmissions\dayzOffline.chernarusplus\db\events.xml 		to \DayZ\mpmissions\dayzOffline.chernarusplus\db\events.bak
:: copy \DayZ\mpmissions\dayzOffline.chernarusplus\db\messages.xml 		to \DayZ\mpmissions\dayzOffline.chernarusplus\db\messages.bak
:: copy \DayZ\mpmissions\dayzOffline.chernarusplus\db\types.xml 		to \DayZ\mpmissions\dayzOffline.chernarusplus\db\types.bak
:: copy \DayZ\mpmissions\dayzOffline.chernarusplus\cfgeconomycore.xml 		to \DayZ\mpmissions\dayzOffline.chernarusplus\cfgeconomycore.bak
:: copy \DayZ\mpmissions\dayzOffline.chernarusplus\cfgeventspawns.xml 		to \DayZ\mpmissions\dayzOffline.chernarusplus\cfgeventspawns.bak
:: ******************************** DAYZ EXPANSION (IF APPLICABLE?) ******************************************************************************************************
:: copy \DayZ\mpmissions\dayzOffline.chernarusplus\expansion_ce\expansion_events.xml to \DayZ\mpmissions\dayzOffline.chernarusplus\expansion_ce\expansion_events.bak
:: copy \DayZ\mpmissions\dayzOffline.chernarusplus\expansion_ce\expansion_spawnabletypes.xml to \DayZ\mpmissions\dayzOffline.chernarusplus\expansion_ce\expansion_spawnabletypes.bak
:: copy \DayZ\mpmissions\dayzOffline.chernarusplus\expansion_ce\expansion_types.xml to \DayZ\mpmissions\dayzOffline.chernarusplus\expansion_ce\expansion_types.bak
:: ******************************************************************************************
:: THIS WHOLE SEGMENT CAN THEN BE REMOVED AFTER YOU HAVE MADE YOUR BACKUPS OF THE ABOVE FILES
:: ******************************************************************************************

@echo off
TITLE DayZ SA Server - Status
    :: _______________________________________________________________
    SET SteamLogin=YOUR_STEAM_USERNAME YOUR_STEAM_PASSWORD			<<-- EDIT (Then remove ALL of these edit texts)
    SET DayZBranch=223350
    SET DayZServerPath="C:\SteamCMD\SERVER\DayZ"				<<-- EDIT (Location of your SteamCMD DayZ installation)
    SET SteamCMDPath="C:\SteamCMD"						<<-- EDIT (Location of your SteamCMD installation)
    SET BECPath="C:\SteamCMD\SERVER\DayZ\BEC"					<<-- EDIT (Location of your BEC (if used? I do not))
    SET SteamWorkshopFolder=C:\SteamCMD\steamapps\workshop			<<-- EDIT (Location of your Steam Workshop Folder - NOTE: No speechmarks on THIS item..)
    SET DayZModList=(C:\SteamCMD\SERVER\DayZ\Modlist.txt)			<<-- EDIT (Location of your Modlist file, NOTE brackets INSTEAD of speechmarks on this)
    SET SteamCMDWorkshopPath="C:\SteamCMD\steamapps\workshop\content\221100"
    SET SteamCMDDelay=5
    SETlocal EnableDelayedExpansion						<<-- EDIT (This line is not need unless you'are running DayZ Expansion)
    :: _______________________________________________________________
GOTO checkServer

:checkServer
echo.
time /t
echo Checking your DayZ server is still running...
echo.
tasklist /fi "imagename eq DayZServer_x64.exe">NUL | find /i /n "DayZServer_x64.exe">NUL
if "%ERRORLEVEL%"=="0" goto loopServer
echo.
echo -XX- DayZ Server not found.. automatically restarting it now.. -XX-
GOTO killServer

:loopServer
FOR /L %%s IN (30,-1,0) DO (
    echo Server is running. Checking again in %%s seconds.. 
    timeout 1 >nul
)
GOTO checkServer

:killServer
taskkill /f /im DayZServer_x64.exe
::taskkill /im bec.exe								<<-- Commented out, uncomment and remove this statement if using BEC
GOTO updateServer

:updateServer
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
:: *****************************************************
:: *** vv THIS CHECKS FOR UPDATES TO DAYZ ITSELF  vv ***
steamcmd.exe +login %SteamLogin% +"app_update %DayZBranch%" +quit
GOTO updateMods

:startServer
:: *** COPIES BACKUP FILES OVER ORIGINALS ***
:: ******************************************
xcopy %DayZServerPath%\serverDZ.bak %DayZServerPath%\serverDZ.cfg /y
xcopy %DayZServerPath%\mpmissions\dayzOffline.chernarusplus\cfgeventspawns.bak %DayZServerPath%\mpmissions\dayzOffline.chernarusplus\cfgeventspawns.xml /y
xcopy %DayZServerPath%\mpmissions\dayzOffline.chernarusplus\cfgspawnabletypes.bak %DayZServerPath%\mpmissions\dayzOffline.chernarusplus\cfgspawnabletypes.xml /y
xcopy %DayZServerPath%\mpmissions\dayzOffline.chernarusplus\cfggameplay.bak %DayZServerPath%\mpmissions\dayzOffline.chernarusplus\cfggameplay.json /y
xcopy %DayZServerPath%\mpmissions\dayzOffline.chernarusplus\mapgroupproto.bak %DayZServerPath%\mpmissions\dayzOffline.chernarusplus\mapgroupproto.xml /y
xcopy %DayZServerPath%\mpmissions\dayzOffline.chernarusplus\cfgeconomycore.bak %DayZServerPath%\mpmissions\dayzOffline.chernarusplus\cfgeconomycore.xml /y
xcopy %DayZServerPath%\mpmissions\dayzOffline.chernarusplus\cfgeventspawns.bak %DayZServerPath%\mpmissions\dayzOffline.chernarusplus\cfgeventspawns.xml /y
xcopy %DayZServerPath%\mpmissions\dayzOffline.chernarusplus\db\events.bak %DayZServerPath%\mpmissions\dayzOffline.chernarusplus\db\events.xml /y
xcopy %DayZServerPath%\mpmissions\dayzOffline.chernarusplus\db\messages.bak %DayZServerPath%\mpmissions\dayzOffline.chernarusplus\db\messages.xml /y
xcopy %DayZServerPath%\mpmissions\dayzOffline.chernarusplus\db\types.bak %DayZServerPath%\mpmissions\dayzOffline.chernarusplus\db\types.xml /y
xcopy %DayZServerPath%\mpmissions\dayzOffline.chernarusplus\expansion_ce\expansion_events.bak %DayZServerPath%\mpmissions\dayzOffline.chernarusplus\expansion_ce\expansion_events.xml /y
xcopy %DayZServerPath%\mpmissions\dayzOffline.chernarusplus\expansion_ce\expansion_spawnabletypes.bak %DayZServerPath%\mpmissions\dayzOffline.chernarusplus\expansion_ce\expansion_spawnabletypes.xml /y
xcopy %DayZServerPath%\mpmissions\dayzOffline.chernarusplus\expansion_ce\expansion_types.bak %DayZServerPath%\mpmissions\dayzOffline.chernarusplus\expansion_ce\expansion_types.xml /y
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
::
DayZServer_x64.exe -config=serverDZ.cfg -port=2302 --dologs -adminlog -netlog -freezecheck -profiles=C:\SteamCMD\SERVER\DayZ\DayZServerprofiles "-mod=@CF;@VPPAdminTools;@DayZ-Expansion-Licensed;@DayZ-Expansion-Core;@DayZ-Expansion-Vehicles;@Dabs Framework;@Sleeping Pills (Diazepam);@DayZ-Expansion-Animations;@RedFalcon Mosquito Mk III;@BoomLay's Things"
:: *********************************************************************************************************************************************************
GOTO checkServer
 
:updateMods
echo.
FOR /L %%s IN (%SteamCMDDelay%,-1,0) DO (
    echo Checking for mod updates in %%s seconds.. 
    timeout 1 >nul
)
echo Removing Any Workshop Leftovers...
@ timeout 1 >nul
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
echo Updating Steam Workshop Mods...
::
:: *** UPDATING YOUR DAYZ MODS HERE ***
:: ************************************
@ timeout 1 >nul
cd\
cd %SteamCMDPath%
for /f "tokens=1,2 delims=," %%g in %DayZModList% do steamcmd.exe +login %SteamLogin% +workshop_download_item 221100 "%%g" +quit
echo.
echo.
echo Steam Workshop files are up-to-date! Syncing Workshop source with server destination...
::
:: *** COPYING NEW MODS OVER HERE ***
:: **********************************
@ timeout 2 >nul
@ for /f "tokens=1,2 delims=," %%g in %DayZModList% do robocopy "%SteamCMDWorkshopPath%\%%g" "%DayZServerPath%\%%h" *.* /mir
@ for /f "tokens=1,2 delims=," %%g in %DayZModList% do forfiles /p "%DayZServerPath%\%%h" /m *.bikey /s /c "cmd /c copy @path %DayZServerPath%\keys"
timeout 5 >nul
GOTO startServer

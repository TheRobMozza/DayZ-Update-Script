# DayZ-Update-Script
All well and good having a self hosted DayZ server.. BUT we need to address the sticky subject of 'automated' updates for both Dayz itself and for any mods that you may be running.

## Automation

To sucessfully automate your self hosted DayZ server you will need firstly, to set your Windows to log in automatically. This can be achieved in several ways listed here;

Windows 10 - https://windowsreport.com/auto-login-windows-10/

Windows 11 - https://windowsreport.com/windows-11-auto-login/

Once your Windows is auto logged in, I suggest for you to right click on your Start-DayZ-Server batchfile and click 'Send To' then Desktop (Create shortcut) and then drag you're newly created shortcut into your Start Folder. This way if you get an 'urgent' Windows update, that restarts your server, at least your DayZ server will come back up after Windows reboots.


## Updates

There are many 'DayZ automatic update scripts' here on GitHub and I started using one, modifying it to suit my own needs. Customising it and yes it worked for a short amount of time. Something then must of changed in DayZ, as unfortunately it then just stopped updating. So I've trial'ed and error'ed my own variant, which is working 13/01/2023 and hopefully for a fair amount of time going forward as well!


## Editing the Start-Day-Server.bat

As per the instructions in the file, there are a number of prerequisites. 

(i) Making copies of your important files.

(ii) Adding your own server details (in the lined section)

Once completed you should have a sucessfully updating DayZ batchfile. Feel free to modify/alter to suit you're own requirments.

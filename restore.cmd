@ECHO OFF
TITLE restore C's pc

ECHO hello me (probably) so we're setting up a new pc again huh well let's do some check🤨
ECHO is this windows?
C:\Windows\System32>systeminfo | findstr /RBC:^OS

ECHO checking for powershell?
FOR /F "tokens=*" %g IN ('where pwsh') do (SET VAR=%g)
IF

curl.exe get.scoop.sh
ECHO Congratulations! Your first batch file was executed successfully.
PAUSE
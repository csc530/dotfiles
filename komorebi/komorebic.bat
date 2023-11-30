@REM https://github.com/LGUG2Z/komorebi/issues/161#issuecomment-1166901548
@echo off
title startup script
@REM nircmd win hide title "startup script"
komorebic start

:: "komorebic start" currently is not waiting for everything be ready before return, so the
:: following lines prevent running commands bellow on startup before komorebi is ready to accept them
:wait_komorebi
komorebic state >nul 2>&1 || goto wait_komorebi

@REM <your config, rules, etc>
komorebic watch-configuration enable
@REM komorebic invisible-borders 7 0 14 7
@REM komorebic float-rule class WixStdBA
@REM komorebic float-rule class MsiDialogCloseClass
@REM ...

:: optional, if you want to keep this script running for some reason
:: e.g.: I use this to auto restart my startup script if komorebi exit
@REM nircmd waitprocess komorebi.exe
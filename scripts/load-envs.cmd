@REM https://stackoverflow.com/questions/232747/read-environment-variables-from-file-in-windows-batch-cmd-exe

@REM Load environment variables from file
@REM  $1: file path

for /F "delims== tokens=1,* eol=#" %%i in (%1) do set %%i=%%~j

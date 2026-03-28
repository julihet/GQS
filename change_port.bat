@echo off
REM Windows equivalent of change_port.sh
REM Usage: change_port.bat <filename> <bolt_port> <http_port>

if "%~3"=="" (
    echo Usage: %~0 ^<filename^> ^<bolt_port^> ^<http_port^>
    exit /b 1
)

set "filename=%~1"
set "port_number=%~2"
set "web_number=%~3"

if not exist "%filename%" (
    echo File '%filename%' does not exist.
    exit /b 1
)

powershell -NoProfile -Command "(Get-Content '%filename%') -replace '___PORT___1','%port_number%' -replace '___PORT___2','%web_number%' | Set-Content '%filename%'"

@ECHO off
CLS

.\bin\x4w-compiler.exe .\x4w-build.json
IF %ERRORLEVEL% NEQ 0 GOTO END

dotnet serve -d docs --default-extensions:html -o

:END
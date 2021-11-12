@ECHO off
CLS

REM -- Restore dotnet tools
dotnet tool restore

REM -- Compile site
dotnet x4w-compiler x4w-build.json
IF %ERRORLEVEL% NEQ 0 GOTO END

REM -- Run local server
dotnet serve -d:docs --default-extensions:html -o

:END
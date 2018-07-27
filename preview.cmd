@ECHO off
CLS

dotnet run --framework netcoreapp2.1 --project ..\XML4web\Altairis.Xml4web.Compiler . -- .\build.json
IF %ERRORLEVEL% NEQ 0 GOTO END

dotnet serve -d docs --default-extensions:html -o

:END
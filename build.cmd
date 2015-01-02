@echo off
setlocal

set BUILDSTAGE=build-stage
set NUGETPATH=%BUILDSTAGE%\.nuget
set NUGET=%NUGETPATH%\nuget.exe
set PACKAGESPATH=%NUGETPATH%\packages

:BUILD_CHECK_0
    call e5r 1> nul
    if "%ERRORLEVEL%"=="0" goto NUGET_DOWNLOAD

:E5R_INSTALL
    call bitsadmin /TRANSFER "Installing E5R Environment..." ^
        "http://e5r.github.io/env/dist/e5r-install.cmd" ^
        "%CD%\e5r-install.cmd"
    call e5r-install.cmd
    if exist "%CD%\e5r-install.cmd" del /F /Q "%CD%\e5r-install.cmd"

:BUILD_CHECK_1
    call e5r 1> nul
    if "%ERRORLEVEL%"=="0" goto NUGET_DOWNLOAD
    echo.
    echo E5R Environment not installed!
    goto FINISH

:NUGET_DOWNLOAD
    if exist %NUGET% goto BEFORE_BUILD
    echo Downloading NuGet...
    if not exist "%NUGETPATH%" md "%NUGETPATH%"
    @powershell -NoProfile -ExecutionPolicy unrestricted -Command ^
        "$ProgressPreference = 'SilentlyContinue'; Invoke-WebRequest 'https://www.nuget.org/nuget.exe' -OutFile '%NUGET%'"

:BUILD_CHECK_2
    if exist %NUGET% goto BEFORE_BUILD
    echo.
    echo NUGET not installed!
    goto FINISH

:BEFORE_BUILD
    call e5r env boot
    call e5r env install -version "1.0.0-beta1" -runtime CLR -x86
    call e5r env use -version "1.0.0-beta1" -runtime CLR -x86
    call "%NUGET%" install ^
        -OutputDirectory %PACKAGESPATH% ^
        -ExcludeVersion .\packages.config

:BUILD
    call "%PACKAGESPATH%\Sake\tools\sake.exe" ^
        -I ".e5r\build" ^
        -f makefile.shade %*

:FINISH

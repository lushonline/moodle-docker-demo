@ECHO OFF
echo.
echo **************************************************
echo *** Running: %~n0%~x0
echo *** Parameters: %*
echo.
echo *** Moodle Version: %MOODLE_VERSION%
echo.

IF NOT EXIST "%MOODLE_DOCKER_WWWROOT%" (
    ECHO Error: MOODLE_DOCKER_WWWROOT is not set or not an existing directory
    EXIT /B 1
)

PUSHD %cd%
CD %~dp0..
SET BASEDIR=%cd%
POPD
SET ASSETDIR=%BASEDIR%\assets
SET MOODLE_DOCKER_ASSETDIR=%ASSETDIR%

SET COMPOSE_CONVERT_WINDOWS_PATHS=true

SET DOCKERCOMPOSE=docker-compose --project-name "%MOODLE_VERSION%" -f "%BASEDIR%\base.yml"

IF "%MOODLE_DOCKER_WEB_HOST%"=="" (
    SET MOODLE_DOCKER_WEB_HOST=localhost
)

IF "%MOODLE_DOCKER_WEB_PORT%"=="" (
    SET MOODLE_DOCKER_WEB_PORT=8000
)

IF "%MOODLE_UID%"=="" (
    SET MOODLE_UID=1000
)

IF "%MOODLE_GID%"=="" (
    SET MOODLE_GID=1000
)

SET "TRUE="
IF NOT "%MOODLE_DOCKER_WEB_PORT%"=="0" SET TRUE=1
IF DEFINED TRUE (
    SET DOCKERCOMPOSE=%DOCKERCOMPOSE% -f "%BASEDIR%\webserver.port.yml"
)

%DOCKERCOMPOSE% %*

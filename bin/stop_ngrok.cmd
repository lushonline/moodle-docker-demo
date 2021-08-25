@ECHO OFF
setlocal
PUSHD %cd%
CD %~dp0..
SET BASEDIR=%cd%
POPD

echo.
echo **************************************************
echo *** Running: %~n0%~x0
echo *** Parameters: %*
echo.

IF "%MOODLE_VERSION%"=="" (
    echo **************************************************
    echo *** Setting Environment Variables from .env
    echo.
    FOR /F "tokens=*" %%i in ('type %BASEDIR%\.env') do SET %%i
    echo.
    echo **************************************************
    echo.
)

echo *** Moodle Version: %MOODLE_VERSION%
echo.

SET "MOODLE_DOCKER_NGROK_HOST="

echo ***Bring Docker Containers Down
echo.
call bin\moodle-docker-compose down
echo.
echo ***Bring Docker Containers Up
echo.
call bin\moodle-docker-compose up -d
echo.
echo *** Moodle is running please. Browse to - http://%MOODLE_DOCKER_WEB_HOST%:%MOODLE_DOCKER_WEB_PORT%
echo.
echo *** Moodle Admin Username: admin
echo *** Moodle Admin password: test
echo.


:FINISH


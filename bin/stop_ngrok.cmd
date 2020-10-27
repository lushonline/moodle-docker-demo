@ECHO OFF

echo.
echo **************************************************
echo *** Running: %~n0%~x0
echo.

PUSHD %cd%
CD %~dp0..
SET BASEDIR=%cd%
POPD


SET "MOODLE_DOCKER_NGROK_HOST="

echo ***Bring Docker Containers Down
echo.
call %BASEDIR%\bin\moodle-docker-compose down
echo.
echo ***Bring Docker Containers Up
echo.
call %BASEDIR%\bin\moodle-docker-compose up -d
echo.
echo *** Moodle is running please. Browse to - http://127.0.0.1:8000
echo.
echo *** Moodle Admin Username: admin
echo *** Moodle Admin password: test
echo.


:FINISH


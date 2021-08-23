@ECHO OFF
IF "%1"=="" (
  IF "%MOODLE_VERSION%"=="" (
    SET "MOODLE_VERSION=MOODLE_311_STABLE"
  )
) ELSE (
  SET "MOODLE_VERSION=%1"
)
SET MOODLE_DOCKER_DB=pgsql
SET MOODLE_DOCKER_PHP_VERSION=7.4

echo.
echo **************************************************
echo *** Running: %~n0%~x0
echo *** Parameters: %*
echo.
echo *** Moodle Version: %MOODLE_VERSION%
echo *** Moodle DB: %MOODLE_DOCKER_DB%
echo *** Moodle PHP: %MOODLE_DOCKER_PHP_VERSION%
echo.

PUSHD %cd%
CD %~dp0..
SET BASEDIR=%cd%
POPD
SET MOODLE_DOCKER_WWWROOT=%BASEDIR%\assets\moodle_%MOODLE_VERSION%
SET MOODLE_DOCKER_MOODLEDATA=%BASEDIR%\assets\moodledata_%MOODLE_VERSION%
SET MOODLE_DOCKER_MODULES=%BASEDIR%\assets\moodle_modules

START ngrok http --config .\ngrok.yml http://127.0.0.1:8000

TIMEOUT /T 5 /NOBREAK

For /F "Delims=" %%A In ('"curl -s http://localhost:4545/api/tunnels/command_line | jq-win64 .public_url"') Do Set "MOODLE_DOCKER_NGROK_HOST=%%~A"

IF NOT "%MOODLE_DOCKER_NGROK_HOST%"=="" (
    echo.
    echo ***Bring Docker Containers Down
    echo.
    call %BASEDIR%\bin\moodle-docker-compose down
    echo.
    echo ***Bring Docker Containers Up
    echo.
    call %BASEDIR%\bin\moodle-docker-compose up -d
    echo.
    echo.
    echo *** Moodle is available via NGROK. Browse to - %MOODLE_DOCKER_NGROK_HOST%
    echo.
    echo *** Moodle Admin Username: admin
    echo *** Moodle Admin password: test
    echo.
    GOTO FINISH
)

:PROBLEM
echo.
echo *** There was a problem setting up NGROK

:FINISH

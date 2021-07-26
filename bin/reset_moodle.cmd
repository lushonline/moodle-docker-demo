@ECHO OFF
IF "%1"=="" (
  IF "%MOODLE_VERSION%"=="" (
    SET "MOODLE_VERSION=MOODLE_310_STABLE"
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

echo *** IMPORTANT THIS COMMAND WILL REMOVE MOODLE THIS IS IRREVERSIBLE
echo *** Press CTRL+C to cancel
echo.
pause
echo.

FOR /F %%i IN ('cd') DO set CURRENTFOLDER=%%~nxi

PUSHD %cd%
CD %~dp0..
SET BASEDIR=%cd%
POPD
SET MOODLE_DOCKER_WWWROOT=%BASEDIR%\assets\moodle_%MOODLE_VERSION%
SET MOODLE_DOCKER_MOODLEDATA=%BASEDIR%\assets\moodledata_%MOODLE_VERSION%
SET MOODLE_DOCKER_MODULES=%BASEDIR%\assets\moodle_modules

echo.
echo *** Bring down the Docker containers
echo.
call %BASEDIR%\bin\moodle-docker-compose down
echo.

echo *** Removing docker volume: %CURRENTFOLDER%_pgdata
docker volume rm %CURRENTFOLDER%_pgdata
echo.

echo *** Removing moodledata folder: %MOODLE_DOCKER_MOODLEDATA%
echo *** This may take sometime
rmdir /S /Q %MOODLE_DOCKER_MOODLEDATA%
echo.

echo *** Removing moodle folder: %MOODLE_DOCKER_WWWROOT%
echo *** This may take sometime
rmdir /S /Q %MOODLE_DOCKER_WWWROOT%
echo.

echo *** Removing moodle folder: %MOODLE_DOCKER_MODULES%
echo *** This may take sometime
rmdir /S /Q %MOODLE_DOCKER_MODULES%
echo.

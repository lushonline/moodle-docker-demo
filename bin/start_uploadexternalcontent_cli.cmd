@ECHO OFF
:: the first parameter is an optional filename
IF "%1"=="" ( SET "MOODLE_UPLOAD_FILE=uploadexternalcontent.csv" ) ELSE ( SET "MOODLE_UPLOAD_FILE=%1" )
:: the second parameter is an optional categoryid
IF "%2"=="" ( SET "MOODLE_UPLOAD_CATEGORYID=1" ) ELSE ( SET "MOODLE_UPLOAD_CATEGORYID=%2" )
SET MOODLE_VERSION=MOODLE_39_STABLE
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
echo *** Moodle Upload File: %MOODLE_UPLOAD_FILE%
echo *** Moodle Upload Category Id: %MOODLE_UPLOAD_CATEGORYID%
echo *** Moodle CLI Script: admin/tool/uploadexternalcontent/cli/uploadexternalcontent.php
echo.

PUSHD %cd%
CD %~dp0..
SET BASEDIR=%cd%
POPD
SET MOODLE_DOCKER_WWWROOT=%BASEDIR%\assets\moodle_%MOODLE_VERSION%
SET MOODLE_DOCKER_MOODLEDATA=%BASEDIR%\assets\moodledata_%MOODLE_VERSION%
SET MOODLE_DOCKER_MODULES=%BASEDIR%\assets\moodle_modules

:: Get the rest of the optional command line after first 5 arguments
SHIFT
SHIFT
SHIFT
SHIFT
SHIFT
SET OTHEROPTIONS=%1

echo.
call %BASEDIR%\bin\moodle-docker-compose exec webserver php admin/tool/uploadexternalcontent/cli/uploadexternalcontent.php --source=../../../../%MOODLE_UPLOAD_FILE% --categoryid=%MOODLE_UPLOAD_CATEGORYID% %OTHEROPTIONS%
echo.
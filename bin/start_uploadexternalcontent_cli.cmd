@ECHO OFF
:: the first parameter is an optional filename
IF "%1"=="" ( SET "MOODLE_UPLOAD_FILE=uploadexternalcontent.csv" ) ELSE ( SET "MOODLE_UPLOAD_FILE=%1" )
:: the second parameter is an optional categoryid
IF "%2"=="" ( SET "MOODLE_UPLOAD_CATEGORYID=1" ) ELSE ( SET "MOODLE_UPLOAD_CATEGORYID=%2" )

echo.
echo **************************************************
echo *** Running: %~n0%~x0
echo *** Parameters: %*
echo.
echo *** Moodle Upload File: %MOODLE_UPLOAD_FILE%
echo *** Moodle Upload Category Id: %MOODLE_UPLOAD_CATEGORYID%
echo *** Moodle CLI Script: admin/tool/uploadexternalcontent/cli/uploadexternalcontent.php
echo.

:: Get the rest of the optional command line after first 4 arguments
SHIFT
SHIFT
SHIFT
SHIFT
SET OTHEROPTIONS=%1

echo.
call bin\moodle-docker-compose exec webserver php admin/tool/uploadexternalcontent/cli/uploadexternalcontent.php --source=../../../../%MOODLE_UPLOAD_FILE% --categoryid=%MOODLE_UPLOAD_CATEGORYID% %OTHEROPTIONS%
echo.
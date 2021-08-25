@ECHO OFF
IF "%1"=="" ( SET "MOODLE_UPLOAD_COMPLETIONFILE=uploadpageresults.csv" ) ELSE ( SET "MOODLE_UPLOAD_COMPLETIONFILE=%1" )

echo.
echo **************************************************
echo *** Running: %~n0%~x0
echo *** Parameters: %*
echo.
echo *** Moodle Upload File: %MOODLE_UPLOAD_FILE%
echo *** Moodle Upload Category Id: %MOODLE_UPLOAD_CATEGORYID%
echo *** Moodle CLI Script: admin/tool/uploadpageresults/cli/uploadpageresults.php
echo.

:: Get the rest of the optional command line after first 3 arguments
SHIFT
SHIFT
SHIFT
SET OTHEROPTIONS=%1

echo.
call %BASEDIR%\bin\moodle-docker-compose exec webserver php admin/tool/uploadpageresults/cli/uploadpageresults.php --source=../../../../%MOODLE_UPLOAD_COMPLETIONFILE% %OTHEROPTIONS%
echo.
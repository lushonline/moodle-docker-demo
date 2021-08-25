@ECHO OFF
:: the second parameter is an optional filename
IF "%1"=="" ( SET "MOODLE_UPLOAD_COMPLETIONFILE=uploadexternalcontentresults.csv" ) ELSE ( SET "MOODLE_UPLOAD_COMPLETIONFILE=%1" )

echo.
echo **************************************************
echo *** Running: %~n0%~x0
echo *** Parameters: %*
echo.
echo *** Moodle Upload File: %MOODLE_UPLOAD_COMPLETIONFILE%
echo *** Moodle CLI Script: admin/tool/uploadexternalcontentresults/cli/uploadexternalcontentresults.php
echo.

:: Get the rest of the optional command line after first argument
SHIFT
SET OTHEROPTIONS=%1

echo.
call bin\moodle-docker-compose exec webserver php admin/tool/uploadexternalcontentresults/cli/uploadexternalcontentresults.php --source=../../../../%MOODLE_UPLOAD_COMPLETIONFILE% %OTHEROPTIONS%
echo.
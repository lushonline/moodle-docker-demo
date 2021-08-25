@ECHO OFF
echo.
echo **************************************************
echo *** Running: %~n0%~x0
echo *** Parameters: %*
echo.

echo *** Run the Moodle CLI script: admin/cli/cron.php
echo.
call bin\moodle-docker-compose exec webserver php admin/cli/cron.php
echo.
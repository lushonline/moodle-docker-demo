@ECHO OFF
echo.
echo **************************************************
echo *** Running: %~n0%~x0
echo *** Parameters: %*
echo.

echo *** Run the Moodle CLI script to run Percipio Sync: admin/cli/schedule_task.php --execute=\\\tool_percipioexternalcontentsync\\task\\percipiosync
echo.
call bin\moodle-docker-compose exec webserver php admin/cli/schedule_task.php --execute=\\\tool_percipioexternalcontentsync\\task\\percipiosync
echo.
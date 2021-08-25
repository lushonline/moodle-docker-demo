@ECHO OFF
echo.
echo **************************************************
echo *** Running: %~n0%~x0
echo *** Parameters: %*
echo.

echo *** Run the Moodle CLI script: admin/cli/cfg.php to configure the xapi credentials
call bin/moodle-docker-compose exec webserver php admin/cli/cfg.php --component=externalcontent --name=xapiusername --set=4j09hapVift36ONxYbLDZkRH
call bin/moodle-docker-compose exec webserver php admin/cli/cfg.php --component=externalcontent --name=xapipassword --set=E3dyJMh4xqw9B8u7eikmCKWX

echo *** Run the Moodle CLI script: admin/cli/cfg.php to show the xapi credentials
call bin/moodle-docker-compose exec webserver php admin/cli/cfg.php --component=externalcontent
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
echo.


PUSHD %cd%
CD %~dp0..
SET BASEDIR=%cd%
POPD

echo.
echo *** Bring up the Docker containers
echo.
call %BASEDIR%\bin\moodle-docker-compose up -d
echo.

echo.
echo *** Get Webserver Container ID
echo.
docker container ls -aqf name=webserver > containerid.txt
set /p containerid=<containerid.txt
echo %containerid%

echo.
echo *** Copy extra PHP configuration to webserver
echo.
docker cp docker-php-limits.ini %containerid%:/usr/local/etc/php/conf.d/docker-php-limits.ini
echo.

echo.
echo *** Restart Apache
echo.
call %BASEDIR%\bin\moodle-docker-compose exec webserver bash -c "/etc/init.d/apache2 reload"
echo.

echo.
echo *** Run the Moodle CLI script: admin/cli/install_database.php
echo.
call %BASEDIR%\bin\moodle-docker-compose exec webserver php admin/cli/install_database.php --agree-license --fullname="Docker moodle" --shortname="docker_moodle" --adminpass="test" --adminemail="admin@example.com"
echo.

echo.
echo *** Run the Moodle CLI script: admin/cli/cfg.php to configure the xapi credentials
echo.
call %BASEDIR%\bin\moodle-docker-compose exec webserver php admin/cli/cfg.php --component=externalcontent --name=xapiusername --set=4j09hapVift36ONxYbLDZkRH
call %BASEDIR%\bin\moodle-docker-compose exec webserver php admin/cli/cfg.php --component=externalcontent --name=xapipassword --set=E3dyJMh4xqw9B8u7eikmCKWX
echo.
echo *** Run the Moodle CLI script: admin/cli/cfg.php to show the xapi credentials
echo.
call %BASEDIR%\bin\moodle-docker-compose exec webserver php admin/cli/cfg.php --component=externalcontent
echo.

echo.
echo *** Moodle is running please. Browse to - http://%MOODLE_DOCKER_WEB_PORT%
echo *** Moodle Admin Username: admin
echo *** Moodle Admin password: test
echo.


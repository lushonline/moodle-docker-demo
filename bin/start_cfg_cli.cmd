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
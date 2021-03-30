@ECHO OFF
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
echo.

PUSHD %cd%
CD %~dp0..
SET BASEDIR=%cd%
POPD
SET MOODLE_DOCKER_WWWROOT=%BASEDIR%\assets\moodle_%MOODLE_VERSION%
SET MOODLE_DOCKER_MOODLEDATA=%BASEDIR%\assets\moodledata_%MOODLE_VERSION%
SET MOODLE_DOCKER_MODULES=%BASEDIR%\assets\moodle_modules

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
docker cp docker-php-ext-xdebug-extras.ini %containerid%:/usr/local/etc/php/conf.d/docker-php-ext-xdebug-extras.ini
echo.

echo.
echo *** Restart Apache
echo.
call %BASEDIR%\bin\moodle-docker-compose exec webserver bash -c "/etc/init.d/apache2 reload"
echo.


echo.
echo *** Moodle is running please. Browse to - http://127.0.0.1:8000

IF NOT "%MOODLE_DOCKER_NGROK_HOST%"=="" (
    echo *** Moodle is available via NGROK. Browse to - %MOODLE_DOCKER_NGROK_HOST%
)

echo *** Moodle Admin Username: admin
echo *** Moodle Admin password: test
echo.

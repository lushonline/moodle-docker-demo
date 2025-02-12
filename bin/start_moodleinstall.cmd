@ECHO OFF
setlocal
PUSHD %cd%
CD %~dp0..
SET BASEDIR=%cd%
POPD

echo.
echo **************************************************
echo *** Running: %~n0%~x0
echo *** Parameters: %*
echo.

IF "%MOODLE_VERSION%"=="" (
    echo **************************************************
    echo *** Setting Environment Variables from .env
    echo.
    FOR /F "tokens=*" %%i in ('type %BASEDIR%\.env') do SET %%i
    echo.
    echo **************************************************
    echo.
)

echo *** Moodle Version: %MOODLE_VERSION%
echo.

echo.
echo *** Bring up the Docker containers
echo.
call bin\moodle-docker-compose up -d
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
call bin\moodle-docker-compose exec webserver bash -c "/etc/init.d/apache2 reload"
echo.

echo.
echo *** Run the Moodle CLI script: admin/cli/install_database.php
echo.
call bin\moodle-docker-compose exec webserver php admin/cli/install_database.php --agree-license --fullname="Docker moodle" --shortname="docker_moodle" --adminpass="test" --adminemail="admin@example.com"
echo.

echo.
echo *** Run the start_cfg_cli script
echo.
call bin\start_cfg_cli.cmd
echo.

echo.
echo *** Moodle is running please. Browse to - http://%MOODLE_DOCKER_WEB_HOST%:%MOODLE_DOCKER_WEB_PORT%
echo *** Moodle Admin Username: admin
echo *** Moodle Admin password: test
echo.
endlocal


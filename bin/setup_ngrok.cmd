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

START ngrok http --config .\ngrok.yml http://127.0.0.1:8000

TIMEOUT /T 5 /NOBREAK

For /F "Delims=" %%A In ('"curl -s http://localhost:4545/api/tunnels/command_line | jq-win64 .public_url"') Do Set "MOODLE_DOCKER_NGROK_HOST=%%~A"

IF NOT "%MOODLE_DOCKER_NGROK_HOST%"=="" (
    echo.
    echo ***Bring Docker Containers Down
    echo.
    call bin\moodle-docker-compose down
    echo.
    echo ***Bring Docker Containers Up
    echo.
    call bin\moodle-docker-compose up -d
    echo.
    echo.
    echo "Get Webserver Container ID"
docker container ls -aqf name=webserver > containerid.txt
while read line; do export "containerid=${line}";
done < containerid.txt

echo "Copy extra PHP configuration to webserver"
docker cp "${basedir}/docker-php-limits.ini" "${containerid}:/usr/local/etc/php/conf.d/docker-php-limits.ini"

echo "Restart Apache"
bin/moodle-docker-compose exec webserver bash -c "/etc/init.d/apache2 reload"
    
    echo *** Moodle is available via NGROK. Browse to - %MOODLE_DOCKER_NGROK_HOST%
    echo.
    echo *** Moodle Admin Username: admin
    echo *** Moodle Admin password: test
    echo.
    GOTO FINISH
)

:PROBLEM
echo.
echo *** There was a problem setting up NGROK

:FINISH
endlocal
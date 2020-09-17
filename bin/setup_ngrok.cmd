@ECHO OFF

echo.
echo **************************************************
echo *** Running: %~n0%~x0
echo.

PUSHD %cd%
CD %~dp0..
SET BASEDIR=%cd%
POPD

START ngrok http http://127.0.0.1:8000

TIMEOUT /T 10 /NOBREAK

For /F "Delims=" %%A In ('"curl -s http://localhost:4040/api/tunnels/command_line | jq-win64 .public_url"') Do Set "MOODLE_DOCKER_NGROK_HOST=%%~A"
echo %MOODLE_DOCKER_NGROK_HOST%

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

SET NUL=NUL
IF "%OS%"=="Windows_NT" SET NUL=

IF EXIST "%BASEDIR%\%MOODLE_DOCKER_MOODLEDATA%\%NUL%" GOTO MOODLEMODULESEXISTS
MD %BASEDIR%\%MOODLE_DOCKER_MOODLEDATA%

:MOODLEMODULESEXISTS
IF EXIST "%BASEDIR%\%MOODLE_DOCKER_MODULES%\%NUL%" GOTO MOODLEDATAEXISTS
MD %BASEDIR%\%MOODLE_DOCKER_MODULES%

:MOODLEDATAEXISTS
IF EXIST %BASEDIR%\%MOODLE_DOCKER_WWWROOT%\%NUL% GOTO FETCHMOODLE

:CLONE
echo.
echo *** Cloning Moodle branch: %MOODLE_VERSION%
echo.
call git clone --branch %MOODLE_VERSION% --depth 1 --single-branch https://github.com/moodle/moodle %BASEDIR%\%MOODLE_DOCKER_WWWROOT%
echo.
GOTO FINISH

:FETCHMOODLE
PUSHD %cd%
CD %BASEDIR%\%MOODLE_DOCKER_WWWROOT%
echo.
echo *** Remove all uncommited local files in %MOODLE_DOCKER_WWWROOT%
echo.
call git clean -df
call git clean -df
call git clean -df
echo.
echo *** Reset in %MOODLE_DOCKER_WWWROOT%
echo.
call git reset --hard
echo.
echo *** Fetch any updates from branch %MOODLE_VERSION%
echo.
call git fetch --all
echo.
echo *** Pull from branch %MOODLE_VERSION%
echo.
call git pull
echo.
echo *** Show Git Status
echo.
call git status
echo.
POPD

:FINISH
echo.
echo *** Ensure customized config.php for the Docker containers is in place
echo.
copy  "%BASEDIR%\config.docker-template.php" "%MOODLE_DOCKER_WWWROOT%\config.php"
echo.
pause

echo.
echo *** Ensure moodle files from %BASEDIR%\assets\moodle_files\ are installed
echo.
XCOPY "%BASEDIR%\assets\moodle_files\*" "%MOODLE_DOCKER_WWWROOT%\" /s /i /y
echo.

echo.
echo *** Ensure moodle customaddons are installed
echo.
PUSHD %cd%

:CLONEUPLOADPAGE
IF EXIST %BASEDIR%\%MOODLE_DOCKER_MODULES%\admin\tool\uploadpage\%NUL% GOTO FETCHUPLOADPAGE
echo.
echo *** Cloning moodle-tool_uploadpage
echo.
call git clone https://github.com/lushonline/moodle-tool_uploadpage "%BASEDIR%\%MOODLE_DOCKER_MODULES%\admin\tool\uploadpage\"
echo.
GOTO CLONEUPLOADPAGERESULTS

:FETCHUPLOADPAGE
echo Updating moodle-tool_uploadpage
echo.
echo Fetch https://github.com/lushonline/moodle-tool_uploadpage
CD "%BASEDIR%\%MOODLE_DOCKER_MODULES%\admin\tool\uploadpage"
call git fetch --all
call git status
echo.

:CLONEUPLOADPAGERESULTS
IF EXIST %BASEDIR%\%MOODLE_DOCKER_MODULES%\admin\tool\uploadpageresults\%NUL% GOTO FETCHUPLOADPAGERESULTS
echo.
echo *** Cloning moodle-tool_uploadpageresults
echo.
call git clone https://github.com/lushonline/moodle-tool_uploadpageresults "%BASEDIR%\%MOODLE_DOCKER_MODULES%\admin\tool\uploadpageresults\"
echo.
GOTO CLONEUPLOADEXTERNALCONTENT

:FETCHUPLOADPAGERESULTS
echo Updating moodle-tool_uploadpageresults
echo.
echo Fetch https://github.com/lushonline/moodle-tool_uploadpageresults
CD "%BASEDIR%\%MOODLE_DOCKER_MODULES%\admin\tool\uploadpageresults"
call git fetch --all
call git status
CD %cd%
echo.

:CLONEUPLOADEXTERNALCONTENT
IF EXIST %BASEDIR%\%MOODLE_DOCKER_MODULES%\admin\tool\uploadexternalcontent\%NUL% GOTO FETCHUPLOADEXTERNALCONTENT
echo.
echo *** Cloning moodle-tool_uploadexternalcontent
echo.
call git clone https://github.com/lushonline/moodle-tool_uploadexternalcontent "%BASEDIR%\%MOODLE_DOCKER_MODULES%\admin\tool\uploadexternalcontent\"
echo.
GOTO CLONEUPLOADEXTERNALCONTENTRESULTS

:FETCHUPLOADEXTERNALCONTENT
echo Updating moodle-tool_uploadexternalcontent
echo.
echo Fetch https://github.com/lushonline/moodle-tool_uploadexternalcontent
CD "%BASEDIR%\%MOODLE_DOCKER_MODULES%\admin\tool\uploadexternalcontent"
call git fetch --all
call git status
CD %cd%
echo.
echo.

:CLONEUPLOADEXTERNALCONTENTRESULTS
IF EXIST %BASEDIR%\%MOODLE_DOCKER_MODULES%\admin\tool\uploadexternalcontentresults\%NUL% GOTO FETCHUPLOADEXTERNALCONTENTRESULTS
echo.
echo *** Cloning moodle-tool_uploadexternalcontentresults
echo.
call git clone https://github.com/lushonline/moodle-tool_uploadexternalcontentresults "%BASEDIR%\%MOODLE_DOCKER_MODULES%\admin\tool\uploadexternalcontentresults\"
echo.
GOTO CLONEEXTERNALCONTENT

:FETCHUPLOADEXTERNALCONTENTRESULTS
echo Updating moodle-tool_uploadexternalcontentresults
echo.
echo Fetch https://github.com/lushonline/moodle-tool_uploadexternalcontentresults
CD "%BASEDIR%\%MOODLE_DOCKER_MODULES%\admin\tool\uploadexternalcontentresults"
call git fetch --all
call git status
CD %cd%
echo.
echo.

:CLONEPERCIPIOEXTERNALCONTENTSYNC
IF EXIST %BASEDIR%\%MOODLE_DOCKER_MODULES%\admin\tool\percipioexternalcontentsync\%NUL% GOTO FETCHPERCIPIOEXTERNALCONTENTSYNC
echo.
echo *** Cloning moodle-tool_percipioexternalcontentsync
echo.
call git clone https://github.com/lushonline/moodle-tool_percipioexternalcontentsync "%BASEDIR%\%MOODLE_DOCKER_MODULES%\admin\tool\percipioexternalcontentsync\"
echo.
GOTO CLONEEXTERNALCONTENT

:FETCHPERCIPIOEXTERNALCONTENTSYNC
echo Updating moodle-tool_percipioexternalcontentsync
echo.
echo Fetch https://github.com/lushonline/moodle-tool_percipioexternalcontentsync
CD "%BASEDIR%\%MOODLE_DOCKER_MODULES%\admin\tool\percipioexternalcontentsync"
call git fetch --all
call git status
CD %cd%
echo.
echo.

:CLONEEXTERNALCONTENT
IF EXIST %BASEDIR%\%MOODLE_DOCKER_MODULES%\mod\externalcontent\%NUL% GOTO FETCHEXTERNALCONTENT
echo.
echo *** Cloning moodle-mod_externalcontent
echo.
call git clone https://github.com/lushonline/moodle-mod_externalcontent "%BASEDIR%\%MOODLE_DOCKER_MODULES%\mod\externalcontent"
echo.
GOTO FINISHMODULES

:FETCHEXTERNALCONTENT
echo Updating moodle-mod_externalcontent
echo.
echo Fetch https://github.com/lushonline/moodle-mod_externalcontent
CD "%BASEDIR%\%MOODLE_DOCKER_MODULES%\mod\externalcontent"
call git fetch --all
call git status
CD %cd%
echo.
echo.


:FINISHMODULES
POPD
echo.
echo *** Ensure moodle modules from %BASEDIR%\%MOODLE_DOCKER_MODULES% are installed
echo.
XCOPY "%BASEDIR%\%MOODLE_DOCKER_MODULES%\*" "%MOODLE_DOCKER_WWWROOT%\" /s /i /y
echo.

echo.
echo *** Start the MOODLE CommandLine Installer bin\start_moodleinstall.cmd
echo.
call bin\start_moodleinstall.cmd %MOODLE_VERSION%
echo.
endlocal
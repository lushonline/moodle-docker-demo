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

SET NUL=NUL
IF "%OS%"=="Windows_NT" SET NUL=

IF EXIST %MOODLE_DOCKER_MOODLEDATA%\%NUL% GOTO MOODLEMODULESEXISTS
MD %MOODLE_DOCKER_MOODLEDATA%

:MOODLEMODULESEXISTS
IF EXIST %MOODLE_DOCKER_MODULES%\%NUL% GOTO MOODLEDATAEXISTS
MD %MOODLE_DOCKER_MODULES%

:MOODLEDATAEXISTS
IF EXIST %MOODLE_DOCKER_WWWROOT%\%NUL% GOTO FETCHMOODLE

:CLONE
echo.
echo *** Cloning Moodle branch: %MOODLE_VERSION%
echo.
git clone --branch %MOODLE_VERSION% --depth 1 --single-branch git://github.com/moodle/moodle %MOODLE_DOCKER_WWWROOT%
echo.
GOTO FINISH

:FETCHMOODLE
PUSHD %cd%
CD %MOODLE_DOCKER_WWWROOT%
echo.
echo *** Remove all uncommited local files in %MOODLE_DOCKER_WWWROOT%
echo.
git clean -df
git clean -df
git clean -df
echo.
echo *** Reset in %MOODLE_DOCKER_WWWROOT%
echo.
git reset --hard
echo.
echo *** Fetch any updates from branch %MOODLE_VERSION%
echo.
git fetch --all
echo.
echo *** Pull from branch %MOODLE_VERSION%
echo.
git pull
echo.
echo *** Show Git Status
echo.
git status
echo.
POPD

:FINISH
echo.
echo *** Ensure customized config.php for the Docker containers is in place
echo.
copy config.docker-template.php %MOODLE_DOCKER_WWWROOT%\config.php
echo.

echo.
echo *** Ensure moodle files from %BASEDIR%\assets\moodle_files\ are installed
echo.
XCOPY %BASEDIR%\assets\moodle_files\* %MOODLE_DOCKER_WWWROOT%\ /s /i /y
echo.

echo.
echo *** Ensure moodle customaddons are installed
echo.
PUSHD %cd%

:CLONEUPLOADPAGE
IF EXIST %BASEDIR%\assets\moodle_modules\admin\tool\uploadpage\%NUL% GOTO FETCHUPLOADPAGE
echo.
echo *** Cloning moodle-tool_uploadpage
echo.
git clone git://github.com/lushonline/moodle-tool_uploadpage %BASEDIR%\assets\moodle_modules\admin\tool\uploadpage\
echo.
GOTO CLONEUPLOADPAGERESULTS

:FETCHUPLOADPAGE
echo Updating moodle-tool_uploadpage
echo.
echo Fetch https://github.com/lushonline/moodle-tool_uploadpage
CD %BASEDIR%\assets\moodle_modules\admin\tool\uploadpage
git fetch --all
git status
echo.

:CLONEUPLOADPAGERESULTS
IF EXIST %BASEDIR%\assets\moodle_modules\admin\tool\uploadpageresults\%NUL% GOTO FETCHUPLOADPAGERESULTS
echo.
echo *** Cloning moodle-tool_uploadpageresults
echo.
git clone git://github.com/lushonline/moodle-tool_uploadpageresults %BASEDIR%\assets\moodle_modules\admin\tool\uploadpageresults\
echo.
GOTO CLONEUPLOADEXTERNALCONTENT

:FETCHUPLOADPAGERESULTS
echo Updating moodle-tool_uploadpageresults
echo.
echo Fetch https://github.com/lushonline/moodle-tool_uploadpageresults
CD %BASEDIR%\assets\moodle_modules\admin\tool\uploadpageresults
git fetch --all
git status
echo.

:CLONEUPLOADEXTERNALCONTENT
IF EXIST %BASEDIR%\assets\moodle_modules\admin\tool\uploadexternalcontent\%NUL% GOTO FETCHUPLOADEXTERNALCONTENT
echo.
echo *** Cloning moodle-tool_uploadexternalcontent
echo.
git clone git://github.com/lushonline/moodle-tool_uploadexternalcontent %BASEDIR%\assets\moodle_modules\admin\tool\uploadexternalcontent\
echo.
GOTO CLONEUPLOADEXTERNALCONTENTRESULTS

:FETCHUPLOADEXTERNALCONTENT
echo Updating moodle-tool_uploadexternalcontent
echo.
echo Fetch https://github.com/lushonline/moodle-tool_uploadexternalcontent
CD %BASEDIR%\assets\moodle_modules\admin\tool\uploadexternalcontent
git fetch --all
git status
echo.
echo.

:CLONEUPLOADEXTERNALCONTENTRESULTS
IF EXIST %BASEDIR%\assets\moodle_modules\admin\tool\uploadexternalcontentresults\%NUL% GOTO FETCHUPLOADEXTERNALCONTENTRESULTS
echo.
echo *** Cloning moodle-tool_uploadexternalcontentresults
echo.
git clone git://github.com/lushonline/moodle-tool_uploadexternalcontentresults %BASEDIR%\assets\moodle_modules\admin\tool\uploadexternalcontentresults\
echo.
GOTO CLONEEXTERNALCONTENT

:FETCHUPLOADEXTERNALCONTENTRESULTS
echo Updating moodle-tool_uploadexternalcontentresults
echo.
echo Fetch https://github.com/lushonline/moodle-tool_uploadexternalcontentresults
CD %BASEDIR%\assets\moodle_modules\admin\tool\uploadexternalcontentresults
git fetch --all
git status
echo.
echo.

:CLONEEXTERNALCONTENT
IF EXIST %BASEDIR%\assets\moodle_modules\mod\externalcontent\%NUL% GOTO FETCHEXTERNALCONTENT
echo.
echo *** Cloning moodle-tool_uploadexternalcontentresults
echo.
git clone git://github.com/lushonline/moodle-mod_externalcontent %BASEDIR%\assets\moodle_modules\mod\externalcontent
echo.
GOTO FINISHMODULES

:FETCHEXTERNALCONTENT
echo Updating moodle-mod_externalcontent
echo.
echo Fetch https://github.com/lushonline/moodle-mod_externalcontent
CD %BASEDIR%\assets\moodle_modules\mod\externalcontent
git fetch --all
git status
echo.
echo.

:FINISHMODULES
POPD
echo.
echo *** Ensure moodle modules from %BASEDIR%\assets\moodle_modules\ are installed
echo.
XCOPY %BASEDIR%\assets\moodle_modules\* %MOODLE_DOCKER_WWWROOT%\ /s /i /y
echo.

echo.
echo *** Start the MOODLE CommandLine Installer %BASEDIR%\bin\start_moodleinstall.cmd
echo.
call %BASEDIR%\bin\start_moodleinstall.cmd %MOODLE_VERSION%
echo.
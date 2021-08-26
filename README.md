# moodle-docker-demo: Docker Containers for Moodle 3.8 or later

This repository contains a Docker configuration and scripts aimed at easily running a copy of Moodle 3.8 or later for demo or testing.

This is NOT recommeneded for Production use.

The following additional plugins will automatically be added to the Moodle Instance.

- [mod_externalcontent](https://moodle.org/plugins/mod_externalcontent)
- [tool_uploadexternalcontent](https://moodle.org/plugins/tool_uploadexternalcontent)
- [tool_uploadexternalcontentresults](https://moodle.org/plugins/tool_uploadexternalcontentresults)
- [tool_uploadpage](https://moodle.org/plugins/tool_uploadpage)
- [tool_uploadpageresults](https://moodle.org/plugins/tool_uploadexternalcontentresults)

# Windows Prerequisites

- Windows 10
  - For best performance under Docker [Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/install-win10) and a version of Linux installed. Tested using [Debian Linux](https://www.microsoft.com/en-us/p/debian/9msvkqc78pk6?activetab=pivot:overviewtab).
- [Docker](https://docs.docker.com) and [Docker Compose](https://docs.docker.com/compose/)
  - For best performance under Docker configure [Docker to use WSL2](https://docs.docker.com/desktop/windows/wsl/)
- Git command line tools
  - [Windows Git](https://git-scm.com/download/win)
  - [Git on WSL2](https://docs.microsoft.com/en-us/windows/wsl/tutorials/wsl-git)
- Recommended: Install [Windows Terminal](https://docs.microsoft.com/en-us/windows/terminal/get-started)

# Setup

## Windows with WSL2

NOTE: The images will work under Docker on Windows, without WSL2, but the performance is lower.

- Open to your WSL2 linux instance command prompt
- Clone the repository to a new folder

```
git clone git://github.com/martinholden-skillsoft/moodle-docker-demo.git moodle-docker-demo
```

- Configure the details in the .env file, the default is configured for Moodle 3.11 Stable
  - To install a different version change all instances of **MOODLE_311_STABLE** to point to the correct Moodle Git BRANCH
  - To use a different version of PHP change the **MOODLE_DOCKER_PHP_VERSION** to a valid version of [Moodle PHP Apache](https://github.com/moodlehq/moodle-php-apache)

```
MOODLE_DOCKER_DB=pgsql
MOODLE_DOCKER_ASSETDIR=./assets
MOODLE_DOCKER_MODULES=./assets/moodle_modules
MOODLE_DOCKER_MOODLEDATA=./assets/moodledata_MOODLE_311_STABLE
MOODLE_DOCKER_PHP_VERSION=7.4
MOODLE_DOCKER_WEB_HOST=localhost
MOODLE_DOCKER_WEB_PORT=8000
MOODLE_DOCKER_WWWROOT=./assets/moodle_MOODLE_311_STABLE
MOODLE_VERSION=MOODLE_311_STABLE
MOODLE_DOCKER_NGROK_HOST=
```

- Run the setup script, this will clone the Moodle repositories, and plugins and start the Moodle command line install process.

```
bin/setup_moodle
```

## Windows without WSL2

The images will work under Docker on Windows, without WSL2, but the performance is lower.

- Open a Windows Command Prompt
- Clone the repository to a new folder

```
git clone git://github.com/martinholden-skillsoft/moodle-docker-demo.git moodle-docker-demo
```

- Configure the details in the .env file, the default is configured for Moodle 3.11 Stable
  - For windows change the / to \
  - To install a different version change all instances of **MOODLE_311_STABLE** to point to the correct Moodle Git BRANCH
  - To use a different version of PHP change the **MOODLE_DOCKER_PHP_VERSION** to a valid version of [Moodle PHP Apache](https://github.com/moodlehq/moodle-php-apache)

```
MOODLE_DOCKER_DB=pgsql
MOODLE_DOCKER_ASSETDIR=.\assets
MOODLE_DOCKER_MODULES=.\assets\moodle_modules
MOODLE_DOCKER_MOODLEDATA=.\assets\moodledata_MOODLE_311_STABLE
MOODLE_DOCKER_PHP_VERSION=7.4
MOODLE_DOCKER_WEB_HOST=localhost
MOODLE_DOCKER_WEB_PORT=8000
MOODLE_DOCKER_WWWROOT=.\assets\moodle_MOODLE_311_STABLE
MOODLE_VERSION=MOODLE_311_STABLE
MOODLE_DOCKER_NGROK_HOST=
```

- Run the setup script, this will clone the Moodle repositories, and plugins and start the Moodle command line install process.

```
bin\setup_moodle
```

# Available Scripts
From the **moodle-docker-demo** folder command prompt

NOTE: For Windows change the / to \

## Start Moodle (Local)
```bash
bin/start_moodle
```

## Stop Moodle
```bash
bin/stop_moodle
```

## Start NGROK and Moodle and make available on Internet
The following steps will start [NGROK](https://ngrok.com/), start the Moodle Instance and make available over the Internet.

```bash
bin/setup_ngrok
```

## Stop NGROK and make Moodle local access only
```bash
bin/stop_ngrok
```

## Run Moodle CRON
NOTE: Moodle must be running

```bash
bin/start_cron_cli
```

## Run [Upload Page](https://moodle.org/plugins/tool_uploadpage) Module
NOTE: Moodle must be running

Run [Upload Page](https://moodle.org/plugins/tool_uploadpage) Module on the Moodle Instance.

It uses the [uploadpage.csv](assets/moodle_files/uploadpage.csv) which was copied to the web root on the Moodle server, and categoryid=1

```bash
bin/start_uploadpage_cli
```

## Run [Upload Page Results](https://moodle.org/plugins/tool_uploadpageresults) Module
NOTE: Moodle must be running

Run [Upload Page Results](https://moodle.org/plugins/tool_uploadpageresults) Module on the Moodle Instance.

It uses the [uploadpageresults.csv](assets/moodle_files/uploadpageresults.csv) which was copied to the web root on the Moodle server

```bash
bin/start_uploadpageresults_cli
```

## Run [Upload External Content](https://moodle.org/plugins/tool_uploadexternalcontent) Module
NOTE: Moodle must be running

Run [Upload External Content](https://moodle.org/plugins/tool_uploadexternalcontent) Module on the Moodle Instance.

It uses the [uploadexternal.csv](assets/moodle_files/uploadexternalcontent.csv) which was copied to the web root on the Moodle server, and categoryid=1

```bash
bin/start_uploadexternalcontent_cli
```

## Run [Upload External Content Results](https://moodle.org/plugins/tool_uploadexternalcontentresults) Module
NOTE: Moodle must be running

Run  [Upload External Content Results](https://moodle.org/plugins/tool_uploadexternalcontentresults) Module on the Moodle Instance.

It uses the [uploadexternalcontentresults.csv](assets/moodle_files/uploadexternalcontentresults.csv) which was copied to the web root on the Moodle server

```bash
bin/start_uploadexternalcontentresults_cli.cmd
```

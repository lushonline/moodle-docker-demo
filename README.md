# moodle-docker-demo: Docker Containers for demo Moodle 3.9

This repository contains Docker configuration aimed at easily running a copy of Moodle3.9 to demonstrate

## Features:
- Windows Batch file to download a Moodle 3.9 build from Git (or refresh if already download), download Moodle Modules from [https://github.com/lushonline/](https://github.com/lushonline/) and run the Moodle CLI installer. [source](bin/setup_moodle.cmd)
- Windows Batch file to start Containers [source](bin/start_moodle.cmd)
- Windows Batch file to stop Containers [source](bin/stop_moodle.cmd)
- Windows Batch file to setup NGROK and make Moodle available [source](bin/setup_ngrok.cmd)
- Windows Batch file to reset Moodle by removing Docker Persisten DB volume and all files [source](bin/reset_moodle.cmd)

- Windows Batch file to run Moodle CRON CLI [source](bin/start_cron_cli.cmd)


## Windows Prerequisites
- [Docker](https://docs.docker.com) and [Docker Compose](https://docs.docker.com/compose/) installed
- Git command line tools [Git](https://git-scm.com/download/win)


## Windows Quick Start
From a Windows CMD prompt (not Powershell)

The following steps will clone [MOODLE_39_STABLE](https://github.com/moodle/moodle/tree/MOODLE_39_STABLE) branch, start Docker Contents, and run MoodleCLI Install

```bash
D:\moodle-docker>bin\setup_moodle.cmd
```

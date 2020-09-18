# moodle-docker-demo: Docker Containers for demo Moodle 3.9

This repository contains Docker configuration aimed at easily running a copy of Moodle3.9 to demonstrate on a Windows 10 machine

# Windows Prerequisites

- [Docker](https://docs.docker.com) and [Docker Compose](https://docs.docker.com/compose/)
- Git command line tools [Git](https://git-scm.com/download/win)

# Windows Batch Commands

## Moodle Instance

- Windows Batch file to download a Moodle 3.9 build from Git (or refresh if already download), download Moodle Modules from [https://github.com/lushonline/](https://github.com/lushonline/) and run the Moodle CLI installer and Start the Containers [bin/setup_moodle.cmd](bin/setup_moodle.cmd)
- Windows Batch file to stop Containers [bin/stop_moodle.cmd](bin/stop_moodle.cmd)
- Windows Batch file to start Containers [bin/start_moodle.cmd](bin/start_moodle.cmd)
- Windows Batch file to setup NGROK and make Moodle available [bin/setup_ngrok.cmd](bin/setup_ngrok.cmd)
- Windows Batch file to reset Moodle by removing Docker Persisten DB volume and all files [bin/reset_moodle.cmd](bin/reset_moodle.cmd)

## Moodle CLI

- Windows Batch file to run Moodle CRON CLI [source](bin/start_cron_cli.cmd)
- Windows Batch file to run Moodle [Upload Page](https://moodle.org/plugins/tool_uploadpage) Module, [source](bin/start_uploadpage_cli.cmd) this uses an example data file [uploadpage.csv](assets/moodle_files/uploadpage.csv)
- Windows Batch file to run Moodle [Upload Page Results](https://moodle.org/plugins/tool_uploadpageresults) Module, [source](bin/start_uploadpageresults_cli.cmd)this uses an example data file [uploadpageresults.csv](assets/moodle_files/uploadpageresults.csv)
- Windows Batch file to run Moodle [Upload External Content](https://moodle.org/plugins/tool_uploadexternalcontent) Module, [source](bin/start_uploadexternalcontent_cli.cmd) this uses an example data file [uploadexternalcontent.csv](assets/moodle_files/uploadexternalcontent.csv)
- Windows Batch file to run Moodle [Upload External Content Results](https://moodle.org/plugins/tool_uploadexternalcontentresults) Module, [source](bin/start_uploadexternalcontentresults_cli.cmd) this uses an example data file [uploadexternalcontentresults.csv](assets/moodle_files/uploadexternalcontentresults.csv)

# Moodle Instance Commands Details

## Setup Moodle and Start Docker Containers

From a Windows CMD prompt (not Powershell)

The following steps will clone [MOODLE_39_STABLE](https://github.com/moodle/moodle/tree/MOODLE_39_STABLE) branch, start Docker Contents, and run Moodle CLI Install

```bash
c:\moodle-docker-demo>bin\setup_moodle.cmd

...... OMITTTED FOR CLARITY

-->logstore_database
++ Success ++
-->logstore_legacy
++ Success ++
-->logstore_standard
++ Success ++
Installation completed successfully.


*** Moodle is running please. Browse to - http://127.0.0.1:8000
*** Moodle Admin Username: admin
*** Moodle Admin password: test

c:\moodle-docker-demo>
```

## Stop Docker Containers

From a Windows CMD prompt (not Powershell)

The following steps will stop the running Moodle Containers, the database and moodledata folders will be retained, so you can restart Moodle.

```bash
c:\moodle-docker-demo>bin\stop_moodle.cmd

...... OMITTTED FOR CLARITY

**************************************************
*** Running: moodle-docker-compose.cmd
*** Parameters: down

*** Moodle Version: MOODLE_39_STABLE

WARNING: The MOODLE_DOCKER_NGROK_HOST variable is not set. Defaulting to a blank string.
Stopping moodle-docker-demo_webserver_1 ... done
Stopping moodle-docker-demo_dbadmin_1   ... done
Stopping moodle-docker-demo_db_1        ... done
Stopping moodle-docker-demo_mailhog_1   ... done
Removing moodle-docker-demo_webserver_1 ... done
Removing moodle-docker-demo_dbadmin_1   ... done
Removing moodle-docker-demo_db_1        ... done
Removing moodle-docker-demo_mailhog_1   ... done
Removing network moodle-docker-demo_default

c:\moodle-docker-demo>
```

## Start Existing Docker Containers

From a Windows CMD prompt (not Powershell)

The following steps will start the Moodle Containers, using the existing database and moodledata folders.

```bash
c:\moodle-docker-demo>bin\start_moodle.cmd

...... OMITTTED FOR CLARITY

**************************************************
*** Running: moodle-docker-compose.cmd
*** Parameters: exec webserver bash -c "/etc/init.d/apache2 reload"

*** Moodle Version: MOODLE_39_STABLE

[ ok ] Reloading Apache httpd web server: apache2.


*** Moodle is running please. Browse to - http://127.0.0.1:8000
*** Moodle Admin Username: admin
*** Moodle Admin password: test

c:\moodle-docker-demo>
```

## Start NGROK so Moodle available over Internet

From a Windows CMD prompt (not Powershell)

The following steps will start [NGROK](ngrok.exe), restart the Docker Containers and make the Moodle Instance available over the Internet.

```bash
c:\moodle-docker-demo>bin\setup_ngrok.cmd

...... OMITTTED FOR CLARITY

*** Moodle is available via NGROK. Browse to - https://c993535585f4.ngrok.io

*** Moodle Admin Username: admin
*** Moodle Admin password: test

moodle-docker-demo>
```

## Stop NGROK

From a Windows CMD prompt (not Powershell)

The following steps will restart the Docker Containers and make the Moodle Instance available on http://127.0.0.1:8000 only.

Once completed you should stop [NGROK](ngrok.exe)

```bash
c:\moodle-docker-demo>bin\stop_ngrok.cmd

...... OMITTTED FOR CLARITY

*** Moodle is running please. Browse to - http://127.0.0.1:8000

*** Moodle Admin Username: admin
*** Moodle Admin password: test

moodle-docker-demo>
```

# Moodle CLI Commands Details

## Run Moodle CRON

From a Windows CMD prompt (not Powershell)

The following steps will run CRON on the Moodle Instance.

```bash
c:\moodle-docker-demo>bin\start_cron_cli.cmd

...... OMITTTED FOR CLARITY

**************************************************
*** Running: moodle-docker-compose.cmd
*** Parameters: exec webserver php admin/cli/cron.php

*** Moodle Version: MOODLE_39_STABLE

Server Time: Fri, 18 Sep 2020 08:17:17 +0100


Execute scheduled task: Cleanup old sessions (core\task\session_cleanup_task)
... started 08:17:18. Current memory use 15.3MB.
... used 25 dbqueries
... used 0.19313383102417 seconds

...... OMITTTED FOR CLARITY

Ran 1 adhoc tasks found at Fri, 18 Sep 2020 08:17:17 +0100
Cron script completed correctly
Cron completed at 08:18:09. Memory used 60.9MB.
Execution took 51.345567 seconds

c:\moodle-docker-demo>
```

## Run [Upload Page](https://moodle.org/plugins/tool_uploadpage) Module

From a Windows CMD prompt (not Powershell)

The following steps will run [Upload Page](https://moodle.org/plugins/tool_uploadpage) Module on the Moodle Instance.

It uses the [uploadpage.csv](assets/moodle_files/uploadpage.csv) which was copied to the web root on the Moodle server, and categoryid=1

This NODE project can be used to generate files to use for import [https://github.com/martinholden-skillsoft/moodle-percipio-externalcontent](https://github.com/martinholden-skillsoft/moodle-percipio-externalcontent)

```bash
c:\moodle-docker-demo>bin\start_uploadpage_cli.cmd

...... OMITTTED FOR CLARITY

**************************************************
*** Running: moodle-docker-compose.cmd
*** Parameters: exec webserver php admin/tool/uploadpage/cli/uploadpage.php --source=../../../../uploadpage.csv --categoryid=1

*** Moodle Version: MOODLE_39_STABLE

Upload single page courses (2020081700)

Options Used:
--source = ../../../../uploadpage.csv
--delimiter = comma
--encoding = UTF-8
--categoryid = 1

line    result  id      shortname       fullname        idnumber
1       OK      2       (Channel) Strategic Thinking (1b49aa30-e719-11e6-9835-f723b46a2688)     (Channel) Strategic Thinking    1b49aa30-e719-11e6-9835-f723b46a2688
Course Created.

...... OMITTTED FOR CLARITY

10      OK      11      (Channel) Java (0d2d2c20-e1a0-11e6-91a7-0242c0a80704)   (Channel) Java  0d2d2c20-e1a0-11e6-91a7-0242c0a80704
Course Created.
Courses total: 10
Courses created: 10
Courses updated: 0
Courses deleted: 0
Courses not updated: 0
Courses errors: 0

c:\moodle-docker-demo>
```

## Run [Upload Page Results](https://moodle.org/plugins/tool_uploadpageresults) Module

From a Windows CMD prompt (not Powershell)

The following steps will run [Upload Page Results](https://moodle.org/plugins/tool_uploadpageresults) Module on the Moodle Instance.

It uses the [uploadpageresults.csv](assets/moodle_files/uploadpageresults.csv) which was copied to the web root on the Moodle server

This NODE project can be used to generate files to use for import [https://github.com/martinholden-skillsoft/moodle-percipio-externalcontentresults](hhttps://github.com/martinholden-skillsoft/moodle-percipio-externalcontentresults)


```bash
c:\moodle-docker-demo>bin\start_uploadpageresults_cli.cmd

...... OMITTTED FOR CLARITY

**************************************************
*** Running: moodle-docker-compose.cmd
*** Parameters: exec webserver php admin/tool/uploadpageresults/cli/uploadpageresults.php --source=../../../../uploadpageresults.csv

*** Moodle Version: MOODLE_39_STABLE

Upload page activities completions (2020081700)

Options Used:
--source = ../../../../uploadpageresults.csv
--delimiter = comma
--encoding = UTF-8

line    result  user    id      fullname
1       OK      admin   2       (Channel) Strategic Thinking
Page completion added     Page - Completion Viewed set to true.

...... OMITTTED FOR CLARITY

10      OK      admin   11      (Channel) Java
Page completion added     Page - Completion Viewed set to true.
Completions total: 10
Completions added: 10
Completions skipped: 0
Completions errors: 0

c:\moodle-docker-demo>
```

## Run [Upload External Content](https://moodle.org/plugins/tool_uploadexternalcontent) Module

From a Windows CMD prompt (not Powershell)

The following steps will run [Upload External Content](https://moodle.org/plugins/tool_uploadexternalcontent) Module on the Moodle Instance.

It uses the [uploadexternal.csv](assets/moodle_files/uploadexternalcontent.csv) which was copied to the web root on the Moodle server, and categoryid=1

This NODE project can be used to generate files to use for import [https://github.com/martinholden-skillsoft/moodle-percipio-externalcontent](https://github.com/martinholden-skillsoft/moodle-percipio-externalcontent)

```bash
c:\moodle-docker-demo>bin\start_uploadexternalcontent_cli.cmd

...... OMITTTED FOR CLARITY

**************************************************
*** Running: moodle-docker-compose.cmd
*** Parameters: exec webserver php admin/tool/uploadexternalcontent/cli/uploadexternalcontent.php --source=../../../../uploadexternalcontent.csv --categoryid=1

*** Moodle Version: MOODLE_39_STABLE

Upload external content courses (2020081300)

Options Used:
--source = ../../../../uploadexternalcontent.csv
--delimiter = comma
--encoding = UTF-8
--categoryid = 1

line    result  id      shortname       fullname        idnumber
1       OK      2       (Course) Predictive Analytics: Key Statistical Concepts (1ba0f310-9ca1-11e7-ba6b-e15f120286ac)  (Course) Predictive Analytics: Key Statistical Concepts   1ba0f310-9ca1-11e7-ba6b-e15f120286ac
Course Created.   Thumbnail downloaded and added.

...... OMITTTED FOR CLARITY

17      OK      18      (Course) Predictive Analytics: Model Life Cycle Management (55f938e6-b388-11e7-9c7a-4e99e0664338)       (Course) Predictive Analytics: Model Life Cycle Management        55f938e6-b388-11e7-9c7a-4e99e0664338
Course Created.   Thumbnail could not be retrieved. Unknown exception related to local files (Can not fetch file form URL).
Courses total: 17
Courses created: 17
Courses updated: 0
Courses deleted: 0
Courses not updated: 0
Courses errors: 0

c:\moodle-docker-demo>
```

## Run [Upload External Content Results](https://moodle.org/plugins/tool_uploadexternalcontentresults) Module

From a Windows CMD prompt (not Powershell)

The following steps will run [Upload External Content Results](https://moodle.org/plugins/tool_uploadexternalcontentresults) Module on the Moodle Instance.

It uses the [uploadexternalcontentresults.csv](assets/moodle_files/uploadexternalcontentresults.csv) which was copied to the web root on the Moodle server

This NODE project can be used to generate files to use for import [https://github.com/martinholden-skillsoft/moodle-percipio-externalcontentresults](hhttps://github.com/martinholden-skillsoft/moodle-percipio-externalcontentresults)

```bash
c:\moodle-docker-demo>bin\start_uploadexternalcontentresults_cli.cmd

...... OMITTTED FOR CLARITY

**************************************************
*** Running: moodle-docker-compose.cmd
*** Parameters: exec webserver php admin/tool/uploadexternalcontentresults/cli/uploadexternalcontentresults.php --source=../../../../uploadexternalcontentresults.csv

*** Moodle Version: MOODLE_39_STABLE

Upload external content completions (2020081300)

Options Used:
--source = ../../../../uploadexternalcontentresults.csv
--delimiter = comma
--encoding = UTF-8

line    result  user    id      fullname
1       OK      admin   2       (Course) Predictive Analytics: Key Statistical Concepts
External content completion data added/updated.   External content viewed status set to COMPLETION_VIEWED.
2       OK      admin   3       (Course) Predictive Analytics: Process & Applications
External content completion data added/updated.   External content viewed status set to COMPLETION_VIEWED.

...... OMITTTED FOR CLARITY

17      OK      admin   18      (Course) Predictive Analytics: Model Life Cycle Management
External content completion data added/updated.   External content viewed status set to COMPLETION_VIEWED. External content completion status set to COMPLETION_COMPLETE. External content grade set to 93.
Completions total: 17
Completions added/updated: 17
Completions skipped: 0
Completions errors: 0

c:\moodle-docker-demo>
```

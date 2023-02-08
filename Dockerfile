ARG PHP_VERSION=7.4
FROM moodlehq/moodle-php-apache:${PHP_VERSION}

RUN apt-get update && \
    apt-get -y install tzdata cron

RUN cp /usr/share/zoneinfo/Europe/London /etc/localtime && \
    echo "Europe/London" > /etc/timezone

#RUN apt-get -y remove tzdata
RUN rm -rf /var/cache/apk/*

# Copy cron file to the cron.d directory
COPY assets/web/moodle-crontab /etc/cron.d/moodle-crontab
RUN chmod 0644 /etc/cron.d/moodle-crontab
RUN crontab /etc/cron.d/moodle-crontab

# Create the log file to be able to run tail
RUN mkdir -p /var/log/cron
# creating the log file that will be written to at each cron iteration
RUN touch /var/log/cron/cron.log

# Add a command to base-image entrypont script
RUN sed -i 's/^exec /service cron start\n\nexec /' /usr/local/bin/apache2-foreground
#!/bin/bash

CRON_MAKE_CMD='renew_cert.sh > /dev/null 2>&1'
CRON_MAKE_TIME='0 0 */5 * *'

if [ $1 = '-t' ]; then
    CRON_MAKE_TIME=$2
fi

CRON_MAKE_JOB="$CRON_MAKE_TIME $CRON_MAKE_CMD"

#Show variables to be used
echo Using the following configs
echo CMD: "$CRON_MAKE_CMD"
echo TIME: "$CRON_MAKE_TIME"
echo JOB: "$CRON_MAKE_JOB"

( crontab -l | grep -v -F "$CRON_MAKE_CMD" ; echo "$CRON_MAKE_JOB" ) | crontab -

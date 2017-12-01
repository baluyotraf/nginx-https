#!/bin/bash


CRON_MAKE_CMD='renew_cert.sh > /dev/null 2>&1'

#Show variables to be used
echo Using the following configs
echo CMD: "$CRON_MAKE_CMD"

( crontab -l | grep -v -F "$CRON_MAKE_CMD" ) | crontab -

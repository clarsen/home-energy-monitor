#!/bin/bash
PATH=/usr/local/bin:$PATH
export PATH

cd $HOME/git
lock=/tmp/wunderground.running
if [ -f $lock ]; then
    echo $0 still running
    exit 1
fi
touch $lock

pipenv run python wunderground-to-influx/capture.deploy.py >> /tmp/cron.out 2>&1
rm $lock

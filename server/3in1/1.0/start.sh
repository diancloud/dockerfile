#!/bin/sh
USER=$USER
GROUP=$GROUP
if [ -z $USER ]; then
	USER="www-data"
fi

if [ -z $GROUP ]; then
	GROUP="www-data"
fi
useradd  -g $GROUP $USER
/start/start.redis.sh 
/start/start.mysql.sh 
/start/start.web.sh 
/usr/bin/tail -f /dev/null
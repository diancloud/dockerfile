#!/bin/sh
LOG_PATH="/logs"
if [ ! -d "/elasticsearch/config/ik" ]; then
	rm -rf /elasticsearch/config/*
	cd /elasticsearch/config && cp -r  /defaults/config/* ./
fi

cd /elasticsearch/bin && ./elasticsearch >> "$LOG_PATH/elasticsearch.log"

/usr/bin/tail -f /dev/null
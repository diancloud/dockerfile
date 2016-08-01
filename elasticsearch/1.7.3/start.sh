#!/bin/sh
CONF=$CONF
RENEW=$RENEW
LOG="/logs/shell.log"

# 是否开启 RENEW
if [ ! -z "$RENEW" ]; then
	rm -rf /config/*
fi

# 检查用户组
ug=$(ls -l /config | awk '{print $3":"$4}')
if [ "$ug" != "es-data:es-data" ]; then
	chown -R es-data:es-data /config 
fi

ug=$(ls -l /logs | awk '{print $3":"$4}')
if [ "$ug" != "es-data:es-data" ]; then
	chown -R es-data:es-data /logs 
fi

ug=$(ls -l /data | awk '{print $3":"$4}')
if [ "$ug" != "es-data:es-data" ]; then
	chown -R es-data:es-data /data 
fi

# 更新配置文件
if [ -z $CONF ]; then
	CONF="default"
fi

if [ ! -d "/defaults/config/$CONF" ]; then
	CONF="default"
	echo "$CONF not exist. default selected!" >> $LOG
fi

if [ ! -f "/config/elasticsearch.yml" ]; then
	cp -rf "/defaults/config/$CONF/elasticsearch.yml" /config/
fi

if [ ! -f "/config/logging.yml" ]; then
	cp -rf "/defaults/config/$CONF/logging.yml" /config/
fi

if [ ! -d "/config/ik" ]; then
	cp -rf "/defaults/config/$CONF/ik" /config/
fi

# 重建符号链接
rm -f /elasticsearch/config && ln -s /config /elasticsearch/config

/elasticsearch/bin/elasticsearch >> $LOG
/usr/bin/tail -f /dev/null
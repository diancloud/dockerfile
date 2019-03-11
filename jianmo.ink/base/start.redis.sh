#!/bin/sh
CONF=$CONF
RENEW=$RENEW
MASTER=$MASTER
CNAME="sentinel"
LOG="/logs/redis/shell.log"

# 是否开启 RENEW
if [ ! -z "$RENEW" ]; then
	rm -rf /config/redis
fi

if [ ! -d "/logs/redis" ]; then
	mkdir -p /logs/redis
fi

if [ ! -d "/config/redis" ]; then
	mkdir -p /config/redis
fi

if [ ! -d "/data/redis" ]; then
	mkdir -p /data/redis
fi


# 检查用户组
ug=$(ls -l /config/redis | awk '{print $3":"$4}')
if [ "$ug" != "root:root" ]; then
	chown -R root:root /config/redis
fi

ug=$(ls -l /logs/redis | awk '{print $3":"$4}')
if [ "$ug" != "root:root" ]; then
	chown -R root:root /logs/redis
fi

ug=$(ls -l /data/redis | awk '{print $3":"$4}')
if [ "$ug" != "root:root" ]; then
	chown -R root:root /data/redis
fi


# 更新配置文件
CONF="default"
MASTER="server"
CNAME="redis"

if [ ! -f "/config/redis/redis.conf" ]; then
	cp -r "/defaults/redis/$CONF/redis.conf" /config/redis/
fi

if [ ! -f "/config/redis/sentinel.conf" ]; then
	cp -r "/defaults/redis/$CONF/sentinel.conf" /config/redis/
fi

 
"/usr/local/bin/redis-$MASTER" "/config/redis/$CNAME.conf" >> $LOG 2>&1 &



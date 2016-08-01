#!/bin/sh
CONF=$CONF
RENEW=$RENEW
MASTER=$MASTER
CNAME="sentinel"
LOG="/logs/shell.log"

# 是否开启 RENEW
if [ ! -z "$RENEW" ]; then
	rm -rf /config/*
fi


# 检查用户组
ug=$(ls -l /config | awk '{print $3":"$4}')
if [ "$ug" != "root:root" ]; then
	chown -R root:root /config 
fi

ug=$(ls -l /logs | awk '{print $3":"$4}')
if [ "$ug" != "root:root" ]; then
	chown -R root:root /logs 
fi

ug=$(ls -l /data | awk '{print $3":"$4}')
if [ "$ug" != "postgres:postgres" ]; then
	chown -R postgres:postgres /data 
fi


# 更新配置文件
if [ -z $CONF ]; then
	CONF="default"
fi

if [ -z $MASTER ]; then
	MASTER="server"
	CNAME="redis"
fi

if [ ! -d "/defaults/config/$CONF" ]; then
	CONF="default"
	echo "$CONF not exist. default selected!" >> $LOG
fi

if [ ! -f "/config/redis.conf" ]; then
	cp -r "/defaults/config/$CONF/redis.conf" /config/
fi

if [ ! -f "/config/sentinel.conf" ]; then
	cp -r "/defaults/config/$CONF/sentinel.conf" /config/
fi

if [ ! -f "/config/config.yml" ]; then
	cp -r "/defaults/config/$CONF/config.yml" /config/
fi

if [ ! -f "/config/sentry.conf.py" ]; then
	cp -r "/defaults/config/$CONF/sentry.conf.py" /config/
fi

if [ ! -f "/config/postgresql.conf" ]; then
	cp -r "/defaults/config/$CONF/postgresql.conf" /config/
fi

if [ ! -d "/logs/redis" ]; then
	mkdir /logs/redis
fi


# 启动REDIS 
"/usr/local/bin/redis-$MASTER" "/config/$CNAME.conf" >> $LOG  &


# 检查并启动POSTGRESQL
if [ ! -d "/data/db" ]; then
	echo "init postgres db " >> $LOG
	mkdir -p /data/db 
	chown -R postgres:postgres /data/db
	su - postgres -c "initdb -D /data/db"
	su - postgres -c "postgres --config-file=/config/postgresql.conf" >> $LOG &
	sleep 1
	su - postgres -c "createdb -E utf-8 sentry"
	SENTRY_CONF=/config sentry upgrade --noinput
	SENTRY_CONF=/config sentry createuser --email logs@tuanduimao.com --password logs1234 --superuser --no-input
else
	su - postgres -c "postgres --config-file=/config/postgresql.conf" >> $LOG & 
	sleep 1
fi


# 启动Sentry
su - sentry  -c "SENTRY_CONF=/config  sentry run web"  >> $LOG & 
su - sentry  -c "SENTRY_CONF=/config  sentry run worker"  >> $LOG & 
su - sentry  -c "SENTRY_CONF=/config  sentry run cron"  >> $LOG & 


# 保持运行状态
/usr/bin/tail -f /dev/null
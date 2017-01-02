#!/bin/sh
CONF=$CONF
RENEW=$RENEW
CNAME=$CNAME
LOG="/logs/mysql/shell.log"

# 是否开启 RENEW
if [ ! -z "$RENEW" ]; then
	rm -rf /config/mysql/*
fi

if [ ! -d "/logs/mysql" ]; then
	mkdir -p /logs/mysql
fi

if [ ! -d "/config/mysql" ]; then
	mkdir -p /config/mysql
fi

if [ ! -d "/data/mysql" ]; then
	mkdir -p /data/mysql
fi



# 检查用户组
ug=$(ls -l /config/mysql | awk '{print $3":"$4}')
if [ "$ug" != "root:root" ]; then
	chown -R root:root /config/mysql
fi

ug=$(ls -l /logs/mysql | awk '{print $3":"$4}')
if [ "$ug" != "root:root" ]; then
	chown -R root:root /logs/mysql 
fi

ug=$(ls -l /data/mysql | awk '{print $3":"$4}')
if [ "$ug" != "root:root" ]; then
	chown -R root:root /data/mysql
fi


# 更新配置文件
if [ -z $CONF ]; then
	CONF="default"
fi

if [ -z $CNAME ]; then
	CNAME="master"
fi

if [ ! -d "/defaults/mysql/$CONF" ]; then
	CONF="default"
	echo "$CONF not exist. default selected!" >> $LOG
fi

if [ ! -f "/config/mysql/my.cnf" ]; then
	cp -r "/defaults/mysql/$CONF/my.cnf" /config/mysql/
fi

# 检查数据目录
if [ ! -d "/data/mysql/db" ]; then
	/usr/bin/mysql_install_db --basedir=/usr --datadir=/data/mysql/db --user=mysql && \
	chown -R mysql:mysql /data/mysql/db
fi

# 检查 MySQL 用户组
ug=$(ls -l  /data/mysql/db | awk '{print $3":"$4}')
if [ "$ug" != "mysql:mysql" ]; then
	chown -R mysql:mysql /data/mysql/db
fi

/usr/bin/mysqld_safe --defaults-file=/config/mysql/my.cnf >> $LOG 2>&1 &

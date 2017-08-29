#!/bin/sh
CONF=$CONF
RENEW=$RENEW
CNAME=$CNAME
LOG="/logs/shell.log"

# 是否开启 RENEW
if [ ! -z "$RENEW" ]; then
	rm -rf /config/*
fi

# 检查用户组
ug=$(ls -l / | grep config | awk '{print $3":"$4}')
if [ "$ug" != "root:root" ]; then
	chown -R root:root /config 
fi

ug=$(ls -l / | grep logs | awk '{print $3":"$4}')
if [ "$ug" != "root:root" ]; then
	chown -R root:root /logs 
fi

ug=$(ls -l / | grep data | awk '{print $3":"$4}')
if [ "$ug" != "root:root" ]; then
	chown -R root:root /data 
fi


# 更新配置文件
if [ -z $CONF ]; then
	CONF="default"
fi

if [ -z $CNAME ]; then
	CNAME="master"
fi

if [ ! -d "/defaults/config/$CONF" ]; then
	CONF="default"
	echo "$CONF not exist. default selected!" >> $LOG
fi

if [ ! -f "/config/my.cnf" ]; then
	cp -r "/defaults/config/$CONF/my.cnf" /config/
fi

# 检查数据目录
if [ ! -d "/data/mysql" ]; then
	/usr/bin/mysql_install_db --basedir=/usr --datadir=/data/mysql --user=mysql && \
	chown -R mysql:mysql /data/mysql
fi

if [ ! -d "/data/confluence" ]; then
	mkdir /data/confluence
	chown -R confluence:confluence /data/confluence
fi


# 检查用户组
ug=$(ls -l  /data | grep mysql | awk '{print $3":"$4}')
if [ "$ug" != "mysql:mysql" ]; then
	chown -R mysql:mysql /data/mysql
fi

ug=$(ls -l  /data | grep confluence | awk '{print $3":"$4}')
if [ "$ug" != "confluence:confluence" ]; then
	chown -R confluence:confluence /data/confluence
fi


chown -R mysql:mysql /logs/mysql

# 启动 Mysql
/usr/bin/mysqld_safe --defaults-file=/config/my.cnf >> $LOG &

# 启动 confluence
/usr/sbin/service confluence start

# 保持运行状态
/usr/bin/tail -f /dev/null

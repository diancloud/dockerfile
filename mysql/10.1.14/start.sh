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
ug=$(ls -l /config | awk '{print $3":"$4}')
if [ "$ug" != "root:root" ]; then
	chown -R root:root /config 
fi

ug=$(ls -l /logs | awk '{print $3":"$4}')
if [ "$ug" != "root:root" ]; then
	chown -R root:root /logs 
fi

ug=$(ls -l /data | awk '{print $3":"$4}')
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

# 检查 MySQL 用户组
ug=$(ls -l  /data/mysql | awk '{print $3":"$4}')
if [ "$ug" != "mysql:mysql" ]; then
	chown -R mysql:mysql /data/mysql
fi


/usr/bin/mysqld_safe --defaults-file=/config/my.cnf >> $LOG &

# 保持运行状态
/usr/bin/tail -f /dev/null

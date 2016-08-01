#!/bin/sh
CONF=$CONF
RENEW=$RENEW
LOG="/logs/shell.log"

# 是否开启 RENEW
if [ ! -z "$RENEW" ]; then
	rm -rf /config/*
fi

# 检查用户组
ug=$(ls -l /config | awk '{print $3:$4}')
if [ "$ug" != "root:root" ]; then
	chown -R root:root /config 
fi

ug=$(ls -l /logs | awk '{print $3:$4}')
if [ "$ug" != "root:root" ]; then
	chown -R root:root /logs 
fi

ug=$(ls -l /data | awk '{print $3:$4}')
if [ "$ug" != "www-data:www-data" ]; then
	chown -R www-data:www-data /data 
fi

ug=$(ls -l /code | awk '{print $3:$4}')
if [ "$ug" != "root:root" ]; then
	chown -R root:root /code 
fi


# 更新配置文件
if [ -z $CONF ]; then
	CONF="default"
fi

if [ ! -d "/defaults/config/$CONF" ]; then
	CONF="default"
	echo "$CONF not exist. default selected!" >> $LOG
fi

if [ ! -d "/config/nginx" ]; then
	cp -r "/defaults/config/$CONF/nginx" /config/
fi

if [ ! -d "/config/php" ]; then
	cp -R "/defaults/config/$CONF/php" /config/
fi

# 创建默认目录
if [ ! -d "/run/nginx" ]; then
	mkdir /run/nginx
fi

if [ ! -d "/run/php" ]; then
	mkdir -p /run/php/fpm
fi

if [ ! -d "/logs/php" ]; then
	mkdir -p /logs/php/fpm
fi

if [ ! -d "/logs/nginx" ]; then
	mkdir -p /logs/nginx/fpm
fi

# 如果未部署任何代码则
if [ "$(ls /code | wc -l)" = "0" ]; then
	echo "<?php " >> "/code/index.php"
	echo "phpinfo();" >> "/code/index.php"
fi

# 启动 PHP-FPM
/opt/php7/sbin/php-fpm -c /config/php/php.ini  -y /config/php/fpm/php-fpm.conf

# 启动 Nginx
/opt/openresty/nginx/sbin/nginx -c /config/nginx/nginx.conf

# 保持运行状态
/usr/bin/tail -f /dev/null

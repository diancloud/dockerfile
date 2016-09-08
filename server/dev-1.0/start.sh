#!/bin/sh
CONF=$CONF
RENEW=$RENEW
MAIN_HOST=$MAIN_HOST
LOG="/logs/startup.log"


if [ ! -d "/code/tuanduimao" ]; then
	echo "please checkout tuanduimao source code, first. ( nginx may not work) " >> $LOG
fi

if [ ! -d "/code/tuanui" ]; then
	echo "please checkout tuanui source code, first" >> $LOG
fi

if [ ! -d "/code/tuanapps" ]; then
	echo "please create tuanapps path , first" >> $LOG
fi


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
if [ "$ug" != "www-data:www-data" ]; then
	chown -R www-data:www-data /data 
fi

# ug=$(ls -l /code | awk '{print $3":"$4}')
# if [ "$ug" != ":$GROUP" ]; then
# 	chown -R $USER:$GROUP /code 
# fi

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

# copy php.ini 
if [ -f "/config/php/php.ini" ]; then
	cp -f /config/php/php.ini  /opt/php7/etc/php.ini
fi

# 创建服务配置目录 (可写目录)
if [ ! -d "/config/service" ]; then
	mkdir -p "/config/service"
	chown -R www-data:www-data /config/service
fi


# fix vhost 
if [ "$MAIN_HOST" != "tuanduimao.lc" ]; then
	
	sed -i "s/tuanduimao.lc/$MAIN_HOST/g" /config/nginx/vhost/*.tuanduimao.lc
	
	if [ -f "/config/nginx/vhost/admin.tuanduimao.lc" ]; then
		mv /config/nginx/vhost/admin.tuanduimao.lc "/config/nginx/vhost/admin.$MAIN_HOST"
	fi

	if [ -f "/config/nginx/vhost/apps.tuanduimao.lc" ]; then
		mv /config/nginx/vhost/apps.tuanduimao.lc "/config/nginx/vhost/apps.$MAIN_HOST"
	fi

	if [ -f "/config/nginx/vhost/cdn.tuanduimao.lc" ]; then
		mv /config/nginx/vhost/cdn.tuanduimao.lc "/config/nginx/vhost/cdn.$MAIN_HOST"
	fi

	if [ -f "/config/nginx/vhost/ui.tuanduimao.lc" ]; then
		mv /config/nginx/vhost/ui.tuanduimao.lc "/config/nginx/vhost/ui.$MAIN_HOST"
	fi
fi


# xdebug logs
if [ ! -d "/logs/xdebug" ]; then
	mkdir /logs/xdebug
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

if [ ! -d "/data/stor/public" ]; then
	mkdir -p /data/stor/public
	chown -R www-data:www-data /data/stor
fi

if [ ! -d "/data/stor/private" ]; then
	mkdir -p /data/stor/private
	chown -R www-data:www-data /data/stor
fi

if [ ! -d "/data/composer" ]; then
	mkdir -p /data/composer
	chown -R www-data:www-data /data/composer
fi


# 如果未部署任何代码则
# if [ "$(ls /code | wc -l)" = "0" ]; then
# 	echo "<?php " >> "/code/index.php"
# 	echo "phpinfo();" >> "/code/index.php"
# 	chown $USER:$GROUP "/code/index.php"
# fi

# 启动 PHP-FPM
/opt/php7/sbin/php-fpm -c /config/php/php.ini  -y /config/php/fpm/php-fpm.conf

# 启动 Nginx
/opt/openresty/nginx/sbin/nginx -c /config/nginx/nginx.conf

# 生成 Default Inc
if [ ! -f "/config/service/defaults.inc.php" ]; then
	/bin/tdm conf
fi

# 安装 composer
if [ ! -f "/data/composer/composer.lock" ]; then
	/bin/tdm composer
fi

# 保持运行状态
/usr/bin/tail -f /dev/null

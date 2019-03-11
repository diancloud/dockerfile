#!/bin/sh
CONF=$CONF
RENEW=$RENEW
MAIN_HOST=$HOST
HTTPS=$HTTPS
USER=$USER
GROUP=$GROUP
MYSQLOFF=$1
LOG="/logs/web/shell.log"

if [ -z $USER ]; then
	USER="www-data"
fi

if [ -z $GROUP ]; then
	GROUP="www-data"
fi


if [ ! -d "/logs/web" ]; then
	mkdir -p /logs/web
fi

if [ ! -d "/config/web" ]; then
	mkdir -p /config/web
fi

if [ ! -d "/data/web" ]; then
	mkdir -p /data/web
fi

if [ ! -d "/code" ]; then
	echo "please checkout tuanduimao source code, first. ( nginx may not work) " >> $LOG
fi




# 检查用户组
ug=$(ls -l /config/web | awk '{print $3":"$4}')
if [ "$ug" != "root:root" ]; then
	chown -R root:root /config/web 
fi

ug=$(ls -l /logs/web  | awk '{print $3":"$4}')
if [ "$ug" != "root:root" ]; then
	chown -R root:root /logs/web  
fi

ug=$(ls -l /data/web | awk '{print $3":"$4}')
if [ "$ug" != "$USER:$GROUP" ]; then
	chown -R $USER:$GROUP /data/web
fi


# 更新配置文件
if [ -z $CONF ]; then
	CONF="default"
fi

if [ -z $MAIN_HOST ]; then
	MAIN_HOST="tuanduimao.lc"
fi

if [ ! -d "/defaults/web/$CONF" ]; then
	CONF="default"
	echo "$CONF not exist. default selected!" >> $LOG
fi

if [ ! -d "/config/web/nginx" ]; then
	cp -r "/defaults/web/$CONF/nginx" /config/web/
	sed -i "s/user www-data/user $USER $GROUP/g" /config/web/nginx/nginx.conf
fi

if [ ! -d "/config/web/php" ]; then
	cp -R "/defaults/web/$CONF/php" /config/web/

	sed -i "s/user = www-data/user = $USER/g"  /config/web/php/fpm/php-fpm.d/www.conf
	sed -i "s/group = www-data/group = $GROUP/g" /config/web/php/fpm/php-fpm.d/www.conf
	sed -i "s/listen.owner = www-data/listen.owner = $GROUP/g" /config/web/php/fpm/php-fpm.d/www.conf
	sed -i "s/listen.group = www-data/listen.group = $GROUP/g" /config/web/php/fpm/php-fpm.d/www.conf
fi

if [ ! -d "/config/web/lua" ]; then
	cp -R "/defaults/web/$CONF/lua" /config/web/
fi


if [ ! -d "/config/crt" ]; then
	cp -R "/defaults/web/$CONF/crt" /config/
fi

# copy php.ini 
if [ -f "/config/web/php/php.ini" ]; then
	cp -f /config/web/php/php.ini  /opt/php7/etc/php.ini
fi

# copy route.lua
if [ ! -f "/code/route.lua" ]; then
	cp -f /config/web/lua/route.lua  /code/route.lua
fi

# copy route.rewrite.conf
if [ ! -f "route.rewrite.conf" ]; then
	cp -f /config/web/nginx/route.rewrite.conf  /code/route.rewrite.conf
fi


# 创建服务配置目录 (可写目录)
if [ ! -d "/config/service" ]; then
	mkdir -p "/config/service"
	chown -R $USER:$GROUP /config/service
fi

# 默认 VHOST
rm -f /config/web/nginx/vhost/enable/tuanduimao.lc
rm -f /config/web/nginx/vhost/enable/tuanduimao.lc.ssl
rm -f /config/web/nginx/vhost/enable/apps.tuanduimao.cn
ln -s "/config/web/nginx/vhost/tuanduimao.lc" "/config/web/nginx/vhost/enable/tuanduimao.lc" 
ln -s "/config/web/nginx/vhost/tuanduimao.lc.ssl" "/config/web/nginx/vhost/enable/tuanduimao.lc.ssl" 
ln -s "/config/web/nginx/vhost/apps.tuanduimao.cn" "/config/web/nginx/vhost/enable/apps.tuanduimao.cn" 

# 设定 HTTPS
if [ "$MAIN_HOST" != "tuanduimao.lc" ]; then

	if [ -f "/config/web/nginx/vhost/tuanduimao.lc" ]; then
		cp /config/web/nginx/vhost/tuanduimao.lc "/config/web/nginx/vhost/$MAIN_HOST"
		sed -i "s/tuanduimao.lc/$MAIN_HOST/g" "/config/web/nginx/vhost/$MAIN_HOST"
	fi

	if [ -f "/config/web/nginx/vhost/tuanduimao.lc.ssl" ]; then
		cp /config/web/nginx/vhost/tuanduimao.lc.ssl "/config/web/nginx/vhost/$MAIN_HOST.ssl"
		sed -i "s/tuanduimao.lc/$MAIN_HOST/g" "/config/web/nginx/vhost/$MAIN_HOST.ssl"
	fi

	if [ -f "/config/web/nginx/vhost/tuanduimao.lc.fwd" ]; then
		cp /config/web/nginx/vhost/tuanduimao.lc.fwd "/config/web/nginx/vhost/$MAIN_HOST.fwd"
		sed -i "s/tuanduimao.lc/$MAIN_HOST/g" "/config/web/nginx/vhost/$MAIN_HOST.fwd"
	fi

	if [ "$HTTPS" = "ON" ]; then

		if [ ! -f "/config/crt/$MAIN_HOST.key" ]; then 
			echo "/config/crt/$MAIN_HOST.key not exist. " >> $LOG
			cp /config/crt/tuanduimao.lc.key /config/crt/$MAIN_HOST.key
		fi

		if [ ! -f "/config/crt/$MAIN_HOST.crt" ]; then 
			echo "/config/crt/$MAIN_HOST.crt not exist. " >> $LOG
			cp /config/crt/tuanduimao.lc.crt /config/crt/$MAIN_HOST.crt
		fi

		rm -f "/config/web/nginx/vhost/enable/$MAIN_HOST*"
		ln -s "/config/web/nginx/vhost/$MAIN_HOST" "/config/web/nginx/vhost/enable/$MAIN_HOST"
		ln -s "/config/web/nginx/vhost/$MAIN_HOST.ssl" "/config/web/nginx/vhost/enable/$MAIN_HOST.ssl"

	elif [ "$HTTPS" = "FORCE" ]; then
		if [ ! -f "/config/crt/$MAIN_HOST.key" ]; then 
			echo "/config/crt/$MAIN_HOST.key not exist. " >> $LOG
			cp /config/crt/tuanduimao.lc.key /config/crt/$MAIN_HOST.key
		fi

		if [ ! -f "/config/crt/$MAIN_HOST.crt" ]; then 
			echo "/config/crt/$MAIN_HOST.crt not exist. " >> $LOG
			cp /config/crt/tuanduimao.lc.crt /config/crt/$MAIN_HOST.crt
		fi

		rm -f "/config/web/nginx/vhost/enable/$MAIN_HOST*"
		ln -s "/config/web/nginx/vhost/$MAIN_HOST.fwd" "/config/web/nginx/vhost/enable/$MAIN_HOST.fwd"
		ln -s "/config/web/nginx/vhost/$MAIN_HOST.ssl" "/config/web/nginx/vhost/enable/$MAIN_HOST.ssl"

	else
		ln -s "/config/nginx/vhost/$MAIN_HOST" "/config/nginx/vhost/enable/$MAIN_HOST"
	fi

	rm -f "/config/web/nginx/vhost/enable/tuanduimao.lc"
	rm -f "/config/web/nginx/vhost/enable/tuanduimao.lc.ssl"
	rm -f "/config/web/nginx/vhost/enable/tuanduimao.lc.fwd"
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
	chown -R $USER:$GROUP /data/stor
fi

if [ ! -d "/data/stor/private" ]; then
	mkdir -p /data/stor/private
	chown -R $USER:$GROUP /data/stor
fi

if [ ! -d "/data/composer" ]; then
	mkdir -p /data/composer
	chown -R $USER:$GROUP /data/composer
fi

ug=$(ls -l /config/crt | awk '{print $3":"$4}')
if [ "$ug" != "$USER:$GROUP" ]; then
	chown -R $USER:$GROUP /config/crt
fi


# 启动 PHP-FPM
/opt/php7/sbin/php-fpm -c /config/web/php/php.ini  -y /config/web/php/fpm/php-fpm.conf >> $LOG

# 启动 Nginx
/opt/openresty/nginx/sbin/nginx -c /config/web/nginx/nginx.conf >> $LOG


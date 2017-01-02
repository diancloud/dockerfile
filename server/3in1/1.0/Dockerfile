## ===========================================
#  团队猫 DockerFile 
#  
#  Openresty 1.9.7.5 + PHP 7.0
#  
#  
#  @Name tuanduimao/openresty-php7:1.9.7.5
#  @Ver  1.9.7.5 PHP 7.0
#  @By Weiping <weiping@diancloud.com>
#  
#  
#  
#  USEAGE:
#  	  docker run -d \
#		 -v /host/logs:/logs  \
#		 -v /host/data:/data  \
#		 -v /host/config:/config  \
#		 -v /host/code:/code  \
#		 -p 85:80 \
#		 tuanduimao/openresty-php7-ioncube
#  	 
#  FROM:
#  	 FROM tuanduimao/openresty-php7-ioncube:1.9.7.5
#  	 
#  BUILD:
#     docker build -t tuanduimao/openresty-php7-ioncube:1.9.7.5  -t tuanduimao/openresty-php7-ioncube:latest .
#     
#     
#  PHP 编译参数: 
# 
#	./configure '--prefix=/opt/php7' '--with-config-file-path=/opt/php7/etc' '--enable-fpm' \
#		'--with-fpm-user=www' '--with-fpm-group=www' '--with-mysqli=mysqlnd' '--with-pdo-mysql=mysqlnd' 
#		'--with-iconv-dir' '--with-freetype-dir=/usr' '--with-libxml-dir=/usr' '--with-zlib' '--with-gd' 
#		'--with-jpeg-dir=/usr' '--with-png-dir=/usr' '--with-webp-dir=/usr' '--with-xpm-dir=/usr' 
#		'--with-curl' '--with-mcrypt' '--with-readline' '--with-openssl' '--with-xmlrpc' '--with-bz2' 
#		'--with-gettext' '--with-mysqli' '--with-mhash' '--enable-calendar' '--enable-dba' 
#		'--enable-exif' '--enable-fileinfo' '--enable-ftp' '--enable-sysvshm' '--enable-wddx' '--enable-xml' 
#		'--enable-bcmath' '--enable-shmop' '--enable-sysvsem' '--enable-sysvmsg' '--enable-inline-optimization' 
#		'--enable-mbregex' '--enable-mbstring' '--enable-pcntl' '--enable-sockets' '--enable-gd-native-ttf' '--enable-zip' 
#		'--enable-soap' '--enable-opcache' '--disable-rpath'
#
#  [PHP Modules]
#  bcmath、 bz2、 calendar、 Core、 ctype、 curl、 date、 dba、 dom、 exif、 fileinfo、 filter、 ftp、 gd、
#  gettext、 hash、 iconv、 json、 libxml、 mbstring、 mcrypt、 mysqli、 mysqlnd、 openssl、 pcntl、 pcre、 
#  PDO、 pdo_mysql、 pdo_sqlite、 Phar、 posix、 readline、 redis、 Reflection、 session、 shmop、 SimpleXML、 
#  soap、 sockets、 SPL、 sqlite3、 standard、 sysvmsg、 sysvsem、 sysvshm、 tokenizer、 wddx、 xml、 
#  xmlreader、 xmlrpc、 xmlwriter、 Zend OPcache、 zip、 zlib
#  
#  [Zend Modules]
#  Zend OPcache
#  
#  TEST:
#     docker build -t tuanduimao/openresty-php7-ioncube:latest .
#     docker run --rm -it tuanduimao/openresty-php7-ioncube  /bin/sh
#     
#     
#  	  docker run --rm -it  \
#  	  		 -v /home/vagrant/test/http/logs:/logs  \
#  	  		 -v /home/vagrant/test/http/data:/data  \
#  	  		 -v /home/vagrant/test/http/config:/config  \
#  	  		 -v /home/vagrant/test/http/code:/code  \
#  	  		 -p 85:80 \
#  	  		 tuanduimao/openresty-php7  /bin/sh
#  	  
# ===========================================

#FROM tuanduimao/alpine:latest
FROM tuanduimao/ubuntu:16.04
MAINTAINER diancloud.com <dev@diancloud.com>

VOLUME ["/run","/data", "/code", "/logs", "/config"]
ENV PATH=${PATH}:/opt/php7/bin:/opt/php7/sbin:/opt/openresty/bin:/opt/openresty/nginx/sbin \
	CONF=default 

# ADD sources.list /etc/apt/sources.list
ADD config /defaults/config
ADD start.sh /start.sh

RUN cd /tmp  && \
	apt-get update  && \
	apt-get install -y vim libreadline-dev libncurses5-dev libpcre3-dev \
	ca-certificates  \
	libxml2-dev wget perl make gcc g++  libxpm-dev \
	automake autoconf libtool binutils \
	libc-client2007e libc-client2007e-dev libkrb5-dev \
    libcurl4-openssl-dev libgnutls-dev libssl-dev perl make build-essential  \
    libmcrypt-dev bash  bzip2  libpng-dev libbz2-dev libfreetype6-dev libwebp-dev libjpeg-dev gettext  && \

	#apk update && \
	# 
	# 编译环境 下载工具
	# 
    #apk add --no-cache --virtual=build-dependencies ca-certificates pcre-dev openssl-dev \
    #	libxml2-dev wget perl make gcc g++ libcurl curl-dev gd gd-dev  libpng libpng-dev libwebp libwebp-dev libxpm libxpm-dev  \
    #	readline-dev freetype freetype-dev automake autoconf libtool binutils  \
    #	libjpeg  libjpeg-turbo-dev libmcrypt libmcrypt-dev bash libintl bzip2 bzip2-dev  gettext  gettext-dev && \
    # export DOWN="http://dockerfile.tuanduimao.com/openresty/1.9.7.5/download" && \
    export DOWN="https://github.com/diancloud/dockerfile/raw/master/openresty/1.9.7.5/download" && \
    # 
    # 下载编译安装 openresty
    # 
    wget -q "$DOWN/openresty-1.9.7.5.tar.gz"  && \
    tar xfz openresty-1.9.7.5.tar.gz  && \
    cd openresty-1.9.7.5 && \
    CFLAGS="-O3 -fPIC"  ./configure --with-luajit --prefix=/opt/openresty && \
    make && \
    make install  && \
    # 
    # 下载编译安装 mhash
    #
    cd /tmp && \ 
    wget -q "$DOWN/mhash-0.9.9.9.tar.gz"  && \
    tar xfz mhash-0.9.9.9.tar.gz  && \
    cd mhash-0.9.9.9 && \
    CFLAGS="-O3 -fPIC"  ./configure --prefix=/usr && \
    make && \
    make install  && \
    #
    # 下载编译安装 REDIS 
    #
    wget -q "$DOWN/redis-3.2.2.tar.gz"  && \
    tar xfz redis-3.2.2.tar.gz  && \
    cd redis-3.2.2 && \
    make MALLOC=libc && \
    make install && \
    #
    # 安装 MySQL 
    #
    # 
    # 下载编译安装 PHP7
    # 
    cd /tmp && \
    wget -q "$DOWN/php-7.0.9.tar.gz"  && \
    tar xfz php-7.0.9.tar.gz && \
    cd php-7.0.9  && \
    CFLAGS="-O3 -fPIC" ./configure --prefix=/opt/php7 \
	--with-config-file-path=/opt/php7/etc \
	--enable-fpm \
	--with-fpm-user=www \
	--with-fpm-group=www \
	--with-mysqli=mysqlnd \
	--with-pdo-mysql=mysqlnd \
	--with-iconv-dir \
	--with-freetype-dir=/usr \
	--with-libxml-dir=/usr \
	--with-zlib \
	--with-gd \
	--with-jpeg-dir=/usr --with-png-dir=/usr --with-webp-dir=/usr  --with-xpm-dir=/usr --enable-gd-native-ttf \
	--with-curl \
	--with-mcrypt \
	--with-readline \
	--with-openssl \
	--with-xmlrpc \
	--with-bz2 \
	--with-gettext \
	--with-mysqli \
	--with-mhash \
	--with-imap  \
	--with-imap-ssl \
	--with-kerberos \
	--enable-calendar \
	--enable-dba \
	--enable-exif \
	--enable-fileinfo \
	--enable-ftp \
	--enable-sysvsem \
	--enable-sysvshm \
	--enable-wddx \
	--enable-xml \
	--enable-bcmath \
	--enable-shmop \
	--enable-sysvsem \
	--enable-sysvmsg \
	--enable-inline-optimization \
	--enable-gd-native-ttf \
	--enable-mbregex \
	--enable-mbstring \
	--enable-pcntl \
	--enable-sockets \
	--enable-gd-native-ttf \
	--enable-zip \
	--enable-soap \
	--enable-opcache \
	--disable-rpath && \
	make && make install && \
	cp /tmp/php-7.0.9/php.ini-production  /opt/php7/etc/php.ini && \
	#
	# Load zend_extension=ioncube_loader_lin_7.0.so
	#
	echo ";ioncube_loader" >>  /opt/php7/etc/php.ini && \
	echo "zend_extension=ioncube_loader_lin_7.0.so" >>  /opt/php7/etc/php.ini && \
	#
	# 
	#
	echo ";opcache-ext" >>  /opt/php7/etc/php.ini && \
	echo "zend_extension=opcache.so" >>  /opt/php7/etc/php.ini && \
	#
	# 下载编译安装Redis 扩展
	#
	cd /tmp && \
    wget -q "$DOWN/phpredis-3.0.0.tar.gz"  && \
    tar xfz phpredis-3.0.0.tar.gz && \
    cd phpredis-3.0.0  && \
    /opt/php7/bin/phpize && \
    CFLAGS="-O3 -fPIC"  ./configure && \
    CFLAGS="-O3 -fPIC" make && make install && \
    echo ";redis-ext" >>  /opt/php7/etc/php.ini && \
	echo "extension=redis.so" >>  /opt/php7/etc/php.ini && \
	#
	# 下载编译安装XDebug 扩展
	#
	cd /tmp && \
    wget -q "$DOWN/xdebug-2.4.1.tgz"  && \
    tar xfz xdebug-2.4.1.tgz && \
    cd xdebug-2.4.1  && \
    /opt/php7/bin/phpize && \
    CFLAGS="-O3 -fPIC"  ./configure --enable-xdebug && \
    CFLAGS="-O3 -fPIC"  make && make install && \
    echo ";xdebug-ext" >>  /opt/php7/etc/php.ini && \
	echo "extension=xdebug.so" >>  /opt/php7/etc/php.ini && \
	# 
	# 添加WEB用户
	# 
	adduser www-data www-data && \
	# 
	# 清理无用文件
	#
	echo "Clean"  && \
	apt-get remove -y build-essential gcc make  && \
	rm -rf /tmp/*  \
		/usr/libexec/* \
		/usr/lib/gcc   \
		/usr/lib/perl5   \
   		/usr/lib/python2.7  \
   		/usr/include/* \
   		/usr/share/* \
   		/var/lib/* \
   		/opt/php7/bin/phpdbg \
   		/opt/php7/bin/php-cgi && \
   		   
	echo "Complete"

ADD extension/ioncube_loader_lin_7.0.so /opt/php7/lib/php/extensions/no-debug-non-zts-20151012/ioncube_loader_lin_7.0.so
EXPOSE 80 443 6379 3306
CMD ["sh", "/start.sh"]
## ===========================================
#  XpmSE DockerFile 
#  
#  Openresty 1.13.6.1 + PHP 7.3.0
#  升级 HttpServer 支持 Http2
#  
#  @Name xpmse/server:3in1
#  @Ver  1.13.6.1 PHP 7.3.0
#  @By Weiping <weiping@diancloud.com>
#  

#  USEAGE:
#  	  docker run -d \
#		 -v /host/logs:/logs  \
#		 -v /host/data:/data  \
#		 -v /host/config:/config  \
#		 -v /host/code:/code  \
#		 -p 85:80 \
#		 xpmse/server:3in1
#  	 
#  FROM:
#  	 FROM tuanduimao/ubuntu:16.04
#  	 
#  BUILD:
#     docker build -t xpmse/server:3in1  .
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
#		'--enable-soap' '--enable-opcache' '--disable-rpath' '--enable-apcu-bc'
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
#     docker build -t xpmse/server:3in1 .
#     docker run --rm -it xpmse/server:3in1  /bin/sh
#     
#     
#  	  docker run --rm -it  \
#  	  		 -v /home/vagrant/test/http/logs:/logs  \
#  	  		 -v /home/vagrant/test/http/data:/data  \
#  	  		 -v /home/vagrant/test/http/config:/config  \
#  	  		 -v /home/vagrant/test/http/code:/code  \
#  	  		 -p 85:80 \
#  	  		 xpmse/server:3in1  /bin/sh
#  	  
# ===========================================

FROM tuanduimao/ubuntu:16.04
LABEL maintainer="Max <max@diancloud.com>"

VOLUME ["/run","/data", "/code", "/logs", "/config"]
ENV PATH=${PATH}:/opt/php7/bin:/opt/php7/sbin:/opt/openresty/bin:/opt/openresty/nginx/sbin:/node/bin \
	CONF=default \
	USER=www-data \
	GROUP=www-data

# ADD sources.list /etc/apt/sources.list
ADD config /defaults
ADD start.mysql.sh /start/mysql.sh
ADD start.redis.sh /start/redis.sh
ADD start.web.sh /start/web.sh
ADD start.sh /start.sh

RUN cd /tmp  && \
	apt-get update  && \
	apt-get install -y vim libreadline-dev libncurses5-dev libpcre3-dev \
	ca-certificates  \
	ffmpeg \
    re2c \
    bison \
    apt-utils \
	libxml2-dev wget perl make gcc g++  libxpm-dev \
	automake autoconf libtool binutils \
	libc-client2007e libc-client2007e-dev libkrb5-dev \
	libmagickwand-dev \
    libcurl4-openssl-dev libgnutls-dev libssl-dev perl make build-essential  \
    libxrender1 libxtst6 libxi6 libnss3 libxss1 libatk-bridge2.0-0 libgtk-3-0 \
    libmcrypt-dev bash  bzip2  libpng-dev libbz2-dev libfreetype6-dev libwebp-dev libjpeg-dev gettext \
    libzip-dev \
    zip && \
	# 
	# 编译环境 下载工具
	# 
    #apk add --no-cache --virtual=build-dependencies ca-certificates pcre-dev openssl-dev \
    #	libxml2-dev wget perl make gcc g++ libcurl curl-dev gd gd-dev  libpng libpng-dev libwebp libwebp-dev libxpm libxpm-dev  \
    #	readline-dev freetype freetype-dev automake autoconf libtool binutils  \
    #	libjpeg  libjpeg-turbo-dev libmcrypt libmcrypt-dev bash libintl bzip2 bzip2-dev  gettext  gettext-dev && \
    # export DOWN="http://dockerfile.tuanduimao.com/openresty/1.9.7.5/download" && \
    export DOWN="https://github.com/diancloud/dockerfile/raw/master/download" && \
    # 
    # 下载编译安装 openresty
    #
    cd /tmp && \
    wget -q "$DOWN/openresty-1.13.6.1.tar.gz"  && \
    tar xfz openresty-1.13.6.1.tar.gz && \
    cd openresty-1.13.6.1 && \
    CFLAGS="-O3 -fPIC"  ./configure --prefix=/opt/openresty \
    --with-luajit \
    --with-http_v2_module \
    --with-http_dav_module \
    --with-http_flv_module \
    --with-http_mp4_module \
    --with-http_realip_module \
    --with-http_gzip_static_module && \
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
    wget -q "$DOWN/redis-4.2.0.tar.gz"  && \
    tar xfz redis-4.2.0.tar.gz  && \
    cd redis-3.2.2 && \
    make MALLOC=libc && \
    make install && \
    #
    # 下载编译安装 libxdiff
    #
    wget -q "$DOWN/libxdiff-0.22.tar.gz"  && \
    tar xfz libxdiff-0.22.tar.gz && \
    cd libxdiff-0.22 && \
    ./configure  && \
    make && \
    make install && \
    #
    # 安装 MySQL 
    # 
    # /etc/mysql/mariadb.conf.d
    # /etc/mysql/mariadb.conf.d/50-mysqld_safe.cnf  
    # /etc/mysql/mariadb.conf.d/50-server.cnf
    #
    apt-get install -y mariadb-server-10.0 && \
    # 
    # 下载编译安装 PHP7
    # 
    cd /tmp && \
    wget -q "$DOWN/php-7.3.0.tar.gz"  && \
    tar xfz php-7.3.0.tar.gz && \
    cd php-7.3.0  && \
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
	--with-jpeg-dir=/usr --with-png-dir=/usr --with-webp-dir=/usr  --with-xpm-dir=/usr \
	--with-curl \
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
	--enable-mbregex \
	--enable-mbstring \
	--enable-pcntl \
	--enable-sockets \
	--enable-zip \
	--enable-soap \
	--enable-opcache \
	--disable-rpath && \
	make && make install && \
	cp /tmp/php-7.3.0/php.ini-production  /opt/php7/etc/php.ini && \
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
	# 下载编译安装 imagick
	#
	cd /tmp && \
    wget -q "$DOWN/imagick-3.4.3.tgz"  && \
    tar xfz imagick-3.4.3.tgz && \
    cd imagick-3.4.3  && \
    export PKG_CONFIG_PATH=/opt/php7/bin/php-config && \
    /opt/php7/bin/phpize && \
    CFLAGS="-O3 -fPIC"  ./configure && \
    CFLAGS="-O3 -fPIC" make && make install && \
    echo ";imagick-ext" >>  /opt/php7/etc/php.ini && \
	echo "extension=imagick.so" >>  /opt/php7/etc/php.ini && \
	#
	# 下载编译安装 Swoole
	#
	cd /tmp && \
    wget -q "$DOWN/swoole-src-4.2.10.tar.gz"  && \
    tar xfz swoole-src-4.2.10.tar.gz && \
    cd swoole-src-4.2.10 && \
    /opt/php7/bin/phpize && \
    CFLAGS="-O3 -fPIC"  ./configure && \
    CFLAGS="-O3 -fPIC" make && make install && \
    echo ";swoole-ext" >>  /opt/php7/etc/php.ini && \
	echo "extension=swoole.so" >>  /opt/php7/etc/php.ini && \
	#
	# 下载编译安装XDebug 扩展
	#
	cd /tmp && \
    wget -q "$DOWN/xdebug-2.6.0.tgz"  && \
    tar xfz xdebug-2.6.0.tgz && \
    cd xdebug-2.6.0  && \
    /opt/php7/bin/phpize && \
    CFLAGS="-O3 -fPIC"  ./configure --enable-xdebug && \
    CFLAGS="-O3 -fPIC"  make && make install && \
    echo ";xdebug-ext" >>  /opt/php7/etc/php.ini && \
	echo "zend_extension=xdebug.so" >>  /opt/php7/etc/php.ini && \
    #
    # 下载编译安装Xdiff扩展
    #
    cd /tmp && \
    wget -q "$DOWN/xdiff-2.0.1.tgz"  && \
    tar xfz xdiff-2.0.1.tgz && \
    cd xdiff-2.0.1 && \
    /opt/php7/bin/phpize && \
    CFLAGS="-O3 -fPIC"  ./configure  && \
    CFLAGS="-O3 -fPIC"   make &&  make install && \
    echo ";xdiff-ext" >>  /opt/php7/etc/php.ini && \
	echo "extension=xdiff.so" >>  /opt/php7/etc/php.ini && \
    #
    # 下载编译安装Mcrypt扩展
    #
    cd /tmp && \
    wget -q "$DOWN/mcrypt-1.0.1.tgz"  && \
    tar xfz mcrypt-1.0.1.tgz && \
    cd mcrypt-1.0.1 && \
    /opt/php7/bin/phpize && \
    CFLAGS="-O3 -fPIC"  ./configure  && \
    CFLAGS="-O3 -fPIC"   make &&  make install && \
    echo ";mcrypt-ext" >>  /opt/php7/etc/php.ini && \
	echo "extension=mcrypt.so" >>  /opt/php7/etc/php.ini && \
    #
    # 下载编译安装Apcu扩展
    #
    cd /tmp && \
    wget -q "$DOWN/apcu-5.1.16.tgz"  && \
    tar xfz apcu-5.1.16.tgz && \
    cd apcu-5.1.16 && \
    /opt/php7/bin/phpize && \
    CFLAGS="-O3 -fPIC"  ./configure  && \
    CFLAGS="-O3 -fPIC"   make &&  make install && \
    echo ";apcu-ext" >>  /opt/php7/etc/php.ini && \
	echo "extension=apcu.so" >>  /opt/php7/etc/php.ini && \
    #
    # 下载编译安装Apcu_bc扩展
    #
    cd /tmp && \
    wget -q "$DOWN/apcu_bc-1.0.4.tgz"  && \
    tar xfz apcu_bc-1.0.4.tgz && \
    cd apcu_bc-1.0.4 && \
    /opt/php7/bin/phpize && \
    CFLAGS="-O3 -fPIC"  ./configure  && \
    CFLAGS="-O3 -fPIC"   make &&  make install && \
    echo ";apc-ext" >>  /opt/php7/etc/php.ini && \
	echo "extension=apc.so" >>  /opt/php7/etc/php.ini && \
	# 
	# 添加WEB用户
	# 
	adduser www-data www-data && \
	chmod +x /start.sh && chmod +x /start/* && \
	#
	# 安装 NodeJS
	#
	cd /tmp && \
	wget https://nodejs.org/dist/v8.9.4/node-v8.9.4-linux-x64.tar.xz  && \
	tar xvf  node-v8.9.4-linux-x64.tar.xz  && \
	mv node-v8.9.4-linux-x64  /node && \
	npm install -g cnpm --registry=https://registry.npm.taobao.org  && \
	cnpm install puppeteer --global && \
	#
	# 权限
	#
	mkdir -p /var/www/.config  && \
	chown -R www-data:www-data /var/www/.config  && \
	chmod -R 755 /node/lib/node_modules && \
	#
	# Fix Perl
	#
	mv /usr/bin/perl /usr/bin/perl.old && \
	ln -s /usr/bin/perl5.22-x86_64-linux-gnu /usr/bin/perl && \
	# 
	# 清理无用文件
	#
	echo "Clean"  && \
	rm -rf /tmp/* && \
	# apt-get remove -y build-essential gcc make  && \
	# rm -rf /tmp/*  \
	# 	/usr/libexec/* \
	# 	/usr/lib/gcc   \
	# 	/usr/lib/perl5   \
    #   /usr/lib/python2.7  \
    #   /usr/include/* \
    #   /var/lib/* \
    #   /opt/php7/bin/phpdbg \
    #   /opt/php7/bin/php-cgi && \
	echo "Complete"

#ADD extension/ioncube_loader_lin_7.0.so /opt/php7/lib/php/extensions/no-debug-non-zts-20151012/ioncube_loader_lin_7.0.so
EXPOSE 80 443 6379 3306
CMD ["sh", "/start.sh"]
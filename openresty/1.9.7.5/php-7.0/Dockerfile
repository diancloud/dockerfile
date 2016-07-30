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
#		 tuanduimao/openresty-php7
#  	 
#  FROM:
#  	 FROM tuanduimao/openresty-php7:1.9.7.5
#  	 
#  BUILD:
#     docker build -t tuanduimao/openresty-php7:1.9.7.5  -t tuanduimao/openresty-php7:latest .
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
#     docker build -t tuanduimao/openresty-php7:latest .
#     docker run --rm -it tuanduimao/openresty-php7  /bin/sh
#     
#     
#  	  docker run --rm -it  \
#  	  		 -v /home/vagrant/code/dockerfile/openresty/1.9.7.5/php-7.0/test/logs:/logs  \
#  	  		 -v /home/vagrant/code/dockerfile/openresty/1.9.7.5/php-7.0/test/data:/data  \
#  	  		 -v /home/vagrant/code/dockerfile/openresty/1.9.7.5/php-7.0/test/config:/config  \
#  	  		 -v /home/vagrant/code/dockerfile/openresty/1.9.7.5/php-7.0/test/code:/code  \
#  	  		 -p 85:80 \
#  	  		 tuanduimao/openresty-php7  /bin/sh
#  	  
# ===========================================

FROM tuanduimao/alpine:latest
MAINTAINER diancloud.com <dev@diancloud.com>

VOLUME ["/run","/data", "/code", "/logs", "/config"]
ENV PATH=${PATH}:/opt/php7/bin:/opt/php7/sbin:/opt/openresty/bin:/opt/openresty/nginx/sbin \
	CONF=default 

ADD config /defaults/config
ADD start.sh /start.sh

RUN cd /tmp  && \
	apk update && \
	# 
	# 编译环境 下载工具
	# 
    apk add --no-cache --virtual=build-dependencies ca-certificates pcre-dev openssl-dev \
    	libxml2-dev wget perl make gcc g++ libcurl curl-dev gd gd-dev  libpng libpng-dev libwebp libwebp-dev libxpm libxpm-dev  \
    	readline-dev freetype freetype-dev automake autoconf libtool binutils  \
    	libjpeg  libjpeg-turbo-dev libmcrypt libmcrypt-dev bash libintl bzip2 bzip2-dev  gettext  gettext-dev&& \
    export DOWN="http://dockerfile.tuanduimao.com/openresty/1.9.7.5/download" && \
    # 
    # 下载编译安装 openresty
    # 
    wget -q "$DOWN/openresty-1.9.7.5.tar.gz"  && \
    tar xfz openresty-1.9.7.5.tar.gz  && \
    cd openresty-1.9.7.5 && \
    ./configure --with-luajit --prefix=/opt/openresty && \
    make && \
    make install  && \
    # 
    # 下载编译安装 mhash
    #
    cd /tmp && \ 
    wget -q "$DOWN/mhash-0.9.9.9.tar.gz"  && \
    tar xfz mhash-0.9.9.9.tar.gz  && \
    cd mhash-0.9.9.9 && \
    ./configure --prefix=/usr && \
    make && \
    make install  && \
    # 
    # 下载编译安装 PHP7
    # 
    cd /tmp && \
    wget -q "$DOWN/php-7.0.9.tar.gz"  && \
    tar xfz php-7.0.9.tar.gz && \
    cd php-7.0.9  && \
    ./configure --prefix=/opt/php7 \
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
	--disable-rpath  && \
	make && make install && \
	cp /tmp/php-7.0.9/php.ini-production  /opt/php7/etc/php.ini && \
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
    ./configure && \
    make && make install && \
    echo ";redis-ext" >>  /opt/php7/etc/php.ini && \
	echo "extension=redis.so" >>  /opt/php7/etc/php.ini && \
	# 
	# 添加WEB用户
	# 
	adduser www-data www-data -D -s/sbin/nologin && \
	# 
	# 清理无用文件
	#
	echo "Clean"  && \
	apk del python && \
	rm -rf /tmp/*  \
		   /usr/libexec/* \
		   /usr/lib/gcc   \
		   /usr/lib/perl5   \
   		   /usr/lib/python2.7  \
   		   /usr/include/* \
   		   /usr/share/* \
   		   /opt/php7/bin/phpdbg \
   		   /opt/php7/bin/php-cgi && \

	echo "Complete"
	
EXPOSE 80
CMD ["sh", "/start.sh"]
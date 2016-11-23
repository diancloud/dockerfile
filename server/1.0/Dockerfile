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
#		 tuanduimao/server
#  	 
#  FROM:
#  	 FROM tuanduimao/server:1.0
#  	 
#  BUILD:
#     docker build -t tuanduimao/server:1.0  -t tuanduimao/server:latest .
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
#     docker build -t tuanduimao/server:latest .
#     docker run --rm -it tuanduimao/tuanduimao  /bin/bash
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
FROM tuanduimao/openresty-php7-ioncube:latest
MAINTAINER diancloud.com <dev@diancloud.com>

VOLUME ["/run","/data", "/apps", "/logs", "/config"]
ENV PATH=${PATH}:/opt/php7/bin:/opt/php7/sbin:/opt/openresty/bin:/opt/openresty/nginx/sbin \
	CONF=default \
	HOST=tuanduimao.lc \
	TUANDUIMAO_VERSION=0.9rc \
	_TDM_CONFIG_ROOT=/data  \
	REDIS_HOST=redis-host \
	REDIS_PORT=6379 \
	REDIS_SOCKET= \
	REDIS_USER= \
	REDIS_PASS=

ADD config /defaults/config
ADD config /code
ADD start.sh /start.sh
ADD tdm /bin/tdm
ADD composer.phar /bin/composer

RUN chmod +x /start.sh  && \
	chmod +x /bin/tdm  && \
	chmod +x /bin/composer  && \
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

EXPOSE 80 443
CMD ["sh", "/start.sh"]
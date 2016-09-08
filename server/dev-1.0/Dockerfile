## ===========================================
#  团队猫 DockerFile 
#  
#  Openresty 1.9.7.5 + PHP 7.0  ( With Tuanduimao develop config files )
#  
#  
#  @Name tuanduimao/server-dev:1.0
#  @Ver  Openresty 1.9.7.5 PHP 7.0 ( With Tuanduimao develop config files )
#  @By Weiping <weiping@diancloud.com>
#  
#  USEAGE:
#  	  docker run -d \
#  	     --add-host redis-host:172.17.0.1 \
#        --add-host admin.tuanduimao.lc:172.17.0.1 \
#        --add-host apps.tuanduimao.lc:172.17.0.1 \
#        --add-host cdn.tuanduimao.lc:172.17.0.1 \
#        --add-host ui.tuanduimao.lc:172.17.0.1 \
#		 -v /host/logs:/logs  \
#		 -v /host/data:/data  \
#		 -v /host/config:/config  \
#		 -v /host/code:/code:ro  \
#		 -p 85:80 \
#		 tuanduimao/server-dev
#  	 
#  FROM:
#  	 FROM tuanduimao/server-dev:1.0
#  	 
#  BUILD:
#     docker build -t tuanduimao/server-dev:1.0  -t tuanduimao/server-dev:latest .
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
#     docker build -t tuanduimao/server-dev:latest .
#     docker run  --rm -it  --name setest \
#        --add-host redis-host:172.17.0.1 \
#        --add-host admin.tuanduimao.lc:172.17.0.1 \
#        --add-host apps.tuanduimao.lc:172.17.0.1 \
#        --add-host cdn.tuanduimao.lc:172.17.0.1 \
#        --add-host ui.tuanduimao.lc:172.17.0.1 \
#        -v /Users/wangweiping/Docker/tuanse/logs:/logs  \
#        -v /Users/wangweiping/Docker/tuanse/data:/data  \
#        -v /Users/wangweiping/Docker/tuanse/config:/config  \
#        -v /Users/wangweiping/Docker/tuanse/code:/code:ro  \
#        -p 85:80 \
#        tuanduimao/server-dev  /bin/bash
#        
#     docker exec -it setest /bin/bash
# ===========================================

FROM tuanduimao/openresty-php7:latest
MAINTAINER diancloud.com <dev@diancloud.com>

VOLUME ["/run","/data", "/code", "/logs", "/config"]
ENV PATH=${PATH}:/opt/php7/bin:/opt/php7/sbin:/opt/openresty/bin:/opt/openresty/nginx/sbin \
	CONF=tuanduimao-dev \
	MAIN_HOST=tuanduimao.lc \
	TUANDUIMAO_VERSION=1.0.50 \
	REDIS_HOST=redis-host \
	REDIS_PORT=6379 \
	REDIS_SOCKET= \
	REDIS_USER= \
	REDIS_PASS=

ADD config /defaults/config
ADD start.sh /start.sh
ADD tdm /bin/tdm
ADD composer.phar /bin/composer

RUN chmod +x /start.sh && \
	chmod +x /bin/composer && \
	chmod +x /bin/tdm 

EXPOSE 80
CMD ["sh", "/start.sh"]
## ===========================================
#  Jianmo.ink DockerFile 
#  
#  Openresty 1.13.6.1 + PHP 7.1.16 
#  
#  @Name jianmo/server:runtime
#  @Ver  1.13.6.1 PHP 7.1.26
#  @By Max <https://github.com/trheyi>
#  
#  USEAGE:
#  	  docker run -d  -p 443:443 -p 80:80  -p 6379:6379 -p 3306:3306 jianmo/server:runtime 

#  FROM:
#  	 FROM jianmo/ubuntu:16.04
#  	 
#  BUILD:
#     docker build -t jianmo/server:runtime  .
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
#  xmlreader、 xmlrpc、 xmlwriter、 Zend OPcache、 zip、 zlib yaml xdiff
#  
#  [Zend Modules]
#  Zend OPcache
#  
#  TEST:
#     docker run --rm -it jianmo/server:runtime  /bin/bash
#     docker run --rm -it -p 80:80 -p 443:443 -p 6379:6379 -p 3306:3306 jianmo/server:runtime  /bin/bash
#  	  
# ===========================================

FROM jianmo/base
LABEL maintainer="JianMo <https://www.JianMo.ink>"

# VOLUME ["/run","/data", "/code", "/logs", "/config", "/apps"]
ENV PATH=${PATH}:/opt/php7/bin:/opt/php7/sbin:/opt/openresty/bin:/opt/openresty/nginx/sbin:/node/bin \
	CONF=default \
	USER=www-data \
	GROUP=www-data

ADD config /defaults
ADD start.mysql.sh /start/mysql.sh
ADD start.redis.sh /start/redis.sh
ADD start.web.sh /start/web.sh
ADD start.sh /start.sh
RUN chmod +x  /start.sh && chmod +x /start/*.sh
EXPOSE 80 443 6379 3306
CMD ["sh", "/start.sh"]
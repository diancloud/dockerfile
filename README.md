团队猫 Dockerfile
==============================


## MySQL

## Elasticsearch

```bash
docker run -d \
	 -v /host/logs:/logs  \
	 -v /host/data:/data  \
	 -v /host/config:/config  \
	 -p 92:9200 -p 93:9300 \
	 tuanduimao/elasticsearch
````
目录说明

```
/logs  日志文件目录
/data  索引数据存放位置 （ 可在 elasticsearch.yml 中定义 ）
/config 配置文件目录
```


HQ 管理器
```
  http://yourhost:92/_plugin/hq/
```

SQL 查询插件
```
  http://yourhost:92/_plugin/sql/
```

中文分词配置
```
/config/ik/*
```


## Redis

## WebServer  ( OpenResty + PHP7 )

```bash
docker run -d \
    -v /host/logs:/logs  \
    -v /host/data:/data  \
    -v /host/config:/config  \
    -v /host/code:/code  \
    -p 8080:80 \
    tuanduimao/openresty-php7
```


目录说明
```
/logs  日志文件目录
/data  程序产生数据数据存放位置
/code  PHP程序目录 (只读)
/config 配置文件目录
```

访问地址
```
  http://yourhost:8080/
```

PHP 编译参数: 
```bash
./configure '--prefix=/opt/php7' '--with-config-file-path=/opt/php7/etc' '--enable-fpm' \
	'--with-fpm-user=www' '--with-fpm-group=www' '--with-mysqli=mysqlnd' '--with-pdo-mysql=mysqlnd' 
	'--with-iconv-dir' '--with-freetype-dir=/usr' '--with-libxml-dir=/usr' '--with-zlib' '--with-gd' 
	'--with-jpeg-dir=/usr' '--with-png-dir=/usr' '--with-webp-dir=/usr' '--with-xpm-dir=/usr' 
	'--with-curl' '--with-mcrypt' '--with-readline' '--with-openssl' '--with-xmlrpc' '--with-bz2' 
	'--with-gettext' '--with-mysqli' '--with-mhash' '--enable-calendar' '--enable-dba' 
	'--enable-exif' '--enable-fileinfo' '--enable-ftp' '--enable-sysvshm' '--enable-wddx' '--enable-xml' 
	'--enable-bcmath' '--enable-shmop' '--enable-sysvsem' '--enable-sysvmsg' '--enable-inline-optimization' 
	'--enable-mbregex' '--enable-mbstring' '--enable-pcntl' '--enable-sockets' '--enable-gd-native-ttf' '--enable-zip' 
	'--enable-soap' '--enable-opcache' '--disable-rpath'
```

[PHP Modules]
```bash
bcmath、 bz2、 calendar、 Core、 ctype、 curl、 date、 dba、 dom、 exif、 fileinfo、 filter、 ftp、 gd、
gettext、 hash、 iconv、 json、 libxml、 mbstring、 mcrypt、 mysqli、 mysqlnd、 openssl、 pcntl、 pcre、 
PDO、 pdo_mysql、 pdo_sqlite、 Phar、 posix、 readline、 redis、 Reflection、 session、 shmop、 SimpleXML、 
soap、 sockets、 SPL、 sqlite3、 standard、 sysvmsg、 sysvsem、 sysvshm、 tokenizer、 wddx、 xml、 
xmlreader、 xmlrpc、 xmlwriter、 Zend OPcache、 zip、 zlib
```

[Zend Modules]
```bash
Zend OPcache
```



## Sentry ( 可选 )

## Other

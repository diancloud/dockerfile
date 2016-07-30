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
/data  程序产生数据存放目录
/code  PHP程序目录 (只读)
/config 配置文件目录
```

访问地址
```
  http://yourhost:8080/
```

环境信息
```
Nginx: 1.9.7
PHP: 7.0.9
User: www-data
Group: www-data
```

PHP 参数:  `CFLAGS="-O3 -fPIC"`
```bash
./configure --prefix=/opt/php7 --with-config-file-path=/opt/php7/etc --enable-fpm 
	--with-fpm-user=www --with-fpm-group=www --with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd 
	--with-iconv-dir --with-freetype-dir=/usr --with-libxml-dir=/usr --with-zlib --with-gd 
	--with-jpeg-dir=/usr --with-png-dir=/usr --with-webp-dir=/usr --with-xpm-dir=/usr 
	--with-curl --with-mcrypt --with-readline --with-openssl --with-xmlrpc --with-bz2 
	--with-gettext --with-mysqli --with-mhash --enable-calendar --enable-dba 
	--enable-exif --enable-fileinfo --enable-ftp --enable-sysvshm --enable-wddx --enable-xml 
	--enable-bcmath --enable-shmop --enable-sysvsem --enable-sysvmsg --enable-inline-optimization 
	--enable-mbregex --enable-mbstring --enable-pcntl --enable-sockets --enable-gd-native-ttf 
	--enable-zip --enable-soap --enable-opcache --disable-rpath
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


Nginx 参数:
```
./configure  --prefix=/opt/openresty/nginx --with-cc-opt=-O2 --add-module=../ngx_devel_kit-0.2.19 
	--add-module=../echo-nginx-module-0.58 --add-module=../xss-nginx-module-0.05 
	--add-module=../ngx_coolkit-0.2rc3 
	--add-module=../set-misc-nginx-module-0.30 --add-module=../form-input-nginx-module-0.11 
	--add-module=../encrypted-session-nginx-module-0.04 --add-module=../srcache-nginx-module-0.30 
	--add-module=../ngx_lua-0.10.2 --add-module=../ngx_lua_upstream-0.05 
	--add-module=../headers-more-nginx-module-0.29 
	--add-module=../array-var-nginx-module-0.05 --add-module=../memc-nginx-module-0.16 
	--add-module=../redis2-nginx-module-0.12 --add-module=../redis-nginx-module-0.3.7 
	--add-module=../rds-json-nginx-module-0.14 --add-module=../rds-csv-nginx-module-0.07 
	--with-ld-opt=-Wl,-rpath,/opt/openresty/luajit/lib 
	--with-http_ssl_module
```

## Sentry ( 可选 )

## Other

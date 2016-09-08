团队猫 Dockerfile
==============================


## MySQL
```bash
docker run -d \
	 -v /host/logs:/logs  \
	 -v /host/data:/data  \
	 -v /host/config:/config  \
	 -p 127.0.0.1:33060:3306 \
	 tuanduimao/mysql
```


目录说明
```
/logs   日志目录
/data   数据目录
/config 配置文件目录
```

环境信息
```
MySQL: Mariadb 10.1.14 ( http://www.mariadb.org/)
User: mysql
Group: mysql
```

管理工具 `my`
```
docker exec your_doker_name my

my cu username <hostname> -  新增一个MySQL用户。返回新用户密码
my du username <hostname>   -  删除一个MySQL用户
my cd database <username> <hostname>   -  创建一个数据库。可同时设定该数据库的管理员（管理员拥有该库所有权限） 
my dd database  -  删除一个数据库
my pd database username <hostname>  - 设定数据库的管理员（管理员拥有该库所有权限） 
my cud database username  <hostname>   - 创建一个数据库，同时创建一个用户作为该数据管理员。 返回新用户密码
my dud database username  <hostname>   - 删除一个数据，同时删除一个用户
my init  - 重新初始化数据（ /data 目录为空时有效 ）
my ld    - 列出所有数据库
my lu   - 列出所有用户
```

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

环境信息
```
jdk: java8-8u25
elasticsearch: 1.7.3
elasticsearch-ik: 1.4.1
elasticsearch-hq: 0.99.1
elasticsearch-sql: 1.4.6 ( #m )
```



## Redis
```bash
docker run -d \
	-v /host/logs:/logs  \
	-v /host/data:/data  \
	-v /host/config:/config  \
	-p 127.0.0.1:63790:6379 \
	tuanduimao/redis
```

目录说明
```
/logs  日志文件目录
/data  数据存放目录
/config 配置文件目录
```

环境信息
```
版本: 3.2.2
```


## WebServer  ( OpenResty + PHP7 )

```bash
docker run -d \
    -v /host/logs:/logs  \
    -v /host/data:/data  \
    -v /host/config:/config  \
    -v /host/code:/code:ro  \
    -p 8080:80 \
    tuanduimao/openresty-php7
```


目录说明
```
/logs  日志文件目录
/data  程序产生数据存放目录
/code  PHP程序目录 ( 建议只读挂载 )
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


## WebServer  ( 团队猫:开发环境 OpenResty + PHP7  )

```FROM tuanduimao/openresty-php7:latest```

```bash
docker run -d \
    --add-host redis-host:172.17.0.1 \
    --add-host admin.tuanduimao.lc:172.17.0.1 \
    --add-host apps.tuanduimao.lc:172.17.0.1 \
    --add-host cdn.tuanduimao.lc:172.17.0.1 \
    --add-host ui.tuanduimao.lc:172.17.0.1 \
	-v /host/logs:/logs  \
    -v /host/data:/data  \
    -v /host/config:/config  \
    -v /host/code:/code:ro  \
    -p 80:80 \
    tuanduimao/server-dev
```


目录说明
```
/logs  日志文件目录

/data  程序产生数据存放目录
	/data/composer  composer 文件夹
	/data/stor/public 存储文件夹 （公开)
	/data/stor/private 存储文件夹 （私密)

/code   PHP程序目录 ( 建议只读挂载, 启动前先检出代码 )
	/code/tuanduimao   团队猫程序目录
	/code/tuanapps/*   团队猫应用目录
	/code/tuanui	   团队猫UI组件目录

/config 配置文件目录
	/config/service  团队猫程序配置文件目录 ( default.inc.php & config.json )

```

环境变量
```
MAIN_HOST=tuanduimao.lc  主域名  admin.:后台, ui.:UI组件, apps.:应用, cdn.:图片
TUANDUIMAO_VERSION=1.0.50  当前版本

REDIS_HOST=redis-host  redis服务器地址
	REDIS_PORT=6379    redis服务器端口
	REDIS_SOCKET=      redis socket
	REDIS_USER=   	   redis user
	REDIS_PASS=   	   redis password

```


访问地址
```
  http://admin.tuanduimao.lc/
```


管理工具 `tdm`
```
docker exec your_doker_name tdm
tdm conf -  根据环境信息创建 default.inc.php 配置文件 
tdm composer - 运行 composer 
```





## Sentry ( 日志管理 )

```bash
docker run -d \
 -v /host/logs:/logs  \
 -v /host/data:/data  \
 -v /host/config:/config  \
 -p 9000:9000 \
 tuanduimao/sentry
```

目录说明
```
/logs  日志目录
/data  数据库目录
/config 配置文件目录
```


环境信息
```
Sentry: 8.6.0

管理员账号:  logs@tuanduimao.com
管理员密码:  logs1234 
```

访问地址
```bash
http://yourhost:9000/
```


## Other

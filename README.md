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


## Sentry ( 可选 )

## Other

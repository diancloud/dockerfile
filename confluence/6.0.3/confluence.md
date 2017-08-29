## 目录
/confluence
/data/confluence


## MySQL 5.5 
root 123456
CREATE DATABASE IF NOT EXISTS confluence DEFAULT CHARSET utf8 COLLATE utf8_general_ci;


## Confluence 6.0.3
Username: admin 
Name: Administrator
Email: zhuce@diancloud.com
Password: helloC1234

## 启动命令
service confluence restart

####
docker run -p 8090:8090 -p 8000:8000 --rm -it hub.c.163.com/trheyi/confluence-base:6.0.3 /bin/bash
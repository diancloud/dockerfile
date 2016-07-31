## ===========================================
#  团队猫 DockerFile 
#  
#  MySQL 10.1.14
#  
#  
#  @Name tuanduimao/mysql:10.1.14
#  @Ver  10.1.14
#  @By Weiping <weiping@diancloud.com>
#  
#  USEAGE:
#  	  docker run -d \
#		 -v /host/logs:/logs  \
#		 -v /host/data:/data  \
#		 -v /host/config:/config  \
#		 -p 127.0.0.1:33060:3306 \
#		 tuanduimao/mysql
#  	 
#  FROM:
#  	 FROM tuanduimao/mysql:10.1.14
#  	 
#  BUILD:
#     docker build -t tuanduimao/mysql:10.1.14  -t tuanduimao/mysql:latest .
#     
#  
#  TEST:
#     docker build -t tuanduimao/mysql:latest .
#     docker run --rm -it tuanduimao/mysql  /bin/sh
#     
#  	  docker run --rm -it  \
#  	  		 -v /home/vagrant/code/dockerfile/mysql/10.1.14/test/logs:/logs  \
#  	  		 -v /home/vagrant/code/dockerfile/mysql/10.1.14/test/data:/data  \
#  	  		 -v /home/vagrant/code/dockerfile/mysql/10.1.14/test/config:/config  \
#  	  		 -p 33060:3306 \
#  	  		 tuanduimao/mysql  /bin/sh
#  	  
# ===========================================

FROM tuanduimao/alpine:latest
MAINTAINER diancloud.com <dev@diancloud.com>

VOLUME ["/data", "/logs", "/config"]
ENV CONF=default
ADD config /defaults/config
ADD start.sh /start.sh
ADD my /bin/my

RUN cd /tmp  && \
	apk update  && \
  apk add mysql mysql-client && \
  chmod +x /bin/my && \
  rm -rf /tmp/*   \
  /var/cache/apk/* 

EXPOSE 3306
CMD ["sh", "/start.sh"]
   
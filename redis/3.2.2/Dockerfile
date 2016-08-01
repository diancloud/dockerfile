## ===========================================
#  团队猫 DockerFile 
#  
#  Redis 3.2.2
#  
#  
#  @Name tuanduimao/redis:3.2.2
#  @Ver  3.2.2
#  @By Weiping <weiping@diancloud.com>
#  
#  USEAGE:
#  	  docker run -d \
#		 -v /host/logs:/logs  \
#		 -v /host/data:/data  \
#		 -v /host/config:/config  \
#		 -p 127.0.0.1:63790:6379 \
#		 tuanduimao/redis
#  	 
#  FROM:
#  	 FROM tuanduimao/redis:3.2.2
#  	 
#  BUILD:
#     docker build -t tuanduimao/redis:3.2.2  -t tuanduimao/redis:latest .
#     
#  
#  TEST:
#     docker build -t tuanduimao/redis:latest .
#     docker run --rm -it tuanduimao/redis  /bin/sh
#     
#     
#  	  docker run --rm -it  \
#  	  		 -v /home/vagrant/test/redis/logs:/logs  \
#  	  		 -v /home/vagrant/test/redis/data:/data  \
#  	  		 -v /home/vagrant/test/redis/config:/config  \
#  	  		 -p 63790:6379 \
#  	  		 tuanduimao/redis  /bin/sh
#  	  
# ===========================================

FROM tuanduimao/alpine:latest
MAINTAINER diancloud.com <dev@diancloud.com>

VOLUME ["/data", "/logs", "/config"]
ENV CONF=default
ADD config /defaults/config
ADD start.sh /start.sh

RUN cd /tmp  && \
	apk update && \
	# 
	# 编译环境 下载工具
	# 
    apk add --no-cache --virtual=build-dependencies wget gcc g++ make  libtool libc-dev linux-headers  && \
    export DOWN="http://dockerfile.tuanduimao.com/redis/3.2.2/download" && \
    # 
    # 下载编译安装 redis
    # 
    wget -q "$DOWN/redis-3.2.2.tar.gz"  && \
    tar xfz redis-3.2.2.tar.gz  && \
    cd redis-3.2.2 && \
    make MALLOC=libc && \
    make install && \
    # 
	# 清理无用文件
	#
	echo "Clean"  && \
	apk del build-dependencies wget gcc g++ make  libtool libc-dev linux-headers && \
	rm -rf /tmp/*   && \
	echo "Complete"
	
EXPOSE 6379
CMD ["sh", "/start.sh"]
   
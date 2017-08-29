## ===========================================
#  团队猫 DockerFile 
#  
#  Confluence 6.0.3 ( 破解版 )
#  
#  @Name tuanduimao/confluence:6.0.3
#  @Version  6.0.3
#  @By Weiping <weiping@diancloud.com>
#  
#  
#  USEAGE:
#     docker run -d \
#        -p 8090:8090 -p 8000:8000 -p 3308:3306 \
#        hub.c.163.com/trheyi/confluence:6.0.3
#
#  	  docker run -d \
#		 -v /host/logs:/logs  \
#		 -v /host/data:/data  \
#		 -v /host/config:/config  \
#		 -p 8090:8090 -p 8000:8000 -p 3306:3306 \
#		 hub.c.163.com/trheyi/confluence:6.0.3
#  	 
#  FROM:
#  	 FROM hub.c.163.com/trheyi/confluence-base:6.0.3
#  	 
#  BUILD:
#     docker build -t hub.c.163.com/trheyi/confluence:6.0.3  .

#  	  
# ===========================================

FROM tuanduimao/confluence-base:6.0.3
MAINTAINER diancloud.com <dev@diancloud.com>

VOLUME ["/data", "/logs", "/config"]
ADD config /defaults/config
ADD start.sh /start.sh
ADD my /bin/my
ADD confluence.md /confluence.md

#安装 jdk-8u25
RUN chmod +x /bin/my && \

#启动脚本
	chmod +x /start.sh 								

EXPOSE 8090 8000 3306
CMD ["sh", "/start.sh"]

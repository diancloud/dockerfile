# ===========================================
#  团队猫 DockerFile 
#  
#  Linux alpine  
#  
#  @Name tuanduimao/alpine:3.4 
#  @Ver  3.4
#  @By Weiping <weiping@diancloud.com>
#  
#  
#  USEAGE:
#  	 docker pull tuanduimao/alpine:3.4
#  	 
#  FROM:
#  	 FROM tuanduimao/alpine:3.4 
#  	 
#  BUILD:
#     docker build -t tuanduimao/alpine:3.4 -t tuanduimao/alpine:latest .
#     
#  
# ===========================================

FROM alpine:3.4
MAINTAINER diancloud.com <dev@diancloud.com>
ADD Shanghai /etc/localtime
RUN echo "Asia/Shanghai" > /etc/timezone
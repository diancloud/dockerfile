# ===========================================
#  团队猫 DockerFile 
#  
#  Linux ubuntu  
#  
#  @Name tuanduimao/ubuntu:16.04
#  @Ver  3.4
#  @By Weiping <weiping@diancloud.com>
#  
#  
#  USEAGE:
#  	 docker pull tuanduimao/ubuntu:16.04
#  	 
#  FROM:
#  	 FROM tuanduimao/ubuntu:16.04
#  	 
#  BUILD:
#     docker build -t tuanduimao/ubuntu:16.04 -t tuanduimao/ubuntu:latest .
#     
#  
# ===========================================

FROM ubuntu:16.04
MAINTAINER diancloud.com <dev@diancloud.com>
ADD Shanghai /etc/localtime
RUN echo "Asia/Shanghai" > /etc/timezone
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
#  	 docker pull jianmo/ubuntu:16.04
#  	 
#  FROM:
#  	 FROM ubuntu:16.04
#  	 
#  BUILD:
#     docker build -t jianmo/ubuntu:16.04 -t jianmo/ubuntu:latest .
#     
#  
# ===========================================

FROM ubuntu:16.04
LABEL maintainer="Max <https://github.com/trheyi>"
ADD Shanghai /etc/localtime
RUN echo "Asia/Shanghai" > /etc/timezone
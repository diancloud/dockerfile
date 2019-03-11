# ===========================================
#  团队猫 DockerFile 
#  
#  Linux ubuntu  
#  
#  @Name jianmo/ubuntu:16.04
#  @Ver  3.4
#  @By Max <https://github.com/trheyi>
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
LABEL maintainer="JianMo <https://www.JianMo.ink>"
ADD Shanghai /etc/localtime
RUN echo "Asia/Shanghai" > /etc/timezone
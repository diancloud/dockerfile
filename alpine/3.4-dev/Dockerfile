# ===========================================
#  团队猫 DockerFile 
#  
#  Linux alpine build-dependencies
#  
#  @Name tuanduimao/alpine:3.4 
#  @Ver  3.4
#  @By Weiping <weiping@diancloud.com>
#  
#  
#  USEAGE:
#  	 docker pull tuanduimao/alpine:3.4-dev
#  	 
#  FROM:
#  	 FROM tuanduimao/alpine:3.4-dev
#  	 
#  BUILD:
#     docker build -t tuanduimao/alpine:3.4-dev .
#     
#  
# ===========================================


FROM tuanduimao/alpine:latest
MAINTAINER diancloud.com <dev@diancloud.com>

RUN apk update && \
	# 
	# 编译环境 下载工具
	# 
    apk add --no-cache --virtual=build-dependencies ca-certificates pcre-dev openssl-dev \
    	libxml2-dev wget perl make gcc g++ libcurl curl-dev gd gd-dev  libpng libpng-dev libwebp libwebp-dev libxpm libxpm-dev  \
    	readline-dev freetype freetype-dev automake autoconf libtool binutils  \
    	libjpeg  libjpeg-turbo-dev libmcrypt libmcrypt-dev bash libintl bzip2 bzip2-dev  gettext  gettext-dev
   
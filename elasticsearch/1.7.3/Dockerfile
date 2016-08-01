## ===========================================
#  团队猫 DockerFile 
#  
#  Elasticsearch 1.7.3 ( 修改版 )
#  
#  插件列表: 
#     elasticsearch-HQ 
#     elasticsearch-analysis-ik-1.4.1
#     elasticsearch-sql-1.4.5.6m
#  
#  @Name tuanduimao/elasticsearch:1.7.3 
#  @Ver  1.7.3
#  @By Weiping <weiping@diancloud.com>
#  
#  
#  USEAGE:
#  	  docker run -d \
#		 -v /host/logs:/logs  \
#		 -v /host/data:/data  \
#		 -v /host/config:/config  \
#		 -p 920:9200 -p 930:9300 \
#		 tuanduimao/elasticsearch
#  	 
#  FROM:
#  	 FROM tuanduimao/elasticsearch:1.7.3
#  	 
#  BUILD:
#     docker build -t tuanduimao/elasticsearch:1.7.3  -t tuanduimao/elasticsearch:latest .
#     
#  TEST:
#     docker build -t tuanduimao/elasticsearch:latest .
#     docker run --rm -it tuanduimao/elasticsearch  /bin/sh
#  	  docker run --rm -it  \
#  	  		 -v /home/vagrant/test/es/logs:/logs  \
#  	  		 -v /home/vagrant/test/es/data:/data  \
#  	  		 -v /home/vagrant/test/es/config:/config  \
#  	  		 -p 920:9200 \
#  	  		 tuanduimao/elasticsearch  /bin/sh
#  	  
# ===========================================

FROM tuanduimao/alpine:latest
MAINTAINER diancloud.com <dev@diancloud.com>

VOLUME ["/data", "/logs", "/config"]
ADD config /defaults/config
ADD start.sh /start.sh

ENV JAVA_HOME=/usr/lib/jvm/default-jvm/ \
    PATH=${PATH}:/usr/lib/jvm/default-jvm/bin:/elasticsearch/bin \
    MAVEN_HOME=/usr/share/maven

#安装 jdk-8u25
RUN cd /tmp                                                              && \
	apk update && \
    apk add --no-cache --virtual=build-dependencies ca-certificates wget && \
    export DOWN="http://dockerfile.tuanduimao.com/elasticsearch/1.7.3/download" && \
    export GLIBC_VERSION="2.23-r3"                                  && \
    export JAVA_PACKAGE="jdk"                                    && \
    export JAVA_UPDATE="25"                                      && \
    export JAVA_BUILD="17"                                        && \
    export GLIBC_URL="${DOWN}/glibc-${GLIBC_VERSION}" && \
    export GLIBC_APK="glibc-${GLIBC_VERSION}.apk"                        && \
    export GLIBC_BIN_APK="glibc-bin-${GLIBC_VERSION}.apk"                && \
    export JAVA_URL="${DOWN}" && \
    export JAVA_TGZ="${JAVA_PACKAGE}-8u${JAVA_UPDATE}-linux-x64.tar.gz"  && \
    export JAVA_HOME="/usr/lib/jvm/default-jvm"                          && \
    wget -q ${GLIBC_URL}/${GLIBC_APK}                                && \
    wget -q ${GLIBC_URL}/${GLIBC_BIN_APK}                            && \
    apk add --no-cache --allow-untrusted ${GLIBC_APK}                    && \
    apk add --no-cache --allow-untrusted ${GLIBC_BIN_APK}                && \
    echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf && \
    mkdir -p /usr/lib/jvm                                                && \
    cd /usr/lib/jvm 	&& \
    wget -qO- --header "Cookie: oraclelicense=accept-securebackup-cookie;" ${JAVA_URL}/${JAVA_TGZ} | tar -xzf -  && \
    mv  jdk1.8.0_25 java-8-oracle &&    \
    ln -s java-8-oracle $JAVA_HOME                                       && \
    rm -rf $JAVA_HOME/*src.zip                                           && \
    rm -rf \
            ${JAVA_HOME}/*/javaws \
            ${JAVA_HOME}/*/jjs \
            ${JAVA_HOME}/*/keytool \
            ${JAVA_HOME}/*/orbd \
            ${JAVA_HOME}/*/pack200 \
            ${JAVA_HOME}/*/policytool \
            ${JAVA_HOME}/*/rmid \
            ${JAVA_HOME}/*/rmiregistry \
            ${JAVA_HOME}/*/servertool \
            ${JAVA_HOME}/*/tnameserv \
            ${JAVA_HOME}/*/unpack200 \
            ${JAVA_HOME}/*/*javafx* \
            ${JAVA_HOME}/*/*jfx* \
            ${JAVA_HOME}/*/amd64/libdecora_sse.so \
            ${JAVA_HOME}/*/amd64/libfxplugins.so \
            ${JAVA_HOME}/*/amd64/libglass.so \
            ${JAVA_HOME}/*/amd64/libgstreamer-lite.so \
            ${JAVA_HOME}/*/amd64/libjavafx*.so \
            ${JAVA_HOME}/*/amd64/libjfx*.so \
            ${JAVA_HOME}/*/amd64/libprism_*.so \
            ${JAVA_HOME}/*/deploy* \
            ${JAVA_HOME}/*/desktop \
            ${JAVA_HOME}/*/ext/jfxrt.jar \
            ${JAVA_HOME}/*/ext/nashorn.jar \
            ${JAVA_HOME}/*/javaws.jar \
            ${JAVA_HOME}/*/jfr \
            ${JAVA_HOME}/*/jfr \
            ${JAVA_HOME}/*/jfr.jar \
            ${JAVA_HOME}/*/missioncontrol \
            ${JAVA_HOME}/*/oblique-fonts \
            ${JAVA_HOME}/*/plugin.jar \
            ${JAVA_HOME}/*/visualvm \
            ${JAVA_HOME}/man \
            ${JAVA_HOME}/plugin \
            ${JAVA_HOME}/*.txt \
            ${JAVA_HOME}/*/*/javaws \
            ${JAVA_HOME}/*/*/jjs \
            ${JAVA_HOME}/*/*/keytool \
            ${JAVA_HOME}/*/*/orbd \
            ${JAVA_HOME}/*/*/pack200 \
            ${JAVA_HOME}/*/*/policytool \
            ${JAVA_HOME}/*/*/rmid \
            ${JAVA_HOME}/*/*/rmiregistry \
            ${JAVA_HOME}/*/*/servertool \
            ${JAVA_HOME}/*/*/tnameserv \
            ${JAVA_HOME}/*/*/unpack200 \
            ${JAVA_HOME}/*/*/*javafx* \
            ${JAVA_HOME}/*/*/*jfx* \
            ${JAVA_HOME}/*/*/amd64/libdecora_sse.so \
            ${JAVA_HOME}/*/*/amd64/libfxplugins.so \
            ${JAVA_HOME}/*/*/amd64/libglass.so \
            ${JAVA_HOME}/*/*/amd64/libgstreamer-lite.so \
            ${JAVA_HOME}/*/*/amd64/libjavafx*.so \
            ${JAVA_HOME}/*/*/amd64/libjfx*.so \
            ${JAVA_HOME}/*/*/amd64/libprism_*.so \
            ${JAVA_HOME}/*/*/deploy* \
            ${JAVA_HOME}/*/*/desktop \
            ${JAVA_HOME}/*/*/ext/jfxrt.jar \
            ${JAVA_HOME}/*/*/ext/nashorn.jar \
            ${JAVA_HOME}/*/*/javaws.jar \
            ${JAVA_HOME}/*/*/jfr \
            ${JAVA_HOME}/*/*/jfr \
            ${JAVA_HOME}/*/*/jfr.jar \
            ${JAVA_HOME}/*/*/missioncontrol \
            ${JAVA_HOME}/*/*/oblique-fonts \
            ${JAVA_HOME}/*/*/plugin.jar \
            ${JAVA_HOME}/*/*/visualvm \
            ${JAVA_HOME}/*/man \
            ${JAVA_HOME}/*/plugin \
            ${JAVA_HOME}/*.txt \
                                                                         && \
#安装Manven
	# cd /usr/share  &&  \
	# wget -q "${DOWN}/apache-maven-3.3.3-bin.tar.gz" && \
	# tar xzf apache-maven-3.3.3-bin.tar.gz && \
	# mv /usr/share/apache-maven-3.3.3 /usr/share/maven && \
 # 	ln -s /usr/share/maven/bin/mvn /usr/bin/mvn \ 
 # 														&& \
#安装 Elasticsearch 1.7.3
    cd /tmp && \
    wget -q "${DOWN}/elasticsearch-1.7.3.tar.gz"     && 	\
    tar xzf elasticsearch-1.7.3.tar.gz  && \
    mv elasticsearch-1.7.3  /elasticsearch  \  
    																&&  \
#安装 HQ 插件 ( ES管理面板 )
 	cd /elasticsearch/bin  &&  ./plugin --install hq -u "${DOWN}/elasticsearch-HQ-latest.zip"  \
 																	&& \
#安装 SQL 插件 ( SQL解析器 ）
	cd /elasticsearch/bin  &&  ./plugin --install sql -u "${DOWN}/elasticsearch-sql-1.4.6-bin.zip"  \
 																	&& \
#安装 IK 插件 ( 中文分词 ）
	cd /elasticsearch/bin  &&  ./plugin --install ik -u "${DOWN}/elasticsearch-analysis-ik-1.4.1-bin.zip"  \
 																	&& \
#启动脚本
	chmod +x /start.sh           \
                                                                    && \
# 添加索引管理用户
    adduser es-data es-data -D -s/sbin/nologin            \
                                                                    && \
#清理安装产生的垃圾文件
    apk del build-dependencies    wget                                      && \
    ln -s $JAVA_HOME/bin/* /usr/bin/                        && \
    rm -rf /tmp/*	\ 
        /elasticsearch/config \
        /var/cache/apk/* 										

EXPOSE 9300 9200
CMD ["sh", "/start.sh"]

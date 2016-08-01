## ===========================================
#  团队猫 DockerFile 
#  
#  Sentry 8.6.0
#  
#  
#  @Name tuanduimao/sentry:8.6.0
#  @Ver 8.6.0
#  @By Weiping <weiping@diancloud.com>
#  
#  USEAGE:
#  	  docker run -d \
#		 -v /host/logs:/logs  \
#		 -v /host/data:/data  \
#		 -v /host/config:/config  \
#		 -p 127.0.0.1:90:9000 \
#		 tuanduimao/sentry
#  	 
#  FROM:
#  	 FROM tuanduimao/sentry:8.6.0
#  	 
#  BUILD:
#     docker build -t tuanduimao/sentry:8.6.0  -t tuanduimao/sentry:latest .
#     
#  
#  TEST:
#     docker build -t tuanduimao/sentry:latest .
#     docker run --rm -it tuanduimao/sentry  /bin/sh
#     
#  	  docker run --rm -it  \
#  	  		 -v /home/vagrant/test/sentry/logs:/logs  \
#  	  		 -v /home/vagrant/test/sentry/data:/data  \
#  	  		 -v /home/vagrant/test/sentry/config:/config  \
#  	  		 -p 90:9000 \
#  	  		 tuanduimao/sentry  /bin/sh
#  	  
# ===========================================

FROM tuanduimao/redis:latest
MAINTAINER diancloud.com <dev@diancloud.com>

VOLUME ["/data", "/logs", "/config"]
ENV CONF=default
ADD config /defaults/config
ADD start.sh /start.sh

ENV LIBRARY_PATH=/lib:/usr/lib
RUN apk update && \
    apk add build-base python-dev py-pip jpeg-dev zlib-dev postgresql-dev libxml2-dev libxslt-dev libffi-dev linux-headers  postgresql postgresql-client &&  \
	pip install -U sentry==8.6.0 && \
	adduser sentry sentry -D && \
	apk del build-base linux-headers && \
	rm -rf /tmp/*   \
        /var/cache/apk/* 
        /root/.cache

EXPOSE 9000
CMD ["sh", "/start.sh"]
   
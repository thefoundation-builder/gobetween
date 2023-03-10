FROM alpine

RUN apk update && apk upgrade && apk add curl bash socat
COPY  install.sh /
RUN bash /install.sh
RUN chmod +x /usr/bin/gobetween
RUN mkdir /conf
RUN gobetween --help |grep balancer

ENTRYPOINT /bin/bash -c 'timeout 7776000 /usr/bin/gobetween -c /conf/gobetween.conf'
ENTRYPOINT /bin/bash /boot.sh
COPY boot.sh /
CMD  /usr/bin/gobetween

#CMD /bin/ash

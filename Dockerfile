FROM alpine

RUN apk update && apk upgrade && apk add curl bash 
RUN cd /usr/bin/ && uname -a |grep -e amd64 -e x86_86 && MYARCH=amd64 &&  ( curl -kLv https://github.com/$(curl -s $(curl -s https://github.com/$(curl -s https://github.com/yyyar/gobetween/tags|grep /releases/tag |grep href|cut -d'"' -f4|grep /releases|head -n1)|grep  expanded_assets|sed 's/.\+src="//g'|cut -d '"' -f1)|grep /releases/|cut -d'"' -f2|grep MYARCH) |tar xvz)
RUN mkdir /conf

ENTRYPOINT /bin/bash -c 'timeout 7776000 /usr/bin/gobetween -c /conf/gobetween.conf'

CMD  /usr/bin/gobetween

#CMD /bin/ash

#!/bin/bash 
MYARCH="build"
cd /usr/bin/ 
uname -a |grep -e amd64 -e x86_64  && MYARCH=amd64 
echo "get  release page"
RELEASES=$(curl -s https://github.com/yyyar/gobetween/tags|grep /releases/tag |grep href|cut -d'"' -f4|grep /releases|head -n1)
RELEASEDOWNLOADS=$(curl -s https://github.com/$RELEASES|grep  expanded_assets|sed 's/.\+src="//g'|cut -d '"' -f1)
TARGFILE=$(curl -s $RELEASEDOWNLOADS|grep /releases/|cut -d'"' -f2|grep $MYARCH)
echo "getting for ARCH $MYARCH TARGET= $TARGFILE FROM $RELEASES == $RELEASEDOWNLOADS"
[[ "$MYARCH" = "build" ]] || ( curl -kLv https://github.com/$TARGFILE |tar xvz)

#( curl -kLv https://github.com/$(curl -s $(curl -s https://github.com/$(curl -s https://github.com/yyyar/gobetween/tags|grep /releases/tag |grep href|cut -d'"' -f4|grep /releases|head -n1)|grep  expanded_assets|sed 's/.\+src="//g'|cut -d '"' -f1)|grep /releases/|cut -d'"' -f2|grep $MYARCH)|grep linux |grep tar.gz |head -n1|tar xvz)
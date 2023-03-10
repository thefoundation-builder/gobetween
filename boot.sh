#!/bin/bash

echo "launching gobetween"
[[ -z $BINDPORT ]] && BINDPORT=11111
[[ -z $MINTLS ]] && MINTLS=1.2

[[ -z "$PRIVKEY" ]] || [[ -z "$CERTPEM" ]] || test -e ${PRIVKEY} && test -e ${CERTPEM} && (

echo "init:socat"
cat ${PRIVKEY} ${CERTPEM} > /tmp/socat.pem
socatcmd="socat OPENSSL-LISTEN:${BINDPORT},reuseaddr,pf=ip4,fork,cert=/tmp/socat.pem,cafile=${CERTPEM},verify=0,openssl-min-proto-version=TLS${MINTLS} openssl-connect:127.0.0.1:55555,verify=0"
echo "SOCAT COMMAND: $socatcmd"

while (true); do
bash -c "$socatcmd"
sleep 0.5
done &
while (true); do
oldsum=$(cat /tmp/socat.pem|md5sum)
newsum=$(cat ${PRIVKEY} ${CERTPEM}|md5sum)

[[ "$oldsum"  =  "$newsum" ]] || (
   echo "CERTs CHANGED, restarting socat"
   cat ${PRIVKEY} ${CERTPEM} > /tmp/socat.pem
   kill -9 $(pidof socat)
)
sleep 180
done &  )
exec /usr/bin/gobetween -c /conf/gobetween.conf

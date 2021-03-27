#!/usr/bin/env bash

docker rm $(docker stop $(docker ps -a -q --filter ancestor=my-apache2 --format="{{.ID}}"))

## Replace host with correct url
cp my-httpd-template.conf my-httpd.conf
#XXX_ANOTHER_HOST_IP_XXX
ANOTHER_SERVER_PORT=8090
ANOTHER_SERVER_PROTOCOL="http"
ANOTHER_SERVER_IP=`hostname -I | awk '{print $1}'`
sed "s/XXX_ANOTHER_HOST_IP_XXX/${ANOTHER_SERVER_IP}/g" -i my-httpd.conf
sed "s/XXX_ANOTHER_SERVER_PORT/${ANOTHER_SERVER_PORT}/g" -i my-httpd.conf
sed "s/XXX_ANOTHER_SERVER_PROTOCOL/${ANOTHER_SERVER_PROTOCOL}/g" -i my-httpd.conf
echo " Server properties: ip: ${ANOTHER_SERVER_IP}, port: ${ANOTHER_SERVER_PORT}, protocol: ${ANOTHER_SERVER_PROTOCOL}"

docker build -t my-apache2 .
docker run -dit --name my-running-app -p 8090:80 my-apache2

tmpfile=$(mktemp)
curl localhost:8090/show/my/staff/domains > "$tmpfile"
echo "Response"
cat "$tmpfile"
grep "The document has moved <a href=\"${ANOTHER_SERVER_PROTOCOL}://${ANOTHER_SERVER_IP}:${ANOTHER_SERVER_PORT}/internal/domains\">here</a>" "$tmpfile"
RESULT="$?"

docker rm $(docker stop $(docker ps -a -q --filter ancestor=my-apache2 --format="{{.ID}}"))
exit "$RESULT"
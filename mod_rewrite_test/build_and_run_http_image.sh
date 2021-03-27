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

docker build -t my-apache2 .
docker run -dit --name my-running-app -p 8090:80 my-apache2

curl localhost:8090/show/my/staff/domains
docker rm $(docker stop $(docker ps -a -q --filter ancestor=my-apache2 --format="{{.ID}}"))
#!/usr/bin/env bash

docker rm $(docker stop $(docker ps -a -q --filter ancestor=my-apache2 --format="{{.ID}}"))
docker build -t my-apache2 .
docker run -dit --name my-running-app -p 8090:80 my-apache2
#docker run -it --name my-running-app -p 8090:80 my-apache2

curl localhost:8090/show/my/staff/domains
docker rm $(docker stop $(docker ps -a -q --filter ancestor=my-apache2 --format="{{.ID}}"))
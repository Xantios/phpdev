#!/bin/bash

docker rm -f phpdev
docker rmi $(docker images phpdev -q)

docker build . -t phpdev

docker run \
--name phpdev \
-v $PWD/test_app:/var/www/html/ \
-p 8080:80 \
-p 8100:8100 \
phpdev
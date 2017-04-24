#!/bin/bash

EC2_ADDR=$1

docker login -e $DOCKER_EMAIL -u $DOCKER_USER -p $DOCKER_PASSWORD
docker push magnus108docker/dc_web:$CIRCLE_BRANCH

ssh $EC2_USER@$EC2_ADDR << EOF
docker pull magnus108docker/dc_web:$CIRCLE_BRANCH
docker stop web || true
docker rm web || true
docker rmi magnus108docker/dc_web:current || true
docker tag magnus108docker/dc_web:$CIRCLE_BRANCH magnus108docker/dc_web:current
docker run --restart always --name web -p 8080:80 -e MYSQL_PASSWORD=$MYSQL_PASSWORD -e MYSQL_USER=$MYSQL_USER -e MYSQL_ADDR=$MYSQL_ADDR -e MYSQL_DATABASE=$MYSQL_DATABASE -e MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD --volumes-from web_data -d magnus108docker/dc_web
EOF


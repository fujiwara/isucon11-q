#!/bin/bash

set -xe
cd go && /home/isucon/local/go/bin/go build . && cd -
rsync -av ./go/ ~/webapp/go/
rsync -av ./sql/ ~/webapp/sql/

sudo systemctl restart isucondition.go.service

sudo mv /var/log/nginx/access.log /var/log/nginx/access.log.$(date +%Y%m%d-%H%M%S)
sudo systemctl restart nginx

sudo mv /var/log/mysql/mariadb-slow.log /var/log/mysql/mariadb-slow.log.$(date +%Y%m%d-%H%M%S)
sudo mysqladmin flush-logs


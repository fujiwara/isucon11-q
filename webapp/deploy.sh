#!/bin/bash

set -xe
cd go && /home/isucon/local/go/bin/go build . && cd -
for h in 1 2 3
do
   rsync -av ~/env.sh isucondition-${h}.t.isucon.dev:/home/isucon/
   rsync -av ./go/ isucondition-${h}.t.isucon.dev:/home/isucon/webapp/go/
   rsync -av ./sql/ isucondition-${h}.t.isucon.dev:/home/isucon/webapp/sql/
   rsync -av ~/webapp/images/ isucondition-${h}.t.isucon.dev:/home/isucon/webapp/images/
   rsync -av ~/webapp/public/ isucondition-${h}.t.isucon.dev:/home/isucon/webapp/public/
   ssh isucondition-${h}.t.isucon.dev sudo systemctl restart isucondition.go.service
done

rsync -av /etc/nginx/ isucondition-2.t.isucon.dev:/tmp/etc/nginx/
ssh isucondition-2.t.isucon.dev sudo rsync -av /tmp/etc/nginx/ /etc/nginx/
ssh isucondition-2.t.isucon.dev sudo mv /var/log/nginx/access.log /var/log/nginx/access.log.$(date +%Y%m%d-%H%M%S)
ssh isucondition-2.t.isucon.dev sudo systemctl restart nginx

sudo mv /var/log/mysql/mariadb-slow.log /var/log/mysql/mariadb-slow.log.$(date +%Y%m%d-%H%M%S)
sudo mysqladmin flush-logs


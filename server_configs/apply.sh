#!/bin/bash

## env
for HOST in isu01 isu02 isu03; do
  rsync -av ${HOST}/home/isucon/webapp/env ${HOST}:/home/isucon/webapp/env
done

# systemctl isuports
for HOST in isu01 isu02 isu03; do
  rsync ${HOST}/etc/systemd/system/isuports.service ${HOST}:/tmp/isuports.service

  ssh -T ${HOST} <<EOT
sudo mv /tmp/isuports.service /etc/systemd/system/isuports.service
sudo chown root. /etc/systemd/system/isuports.service
sudo systemctl daemon-reload
EOT

# nginx.conf
for HOST in isu01 isu02 isu03; do
  rsync ${HOST}/etc/nginx/ ${HOST}:/tmp/nginx/

ssh -T ${HOST} <<EOT
  sudo rsync -av /tmp/nginx/ /etc/nginx/
  sudo chown -R root. /etc/nginx
  sudo systemctl reload nginx
EOT

done

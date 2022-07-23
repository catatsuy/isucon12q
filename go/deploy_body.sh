#!/bin/bash

set -x

echo "start deploy ${USER}"
for server in isu01 isu02 isu03; do
  scp ./isuports.go $server:/home/isucon/webapp/go/isuports.go
  ssh -t $server "cd /home/isucon/webapp/go; /usr/local/go/bin/go build -o /home/isucon/isuports ./cmd/isuports"
  ssh -t $server "sudo systemctl stop isuports.service"
  ssh -t $server "sudo systemctl start isuports.service"
done

echo "finish deploy ${USER}"

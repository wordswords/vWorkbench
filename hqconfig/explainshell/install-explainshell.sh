#!/bin/bash

set -e
set -x

rm -rf ./explainshell
git clone git@github.com:idank/explainshell.git
cd ./explainshell

# download db dump
curl -L -o /tmp/dump.gz https://github.com/idank/explainshell/releases/download/db-dump/dump.gz

# start containers, load man pages from dump
docker-compose build
docker-compose up

docker-compose exec -T db mongorestore --archive --gzip < /tmp/dump.gz

# run tests
docker-compose exec -T web make tests

# open http://localhost:5000 to view the ui

#!/bin/bash

set -x
set -e

cd ./explainshell/explainshell/
docker-compose up -d
cd -

cd ./pihole/
docker-compose up -d
cd -


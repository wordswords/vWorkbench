#!/bin/bash

set -x
set -e

cd ./pihole/
docker-compose up -d
cd -

killall dnsmasq || true
cd ./explainshell/explainshell/
docker-compose up -d
cd -

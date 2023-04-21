#!/bin/bash

set -x
set -e

killall dnsmasq || true
cd ./pihole/
docker-compose up -d
cd -

cd ./explainshell/explainshell/
docker-compose up -d
cd -

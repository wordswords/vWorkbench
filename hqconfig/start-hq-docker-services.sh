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

cd ./automaticrippingmachine
docker-compose up -d
cd -

cd ./prowlarr
docker-compose up -d
cd -

cd ./lidarr
docker-compose up -d
cd -

cd ./qbtorrent
docker-compose up -d
cd -



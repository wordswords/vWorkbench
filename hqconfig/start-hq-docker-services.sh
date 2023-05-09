#!/bin/bash

set -x
set -e

killall dnsmasq || true

function updateAndUp() {
    cd "$1"
    docker compose down || true
    docker compose pull
    docker compose build
    docker compose up -d
    cd -
}
function JustUp() {
    cd "$1"
    docker-compose up -d
    cd -
}
function JustDown() {
    cd "$1"
    docker-compose down || true
    cd -
}
function JustUpdate() {
    cd "$1"
    docker-compose pull
    cd -
}
function PruneNetworks() {
    docker network prune -f
}
function PruneUnusuedContainers() {
    docker image prune -a -f
}

JustUp ./pihole
sudo ~/bin/man-vpn-disconnect.sh
sudo ~/bin/man-vpn-connect.sh
JustDown ./explainshell/explainshell
JustDown ./prowlarr
JustDown ./qbtorrent
JustDown ./lidarr
JustDown ./calibreweb
PruneUnusuedContainers
PruneNetworks
JustUpdate ./explainshell/explainshell
JustUpdate ./lidarr
JustUpdate ./prowlarr
JustUpdate ./qbtorrent
JustUpdate ./calibreweb
JustUp ./explainshell/explainshell
JustUp ./lidarr
JustUp ./prowlarr
JustUp ./qbtorrent
JustUp ./calibreweb



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
    docker compose up -d
    cd -
}
JustUp ./pihole
updateAndUp ./explainshell/explainshell
updateAndUp ./prowlarr
updateAndUp ./lidarr
updateAndUp ./qbtorrent
updateAndUp ./calibreweb




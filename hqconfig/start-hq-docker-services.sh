#!/bin/bash

set -x
set -e

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
function JustDown() {
    cd "$1"
    docker compose down || true
    cd -
}
function JustUpdate() {
    cd "$1"
    docker compose pull
    cd -
}
function JustRecreate() {
    cd "$1"
    docker compose up --build --force-recreate
    cd -
}
function BuildLocalAndTag() {
    cd "$1"
    docker build \
      --no-cache \
      --pull \
      -t "$2" .
    cd -
}
function PruneNetworks() {
    docker network prune -f
}
function PruneUnusuedContainers() {
    docker image prune -a -f
}

/home/david/bin/man-vpn-disconnect.sh || true
/home/david/bin/man-vpn-connect.sh
#./explainshell/install-explainshell.sh
#./explainshell/update-explainshell.sh
JustDown ./prowlarr
JustDown ./qbtorrent
JustDown ./lidarr
JustDown ./calibreweb
JustDown ./calibreweb-comics
JustDown ./calibre
JustDown ./calibre-comics
PruneUnusuedContainers
PruneNetworks
#JustUpdate ./explainshell/explainshell
#JustUpdate ./lidarr
JustUpdate ./prowlarr
JustUpdate ./qbtorrent
#BuildLocalAndTag ./docker-calibre-web calibre-web:dchq
#JustRecreate ./calibreweb
#JustRecreate ./calibreweb-comics
JustUpdate ./calibreweb
JustUpdate ./calibre
JustUpdate ./calibre-comics
JustUpdate ./calibreweb-comics
#JustUp ./explainshell/explainshell
#JustUp ./lidarr
#JustUp ./prowlarr
#JustUp ./qbtorrent
JustUp ./calibre
JustUp ./calibre-comics
JustUp ./calibreweb
JustUp ./calibreweb-comics



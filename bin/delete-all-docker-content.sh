#!/bin/bash

set -e

deleteAllDockerContent() {
    sudo service dockerd stop || true
    sudo /etc/init.d/docker stop || true
    docker kill "$(docker ps -q)" || echo "No containers to stop" # stop all containers
    for containeref in $(docker ps -q)
    do
        docker stop "${containeref}"
    done
    for imgref in $(docker images -a | awk '{ print $3 }')
    do
        if ! [[ "${imgref}" = "IMAGE" ]]; then
            docker rmi -f "${imgref}"
        fi
    done
    docker system prune
    docker network prune -f
    docker image prune -a -f

    sudo service dockerd start || true
    sudo /etc/init.d/docker start || true
}

deleteAllDockerContent

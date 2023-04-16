#!/bin/bash

set -e

deleteAllDockerContent() {
    sudo service dockerd stop || true
    docker kill "$(docker ps -q)" || echo "No containers to stop" # stop all containers
    docker rm "$(docker ps -a -q)" || echo "No containers to remove" # remove all containers
    docker volume rm "$(docker volume ls -q)" || echo "No volumes to remove" # remove all volumes
    for imgref in $(docker images -a | awk '{ print $3 }')
    do
        if ! [[ "${imgref}" = "IMAGE" ]]; then
            docker rmi -f "${imgref}"
        fi
    done
    sudo service dockerd start
}

deleteAllDockerContent

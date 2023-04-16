#!/bin/bash

set -e

deleteAllDockerContent() {
    sudo service dockerd stop || true
    docker kill "$(docker ps -q)" || echo "No containers to stop" # stop all containers
    for imgref in $(docker images -a | awk '{ print $3 }')
    do
        if ! [[ "${imgref}" = "IMAGE" ]]; then
            docker rmi -f "${imgref}"
        fi
    done
    sudo service dockerd start
}

deleteAllDockerContent

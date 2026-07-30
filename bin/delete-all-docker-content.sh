#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

deleteAllDockerContent() {
    sudo service dockerd stop || true
    sudo /etc/init.d/docker stop || true
    docker kill "$(docker ps -q)" || printf '%s\n' "No containers to stop" # stop all containers
    while IFS= read -r containeref
    do
        docker stop "${containeref}"
    done < <(docker ps -q)
    while IFS= read -r imgref
    do
        if [[ "${imgref}" != "IMAGE" ]]; then
            docker rmi -f "${imgref}"
        fi
    done < <(docker images -a | awk '{ print $3 }')
    docker system prune
    docker network prune -f
    docker image prune -a -f

    sudo service dockerd start || true
    sudo /etc/init.d/docker start || true
}

deleteAllDockerContent

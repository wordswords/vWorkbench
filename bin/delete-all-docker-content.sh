#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

delete_all_docker_content() {
    sudo service dockerd stop || true
    sudo /etc/init.d/docker stop || true
    docker kill "$(docker ps -q)" || printf '%s\n' "No containers to stop" # stop all containers
    while IFS= read -r container_ref
    do
        docker stop "${container_ref}"
    done < <(docker ps -q)
    while IFS= read -r image_ref
    do
        if [[ "${image_ref}" != "IMAGE" ]]; then
            docker rmi -f "${image_ref}"
        fi
    done < <(docker images -a | awk '{ print $3 }')
    docker system prune
    docker network prune -f
    docker image prune -a -f

    sudo service dockerd start || true
    sudo /etc/init.d/docker start || true
}

delete_all_docker_content

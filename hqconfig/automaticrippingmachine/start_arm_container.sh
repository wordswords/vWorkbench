#!/bin/bash
docker run -d \
    -p "8080:8080" \
    -e ARM_UID="1001" \
    -e ARM_GID="1003" \
    -v "/home/arm:/home/arm" \
    -v "/home/arm/Music:/home/arm/Music" \
    -v "/home/arm/logs:/home/arm/logs" \
    -v "/home/arm/media:/home/arm/media" \
    -v "/etc/arm/config:/etc/arm/config" \
    --device="/dev/sr0:/dev/sr0" \
    --device="/dev/sg5:/dev/sg5" \
    --privileged \
    --restart "always" \
    --name "arm-rippers" \
    --cpuset-cpus='2,3,4,5,6,7' \
    automaticrippingmachine/automatic-ripping-machine:latest


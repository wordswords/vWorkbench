#!/bin/bash
if [ $(id -u) -ne 0 ] ; then
    echo 'You must be root to run this script'
    exit 1
fi
sudo runuser -u arm docker run -d \
    -p "8080:8080" \
    -e ARM_UID="1001" \
    -e ARM_GID="1003" \
    -v "/home/arm:/home/arm" \
    -v "/home/arm/Music:/home/arm/Music" \
    -v "/home/arm/logs:/home/arm/logs" \
    -v "/home/arm/media:/home/arm/media" \
    -v "/etc/arm/config:/etc/arm/config" \
    --device="/dev/sr0:/dev/sr0" \
    --device="/dev/sr1:/dev/sr1" \
    --device="/dev/sr2:/dev/sr2" \
    --device="/dev/sr3:/dev/sr3" \
    --privileged \
    --restart "always" \
    --name "arm-rippers" \
    --cpuset-cpus='2,3,4,5,6,7' \
    automaticrippingmachine/automatic-ripping-machine:latest


#!/bin/bash

set -e
set -x

cp ./docker-pi-hole.cron.weekly /etc/cron.weekly/docker-pi-hole
sudo chmod 700 /etc/cron.weekly/docker-pi-hole


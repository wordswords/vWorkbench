#!/bin/bash

set -e
set -x

sudo wget -O /etc/cron.weekly/docker-pi-hole https://raw.githubusercontent.com/pi-hole/docker-pi-hole/master/examples/docker-pi-hole.cron
sudo chmod 700 /etc/cron.weekly/docker-pi-hole


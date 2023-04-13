#!/bin/bash

set -x
set -e

if [ $(id -u) -ne 0 ] ; then
    echo 'You must be root to run this script'
    exit 1
fi


SITE=${1}
WWW=www.${SITE}

sudo cat /etc/hosts | grep -v ${SITE} > /etc/hosts.new
sudo mv /etc/hosts.new /etc/hosts

echo "Unblocked ${WWW} and ${SITE}"


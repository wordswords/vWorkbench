#!/bin/bash

set -x
set -e

if [ $(id -u) -ne 0 ] ; then
    echo 'You must be root to run this script'
    exit 1
fi



SITE=${1}
WWW=www.${SITE}
sudo echo 0.0.0.0 ${WWW} >> /etc/hosts
sudo echo 0.0.0.0 ${SITE} >> /etc/hosts
sudo echo ::0 ${SITE} >> /etc/hosts
sudo echo ::0 ${WWW} >> /etc/hosts

echo "Blocked ${WWW} and ${SITE}"


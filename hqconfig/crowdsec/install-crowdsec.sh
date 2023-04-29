#!/bin/bash

set -e
set -x

curl -s https://packagecloud.io/install/repositories/crowdsec/crowdsec/script.deb.sh | sudo bash
sudo apt install crowdsec -y
sudo apt install crowdsec-firewall-bouncer-iptables -y
sudo cscli dashboard setup --listen 0.0.0.0
sudo cscli config show



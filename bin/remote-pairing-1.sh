#!/bin/bash
set -e

echo "Installing openssh-server and screen on the local machine.."
sudo apt update && sudo apt install -y screen openssh-server
echo ""

echo "Setting permissions of local screen binary to allow multiuser sharing.."
sudo chmod u+s /usr/bin/screen
sudo chmod 755 /var/run/screen
echo ""

echo "Discovering VPN IP address.."
ifconfig tun0 || ( echo "You are not connected to the VPN!" && exit 1 )
my_ip=$(ifconfig tun0 | grep -o -E 'inet [0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'  | cut -d' ' -f2)
echo ""

echo "Your VPN IP address is: ${my_ip}, stop now and send this address to the trainer"
echo ""
read -r -p "Press any key to continue once you've done that.."
echo "When screen starts:"
echo ""
echo "* Press <ctrl>-<a> <d> to detach the existing session at any time"
echo "* Don't type <ctrl>-<d> or 'exit' otherwise you will terminate the screen"
echo "* Run the following script to enable the trainer to connect: ./setup_training_screen_pt2.sh"
echo ""
read -r -p "Press any key to continue.."
screen -m -S training_screen

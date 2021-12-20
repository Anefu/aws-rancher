#!/bin/bash
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
usermod -G docker -a ubuntu
apt install ntp -y
net.bridge.bridge-nf-call-iptables=1
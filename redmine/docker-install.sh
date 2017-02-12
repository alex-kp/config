#!/bin/bash

# Instruction from:
# https://docs.docker.com/engine/installation/linux/ubuntu/
sudo apt-get update

sudo apt-get -y install curl \
    linux-image-extra-$(uname -r) \
    linux-image-extra-virtual

sudo apt-get -y install apt-transport-https \
                     ca-certificates

curl -fsSL https://yum.dockerproject.org/gpg | sudo apt-key add -

apt-key fingerprint 58118E89F3A912897C070ADBF76221572C52609D

sudo apt-get -y install software-properties-common

sudo add-apt-repository \
       "deb https://apt.dockerproject.org/repo/ \
       ubuntu-$(lsb_release -cs) \
       main"

sudo apt-get update

sudo apt-get -y install docker-engine

# Instructions from:
# https://docs.docker.com/engine/installation/linux/linux-postinstall/

sudo systemctl enable docker

# Instruction from:
# https://docs.docker.com/compose/install/

sudo curl -L "https://github.com/docker/compose/releases/download/1.10.0/docker-compose-$(uname -s)-$(uname -m)" \
       -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose


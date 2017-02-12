#!/bin/bash

# The docker-compose line will retrieve the redmine container and dependencies
#sudo docker pull sameersbn/redmine:latest

#wget https://raw.githubusercontent.com/sameersbn/docker-redmine/master/docker-compose.yml
sudo docker-compose run redmine app:init




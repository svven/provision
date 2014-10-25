#!/bin/bash
echo "
############################################################
## Redis Crawler instance 
############################################################
"

## Make sure
cd $HOME

## Make sure
cd $HOME
## Locale fix just in case
export LC_ALL=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

## Install git
sudo apt-get install -y git

## Start the profile
source .bash_profile

git clone git@bitbucket.org:svven/redis.git

wget https://github.com/antirez/redis/archive/3.0.0-beta8.tar.gz
tar xzf 3.0.0-beta8.tar.gz
cd redis-3.0.0-beta8
make
cd src
sudo ./redis-server


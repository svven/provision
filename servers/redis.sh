#!/bin/bash
echo "
############################################################
## Redis server
## User: $USER (e.g.: svven, ducu, jon etc.)
############################################################
"

## Go home
cd $HOME
## Locale fix just in case
export LC_ALL=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

## Install git
sudo apt-get install -y git

## Redis requirement
sudo apt-get install -y tcl8.5

## Install supervisor
sudo apt-get install -y supervisor

## And again
# sudo apt-get update
# sudo apt-get -y upgrade

## Start the profile
source .bash_profile

## Either clone or symlink the code
if [ $1 == "-c" ]; then
    # git init
    # git remote add origin git@bitbucket.org:svven/redis.git
    # git pull origin master
    git clone git@bitbucket.org:svven/redis.git
elif [ -d /project/redis ]; then
    ln -s /project/redis redis
fi
cd redis

## Install redis
redisversion="redis-2.8.17"

wget http://download.redis.io/releases/${redisversion}.tar.gz
tar xzf ${redisversion}.tar.gz
sudo mv ${redisversion} /opt/
cd /opt/${redisversion}
sudo chmod 750 -R . # required execute permissions
sudo make

# ## Test
# sudo make test

## Link to server
cd ${HOME}/redis
ln -s /opt/${redisversion}/src server

## Start redis server
# server/redis-server conf/redis.conf

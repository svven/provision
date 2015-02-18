#!/bin/bash
REDIS_VER="redis-2.8.19"
echo "
##############################################################################
## Redis server ($REDIS_VER)
## User: $USER (e.g.: svven)
##############################################################################
"


DIR=$( cd "$( dirname "$0" )/.." && pwd )

## Go home
cd $HOME # /home/$USER

## Requirement
sudo apt-get install -y tcl8.5

## Install
if [ ! -f /usr/local/bin/redis-server ]; then
    cd /usr/local/src
    sudo wget http://download.redis.io/releases/$REDIS_VER.tar.gz
    sudo tar xzf $REDIS_VER.tar.gz

    cd $REDIS_VER
    sudo make
    sudo make PREFIX=/usr/local/ install
    # ## Test
    # sudo make test
else
    echo "Redis server already installed."
    exit 0
fi

## Configure
sudo useradd -r redis
sudo mkdir -p /var/lib/redis /var/log/redis
sudo chown redis:redis /var/lib/redis /var/log/redis
sudo cp -u $DIR/conf/redis.conf /etc/redis.conf
echo "
## https://redislabs.com/blog/5-tips-for-running-redis-over-aws
vm.swappiness=0
vm.overcommit_memory = 1" | sudo tee -a /etc/sysctl.conf

## Initialize 
sudo cp -u $DIR/init/redis.init /etc/init.d/redis-server
sudo chmod +x /etc/init.d/redis-server

## Start redis server
sudo update-rc.d redis-server defaults
sudo service redis-server start

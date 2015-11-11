#!/bin/bash
REDIS_VER="redis-3.0.2"
echo "
##############################################################################
## Redis server ($REDIS_VER)
## User: $USER (e.g.: svven)
##############################################################################
"

DIR=$( cd "$( dirname "$0" )/.." && pwd )

## Go home
cd $HOME # /home/$USER

## Rsyslog
## https://askubuntu.com/questions/95910/command-for-determining-my-public-ip
LOCALHOSTNAME=$( curl -s ipecho.net/plain ; echo )
PAPERTRAIL_HOST="logs3.papertrailapp.com"
PAPERTRAIL_PORT="20728"
eval "echo \"$(< $DIR/conf/rsyslog/rsyslog.conf)\"" | sudo tee /etc/rsyslog.conf
sudo service rsyslog restart


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
sudo mkdir -p /var/lib/redis /var/log/redis /etc/redis
sudo chown redis:redis /var/lib/redis /var/log/redis /etc/redis
sudo cp $DIR/conf/redis/redis.conf /etc/redis/redis.conf
echo "
## https://redislabs.com/blog/5-tips-for-running-redis-over-aws
vm.swappiness=0
vm.overcommit_memory=1
net.core.somaxconn=65535" | sudo tee -a /etc/sysctl.conf
echo "never" | sudo tee /sys/kernel/mm/transparent_hugepage/enabled
sudo sysctl -w vm.overcommit_memory=1
sudo sysctl -w net.core.somaxconn=65535

## Initialize 
sudo cp -u $DIR/init/redis.init /etc/init.d/redis-server
sudo chmod +x /etc/init.d/redis-server

## Start service
sudo update-rc.d redis-server defaults
sudo service redis-server start

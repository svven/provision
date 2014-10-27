#!/bin/bash
redisversion="redis-2.8.17"

echo "
############################################################
## Redis server (${redisversion})
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

if [ -d ${HOME}/redis ]; then
	cd ${HOME}/redis
else
	echo "Failed loading redis repo."
	exit 1
fi

## Install redis
if [ ! -f /opt/${redisversion}/src/redis-server ]; then
	wget http://download.redis.io/releases/${redisversion}.tar.gz
	tar xzf ${redisversion}.tar.gz
	sudo mv ${redisversion} /opt/

	cd /opt/${redisversion}
	sudo chmod 750 -R . # required execute permissions
	sudo make
	# ## Test
	# sudo make test

	cd ${HOME}/redis
else
	echo "Redis Server already installed."
fi

## Link to server
if [ ! f server/redis-server ]; then
	ln -s /opt/${redisversion}/src server
fi

## Start redis server
# server/redis-server conf/redis.conf

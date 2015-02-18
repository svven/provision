#!/bin/bash
echo "
##############################################################################
## Nginx server
## User: $USER (e.g.: svven)
##############################################################################
"

DIR=$( cd "$( dirname "$0" )/.." && pwd )

## Go home
cd $HOME # /home/$USER

## Install
sudo apt-get install -y nginx

## Configure
sudo cp $DIR/conf/nginx.conf /etc/nginx/nginx.conf
sudo service nginx restart

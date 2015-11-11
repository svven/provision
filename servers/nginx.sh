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

## Rsyslog
sudo cp $DIR/conf/rsyslog/rsyslog.conf /etc/rsyslog.conf
echo "
local0.* @logs3.papertrailapp.com:33078" | sudo tee -a /etc/rsyslog.conf
sudo service rsyslog restart

## Install
sudo apt-get install -y nginx

## Configure
LOG_FOLDER=/var/log/nginx
sudo mkdir -p $LOG_FOLDER && sudo chown $USER $LOG_FOLDER

sudo cp $DIR/conf/nginx/nginx.conf /etc/nginx/nginx.conf

## Start service
sudo service nginx restart

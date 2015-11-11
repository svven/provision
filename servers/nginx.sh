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
## https://askubuntu.com/questions/95910/command-for-determining-my-public-ip
LOCALHOSTNAME=$( curl -s ipecho.net/plain ; echo )
PAPERTRAIL_HOST="logs3.papertrailapp.com"
PAPERTRAIL_PORT="33078"
eval "echo \"$(< $DIR/conf/rsyslog/rsyslog.conf)\"" | sudo tee /etc/rsyslog.conf

## Install
sudo apt-get install -y nginx

## Configure
LOG_FOLDER=/var/log/nginx
sudo mkdir -p $LOG_FOLDER && sudo chown $USER $LOG_FOLDER

sudo cp $DIR/conf/rsyslog/nginx.conf /etc/rsyslog.d/00-nginx.conf
sudo cp $DIR/conf/nginx/nginx.conf /etc/nginx/nginx.conf

## Start services
sudo service rsyslog restart
sudo service nginx restart

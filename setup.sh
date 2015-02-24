#!/bin/bash
## http://alestic.com/2010/12/ec2-user-data-output
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
echo "
##############################################################################
## Setup (continued from base.sh)
## User: $USER (e.g. root, vagrant, ubuntu)
##############################################################################"

USER=ubuntu; NEW_USER=svven

COMPONENT="poller summarizer app"
ENVIRONMENT="
DATABASE_HOST=localhost\n
RQ_REDIS_HOST=localhost\n
AGGREGATOR_REDIS_HOST=localhost"

## Go home
cd /home/$USER

## Pull provision
cd provision; sudo -u $USER git pull origin master; cd ..

## Set app environment vars
echo -e $ENVIRONMENT | sudo -u $NEW_USER tee /home/$NEW_USER/.env

## Install the component(s)
sudo -u $NEW_USER -H bash provision/install.sh "$COMPONENT"

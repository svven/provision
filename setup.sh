#!/bin/bash
echo "
##############################################################################
## Setup (continued from base.sh)
## User: $USER (e.g. root, vagrant, ubuntu)
##############################################################################"

USER=ubuntu; NEW_USER=svven

COMPONENT="poller summarizer app"
ENVIRONMENT="
    DATABASE_HOST=localhost
    RQ_REDIS_HOST=localhost
    AGGREGATOR_REDIS_HOST=localhost
"

## Go home
cd /home/$USER

## Set app environment vars
echo $ENVIRONMENT | sudo -u $NEW_USER tee /home/$NEW_USER/.env

## Install the component(s)
sudo -u $NEW_USER -H bash provision/install.sh "$COMPONENT"

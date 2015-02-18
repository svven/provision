#!/bin/bash
COMPONENT=$1
echo "
##############################################################################
## Install ($COMPONENT)
## User: $USER (e.g.: svven)
##############################################################################"
if [ $# -lt 1 ]; then
    echo "## Missing argument: 
##   1 - Component (e.g. postgre redis nginx web poller summarizer)
##############################################################################"
    exit 1
fi

DIR=$( cd "$( dirname "$0" )" && pwd )

## Servers
if [[ $COMPONENT == *"nginx"* ]]; then
    sudo -u $USER -H bash $DIR/servers/nginx.sh
fi
if [[ $COMPONENT == *"postgre"* ]]; then
    sudo -u $USER -H bash $DIR/servers/postgre.sh
fi
if [[ $COMPONENT == *"redis"* ]]; then
    sudo -u $USER -H bash $DIR/servers/redis.sh
fi

## Apps
if [[ $COMPONENT == *"app"* ]]; then
    sudo -u $USER -H bash $DIR/apps/base.sh
fi
if [[ $COMPONENT == *"poller"* ]]; then
    sudo -u $USER -H bash $DIR/apps/poller.sh
fi
if [[ $COMPONENT == *"summarizer"* ]]; then
    sudo -u $USER -H bash $DIR/apps/summarizer.sh
fi
if [[ $COMPONENT == *"web"* ]]; then
    sudo -u $USER -H bash $DIR/apps/web.sh
fi

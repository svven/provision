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

if [[ $COMPONENT == *"postgre"* ]]; then
    sudo -u $USER -H bash $DIR/servers/postgre.sh
fi
if [[ $COMPONENT == *"redis"* ]]; then
    sudo -u $USER -H bash $DIR/servers/redis.sh
fi

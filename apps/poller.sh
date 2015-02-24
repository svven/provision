#!/bin/bash
echo "
##############################################################################
## Poller app
## User: $USER (e.g.: svven, ducu, jon etc.)
##############################################################################
"

REPO=poller
GIT_REPO=git@bitbucket.org:svven/$REPO.git
DIR=$( cd "$( dirname "$0" )/.." && pwd )

## Go home
cd $HOME # /home/$USER

## Start the profile
source .bash_profile

## Install
if [ ! -d $REPO ]; then
    git clone $GIT_REPO
fi
cd $REPO

## Activate virtualenv
if [ ! -d env ]; then
    virtualenv env
fi
source env/bin/activate

## Requirements
pip install -r requirements.txt

## Configure supervisor
MANAGE=$(which manage)

LOG_FOLDER=/var/log/$REPO
sudo mkdir -p $LOG_FOLDER && sudo chown $USER $LOG_FOLDER

ENVIRONMENT=""
while read line; do
    ENVIRONMENT=$ENVIRONMENT$line,
done < $HOME/.env

eval "echo \"$(< $DIR/conf/supervisor/poller.conf)\"" | sudo tee /etc/supervisor/conf.d/poller.conf

## Restart service
sudo supervisorctl reread
sudo supervisorctl update
sudo supervisorctl start poller

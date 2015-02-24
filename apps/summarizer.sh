#!/bin/bash
echo "
##############################################################################
## Summarizer app
## User: $USER (e.g.: svven, ducu, jon etc.)
##############################################################################
"

APP=summarizer
APP_GIT_REPO=git@bitbucket.org:svven/$APP.git
DIR=$( cd "$( dirname "$0" )/.." && pwd )

## Go home
cd $HOME # /home/$USER

## Start the profile
source .bash_profile

## Install
if [ ! -d $APP ]; then
    git clone $APP_GIT_REPO
fi
cd $APP

## Activate virtualenv
if [ ! -d env ]; then
    virtualenv env
fi
source env/bin/activate

## Requirements
pip install -r requirements.txt

## Configure supervisor
MANAGE=$(which manage)
DIRECTORY=$PWD

LOG_FOLDER=/var/log/$APP
sudo mkdir -p $LOG_FOLDER && sudo chown $USER $LOG_FOLDER

ENVIRONMENT=""
while read line; do
    ENVIRONMENT=$ENVIRONMENT$line,
done < $HOME/.env

eval "echo \"$(< $DIR/conf/supervisor/$APP.conf)\"" | sudo tee /etc/supervisor/conf.d/$APP.conf

## Start service
sudo supervisorctl reread
sudo supervisorctl update
sudo supervisorctl start $APP:*

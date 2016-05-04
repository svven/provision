#!/bin/bash
APP=$1
echo "
##############################################################################
## Update ($APP)
## User: $USER (e.g.: svven, ducu, jon etc.)
##############################################################################
"
if [ $# -lt 1 ]; then
    echo "## Missing argument: 
##   1 - App (e.g. web poller summarizer)
##############################################################################"
    exit 1
fi
DIR=$( cd "$( dirname "$0" )/.." && pwd )

## Go home
cd $HOME # /home/$USER

## Start the profile
source .bash_profile

## Update
if [ ! -d $APP ]; then
    echo "App not installed so cannot update."
    exit 1
fi
cd $APP
git pull

## Activate virtualenv
if [ ! -d env ]; then
    virtualenv env
fi
source env/bin/activate

## Requirements
pip install -r requirements.txt --upgrade

## Reconfigure supervisor
MANAGE=$(which manage)
GUNICORN=$(which gunicorn)
DIRECTORY=$PWD

LOG_FOLDER=/var/log/$APP
if [ ! -d $LOG_FOLDER ]; then
    sudo mkdir -p $LOG_FOLDER && sudo chown $USER $LOG_FOLDER
fi

# PSL Temp Fix
wget https://publicsuffix.org/list/effective_tld_names.dat
echo "PUBLIC_SUFFIX_LIST=$PWD/effective_tld_names.dat" >> $HOME/.env

ENVIRONMENT=""
while read line; do
    ENVIRONMENT=$ENVIRONMENT$line,
done < $HOME/.env

eval "echo \"$(< $DIR/conf/supervisor/$APP.conf)\"" | sudo tee /etc/supervisor/conf.d/$APP.conf

## Update supervisor
sudo supervisorctl update

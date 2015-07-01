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

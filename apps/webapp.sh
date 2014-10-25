#!/bin/bash
echo "
############################################################
## Web app
## User: $USER (e.g.: svven, ducu, jon etc.)
############################################################
"

## Make sure
cd $HOME

## Start the profile
source .bash_profile

## Virtualenv first
pyenv virtualenv web

## Activate it
pyenv activate web
############################################################
## (Env)User: (web)svven

## Make the directories
# mkdir app bin conf docs logs tests
# mkdir logs/app logs/gunicorn logs/supervisor

# Get the code, should better have all required folders
# git init
# git remote add origin git@bitbucket.org:svven/web.git
# git pull origin master
git clone git@bitbucket.org:svven/web.git

# Pip the requirements
pip install -r requirements.txt


# Pip gunicorn
pip install gunicorn

# log vars
export GUNC_ACCESS_LOG=~/web/logs/gunicorn/guncacc.log
export GUNC_LOG=~/web/logs/gunicorn/gunc.log

# Start gunicorn
gunicorn --access-logfile $GUNC_ACCESS_LOG --log-file $GUNC_LOG --log-level debug sources.app:app -b 0.0.0.0:8000 &


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
#pip install requirements.txt

pip install requests

# Pip gunicorn
# pip install gunicorn

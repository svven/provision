#!/bin/bash
echo "
############################################################
## Web app
## User: $USER (e.g.: svven, ducu, jon etc.)
############################################################
"

## Go home
cd $HOME

## Start the profile
source .bash_profile

## Either clone or symlink the code
if [ $1 == "-c" ]; then
    git clone git@bitbucket.org:svven/web.git
elif [ -d /project/web ]; then
    ln -s /project/web web
fi
cd web

## Virtualenv first
pyenv virtualenv web

## Activate it
pyenv activate web
############################################################
## (Env)User: (web)svven

## Pip the requirements
pip install -r requirements.txt

## Pip gunicorn
pip install gunicorn


## Sort out later
# # log vars
# export GUNC_ACCESS_LOG=~/web/logs/gunicorn/guncacc.log
# export GUNC_LOG=~/web/logs/gunicorn/gunc.log

# # Start gunicorn
# gunicorn --access-logfile $GUNC_ACCESS_LOG --log-file $GUNC_LOG --log-level debug sources.app:app -b 0.0.0.0:8000 &


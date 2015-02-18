#!/bin/bash
echo "
##############################################################################
## Web app
## User: $USER (e.g.: svven, ducu, jon etc.)
##############################################################################
"

REPO=web
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

## Start gunicorn
gunicorn web.manage:app -b unix:/tmp/gunicorn.sock -w 4 -D

## Configure nginx
sudo cp $DIR/conf/web.conf /etc/nginx/conf.d/web.conf
sudo service nginx restart

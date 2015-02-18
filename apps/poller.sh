#!/bin/bash
echo "
##############################################################################
## Poller app
## User: $USER (e.g.: svven, ducu, jon etc.)
##############################################################################
"

REPO=poller
GIT_REPO=git@bitbucket.org:svven/$REPO.git

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

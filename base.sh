#!/bin/bash
echo "
##############################################################################
## Base instance
## User: $USER (e.g. root, vagrant, ubuntu)
##############################################################################"

USER=ubuntu; NEW_USER=svven
PRIVATE_KEY=https://www.dropbox.com/s/5le6maruiold9lc/svven_rsa?dl=1
# PUBLIC_KEY=https://www.dropbox.com/s/5le6maruiold9lc/svven_rsa.pub?dl=1

SYSADMIN_GIT_REPO=https://bitbucket.org/svven/sysadmin.git
PROVISION_GIT_REPO=git@bitbucket.org:svven/provision.git

## Fix locale first
curl -L $SYSADMIN_GIT_REPO/raw/master/fixlocale.sh | bash

## Update and upgrade
sudo apt-get update
sudo apt-get upgrade -y

## Major requirements
sudo apt-get install -y build-essential git

## Go home
cd /home/$USER

## Get sysadmin and provision scripts
if [ ! -d sysadmin ]; then
    sudo -u $USER -H bash -c "
    git clone $SYSADMIN_GIT_REPO"
fi
if [ ! -d provision ]; then
    sudo -u $USER -H bash sysadmin/setssh.sh $PRIVATE_KEY
    sudo -u $USER -H bash -c "
    source .bash_profile
    git clone $PROVISION_GIT_REPO"
fi

## Add the new user and set SSH keys
sudo -u $USER -H bash sysadmin/adduser.sh $NEW_USER
sudo -u $NEW_USER -H bash sysadmin/setssh.sh $PRIVATE_KEY $PUBLIC_KEY

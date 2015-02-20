#!/bin/bash
echo "
##############################################################################
## Provision
## User: $USER (e.g. root, vagrant, ubuntu)
##############################################################################"

ALL="postgre redis nginx app poller summarizer web"
COMPONENT=${1:-"$ALL"} # (e.g.: "postgre", "summarizer app")
if [[ $COMPONENT == "all" ]]; then
    COMPONENT=$ALL
fi

USER=ubuntu; NEW_USER=svven
PRIVATE_KEY=https://www.dropbox.com/s/5le6maruiold9lc/svven_rsa?dl=1
# PUBLIC_KEY=https://www.dropbox.com/s/5le6maruiold9lc/svven_rsa.pub?dl=1

SYSADMIN_GIT_REPO=https://bitbucket.org/svven/sysadmin.git
PROVISION_GIT_REPO=git@bitbucket.org:svven/provision.git

## Update first
curl -L $SYSADMIN_GIT_REPO/raw/master/fixlocale.sh | bash

## Update and upgrade
sudo apt-get update
sudo apt-get upgrade -y

## Major requirements
sudo apt-get install -y build-essential git

## Go home
cd /home/$USER

## Get sysadmin and provision scripts
sudo -u $USER -H bash -c "
if [ ! -d sysadmin ]; then
    git clone $SYSADMIN_GIT_REPO
fi
if [ ! -d provision ]; then
    bash sysadmin/setssh.sh $PRIVATE_KEY
    source .bash_profile
    git clone $PROVISION_GIT_REPO
fi"

## Add the new user
bash sysadmin/adduser.sh $NEW_USER

## Set SSH keys and install the component
sudo -u $NEW_USER -H bash -c "
bash sysadmin/setssh.sh $PRIVATE_KEY $PUBLIC_KEY
# bash provision/install.sh '$COMPONENT'"

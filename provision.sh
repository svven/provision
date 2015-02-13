#!/bin/bash
echo "
##############################################################################
## Provision (via Vagrant or EC2 User Data)
## User: $USER (e.g. root, vagrant, ubuntu)
##############################################################################"

COMPONENT=${1:-all} # (e.g.: postgre, redis, nginx, web, poller, summarizer)

NEW_USER=svven
PRIVATE_KEY=https://www.dropbox.com/s/5le6maruiold9lc/svven_rsa?dl=1
# PUBLIC_KEY=https://www.dropbox.com/s/5le6maruiold9lc/svven_rsa.pub?dl=1

BOOTSTRAP_GIT_REPO=https://github.com/svven/bootstrap.git
PROVISION_GIT_REPO=git@bitbucket.org:svven/provision.git

## Locale fix
## http://www.pixelninja.me/how-to-fix-invalid-locale-setting-in-ubuntu-14-04-in-the-cloud/
sudo locale-gen en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
echo "LC_ALL=\"en_US.UTF-8\"" | sudo tee -a /etc/environment /etc/default/locale
echo "LANGUAGE=\"en_US.UTF-8\"" | sudo tee -a /etc/environment /etc/default/locale

## Update and upgrade
sudo apt-get update
sudo apt-get upgrade -y

## Major requirements
sudo apt-get install -y build-essential git

## Go home
cd $HOME # /home/$USER

## Get public bootstrap scripts
if [ ! -d bootstrap ]; then
    git clone $BOOTSTRAP_GIT_REPO
fi

## Add new user and set SSH keys
sudo -u $USER -H bash bootstrap/adduser.sh $NEW_USER
sudo -u $NEW_USER -H bash bootstrap/setssh.sh $PRIVATE_KEY $PUBLIC_KEY

## Get private provision scripts
if [ ! -d provision ]; then
    sudo -u $USER -H bash bootstrap/gitclone.sh $PROVISION_GIT_REPO $PRIVATE_KEY
fi

## Install the component
sudo -u $NEW_USER -H bash provision/install.sh $COMPONENT

#!/bin/bash
echo "
############################################################
## Provision (via Vagrant or EC2 User Data)
############################################################
"

ADMIN=ubuntu; USER=svven; COMPONENT=redis;
PRIVATE_KEY=https://dl.dropboxusercontent.com/u/134594/svven/svven_rsa
PUBLIC_KEY=https://dl.dropboxusercontent.com/u/134594/svven/svven_rsa.pub

PROVISION=https://raw.githubusercontent.com/svven/provision/master/provision.sh
BOOTSTRAP_GIT=git@bitbucket.org:svven/bootstrap.git

## Get bootstrap scripts
curl $PROVISION | sudo -u $ADMIN -H bash -s $BOOTSTRAP_GIT $PRIVATE_KEY

## Go home
cd /home/$ADMIN

## Install the component
sudo -u $ADMIN -H bash bootstrap/install.sh \
    $ADMIN $USER $COMPONENT $PRIVATE_KEY $PUBLIC_KEY

#!/bin/bash
ADMIN=$1; USER=$2; COMPONENT=$3; PRIVATE_KEY=$4; PUBLIC_KEY=$5
echo "
############################################################
## Install component: $COMPONENT
## Admin: $ADMIN (e.g.: vagrant, ubuntu)
## User: $USER (e.g.: svven, ducu, jon etc.)
############################################################
"
if [ $# -lt 4 ]; then
    echo "
## Missing arguments:
##   1 - Admin (e.g.: vagrant, ubuntu)
##   2 - User (e.g.: svven, ducu, jon etc.)
##   3 - Component (e.g.: postgre, redis, web, poller etc.)
##   4 - User private deployment key (i.e. URL to id_rsa)
## Optional:
##   5 - User public key for SSH access (i.e. URL to id_rsa.pub)
############################################################"
fi

## Go home
cd /home/$ADMIN

## Init instance
sudo -u $ADMIN -H bash bootstrap/common/init.sh

## Check if user exists
egrep -i "^$USER:" /etc/passwd
if [ $? -eq 0 ]; then
    echo "User already exists: $USER"
else
    ## Add user
    sudo -u $ADMIN -H bash bootstrap/common/adduser.sh $USER
    ## Set ssh
    sudo -u $USER -H bash bootstrap/common/setssh.sh $PUBLIC_KEY $PRIVATE_KEY
fi

## Install component
echo "TODO: Install component"

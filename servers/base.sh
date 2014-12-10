#!/bin/bash
echo "
############################################################
## Base server
## User: $USER (e.g.: vagrant, ubuntu)
############################################################
"
if [ $# -lt 2 ]; then
    echo "Please provide following arguments:
## Mandatory:
##   $1 - Admin (e.g.: vagrant, ubuntu)
##   $2 - User (e.g.: svven, ducu, jon etc.)
## Optional:
##   $3 - User public key for SSH access (i.e. URL to id_rsa.pub)
##   $4 - User private key for deployment (i.e. URL to id_rsa)"
    exit 1
fi

## Go home
cd /home/$1

## Common
sudo -u $1 -H bash bootstrap/common/init.sh

## Check if user exists
egrep -i "^$2:" /etc/passwd
if [ $? -eq 0 ]; then
    echo "User already exists: $2"
else
    ## Add user
    sudo -u $1 -H bash bootstrap/common/adduser.sh $2
    ## Set ssh
    sudo -u $2 -H bash bootstrap/common/setssh.sh $3 $4
fi

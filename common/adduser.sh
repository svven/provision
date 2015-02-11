#!/bin/bash
echo "
############################################################
## Add user: $1
## User: $USER (e.g. vagrant, ubuntu)
############################################################
"
if [ $# -lt 1 ]; then
    echo "Please provide following arguments:
## Mandatory:
##   $1 - User (e.g.: svven, ducu, jon etc.)"
    exit 1
fi

## Create app and/or db specified user, and make it sudo
## http://brianflove.com/2013/06/18/add-new-sudo-user-to-ec2-ubuntu/
sudo adduser --quiet --gecos "" --ingroup sudo --disabled-password $1
echo "$1 ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/$1

## Check if group exists
egrep -i "^svven:" /etc/group
if [ $? -ne 0 ]; then
    ## Add group
    sudo addgroup svven
fi

## Also add it to svven
sudo adduser $1 svven

# sudo deluser --remove-home $1
# sudo deluser $1 sudo # remove from sudo group in the end

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

## Create app and/or db specified user, and make it admin
## http://brianflove.com/2013/06/18/add-new-sudo-user-to-ec2-ubuntu/
sudo adduser --quiet --gecos "" --ingroup sudo --disabled-password $1
echo "$1 ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/$1

# sudo userdel -r $1
# gpasswd -d $1 sudo # remove from admin group in the end

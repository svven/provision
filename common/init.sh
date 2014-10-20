#!/bin/bash
echo "
############################################################
## Initialize
## User: $USER (e.g.: vagrant, ubuntu)
############################################################
"

## Locale fix
## http://www.pixelninja.me/how-to-fix-invalid-locale-setting-in-ubuntu-14-04-in-the-cloud/
sudo locale-gen en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
echo "LC_ALL=\"en_US.UTF-8\"" | sudo tee -a /etc/environment /etc/default/locale
echo "LANGUAGE=\"en_US.UTF-8\"" | sudo tee -a /etc/environment /etc/default/locale

sudo apt-get update
sudo apt-get upgrade -y

## Major requirements
sudo apt-get install -y build-essential
sudo apt-get update # again

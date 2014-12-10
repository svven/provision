#!/bin/bash
echo "
############################################################
## PostgreSQL server
## User: $USER (e.g.: svven)
############################################################
"

## Go home
cd $HOME
## Locale fix just in case
export LC_ALL=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

## Install git
sudo apt-get install -y git

## Install postgre
sudo apt-get install -y postgresql postgresql-contrib

## And again
# sudo apt-get update
# sudo apt-get -y upgrade

## Start the profile
source .bash_profile

# ## Either clone or symlink the code
# if [ $1 == "-c" ]; then
#     # git init
#     # git remote add origin git@bitbucket.org:svven/postgre.git
#     # git pull origin master
#     git clone git@bitbucket.org:svven/postgre.git
# elif [ -d /project/postgre ]; then
#     ln -s /project/postgre postgre
# fi

# if [ -d ${HOME}/postgre ]; then
# 	cd ${HOME}/postgre
# else
# 	echo "Failed loading postgre repo."
# 	exit 1
# fi

# ## TODO: Copy or link ../conf/postgre.conf if any

# ## Create db role
sudo -u postgres createuser $USER
# # sudo -u postgres dropuser $USER

# ## Create db for role
sudo -u postgres createdb --owner $USER $USER
# # sudo -u postgres dropdb $USER

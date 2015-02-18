#!/bin/bash
VER="9.3"; POSTGRE_VER="postgresql-$VER"
echo "
##############################################################################
## PostgreSQL server ($POSTGRE_VER)
## User: $USER (e.g.: svven)
##############################################################################
"

DIR=$( cd "$( dirname "$0" )/.." && pwd )

## Go home
cd $HOME # /home/$USER

## Install
sudo apt-get install -y $POSTGRE_VER postgresql-contrib

## Configure
sudo cp $DIR/conf/postgresql.conf /etc/postgresql/$VER/main/postgresql.conf

## Database
sudo -u postgres createuser $USER ## dropuser $USER
sudo -u postgres createdb --owner $USER $USER ## dropdb $USER
sudo -u $USER psql -c "grant all privileges on database $USER to $USER;"

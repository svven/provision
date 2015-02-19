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
sudo cp $DIR/conf/pg_hba.conf /etc/postgresql/$VER/main/pg_hba.conf
echo "
host $USER $USER samenet trust" | sudo tee -a /etc/postgresql/$VER/main/pg_hba.conf
sudo service postgresql reload

## Database
sudo -u postgres createuser -D -A $USER ## dropuser $USER
sudo -u postgres createdb -O $USER $USER ## dropdb $USER
psql -c "grant all privileges on database $USER to $USER;"

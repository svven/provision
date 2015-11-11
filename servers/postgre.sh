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

## Rsyslog
## https://askubuntu.com/questions/95910/command-for-determining-my-public-ip
LOCALHOSTNAME=$( curl -s ipecho.net/plain ; echo )
PAPERTRAIL_HOST="logs3.papertrailapp.com"
PAPERTRAIL_PORT="20728"
eval "echo \"$(< $DIR/conf/rsyslog/rsyslog.conf)\"" | sudo tee /etc/rsyslog.conf
sudo service rsyslog restart

## Install
sudo apt-get install -y $POSTGRE_VER postgresql-contrib

## Stop service
sudo service postgresql stop

## Configure
sudo cp $DIR/conf/postgre/postgresql.conf /etc/postgresql/$VER/main/postgresql.conf
sudo cp $DIR/conf/postgre/pg_hba.conf /etc/postgresql/$VER/main/pg_hba.conf
echo "
host $USER $USER samenet trust" | sudo tee -a /etc/postgresql/$VER/main/pg_hba.conf

## Start service
sudo service postgresql start

## Database
sudo -u postgres createuser -D -A $USER ## dropuser $USER
sudo -u postgres createdb -O $USER $USER ## dropdb $USER
psql -c "grant all privileges on database $USER to $USER;"

#!/bin/bash
PYTHON_VER="2.7.8"
echo "
##############################################################################
## Base app (python $PYTHON_VER)
## User: $USER (e.g.: svven, ducu, jon etc.)
##############################################################################
"

## Go home
cd $HOME # /home/$USER

## Pyenv requirements
## https://github.com/yyuu/pyenv/wiki/Common-build-problems
sudo apt-get install -y libbz2-dev libreadline-dev libsqlite3-dev libssl-dev

## Install pip
sudo apt-get install -y python-pip

## Install dependencies of requirements
sudo apt-get install -y libjpeg8-dev # PIL
sudo apt-get install -y libpq-dev # psycopg2
# sudo apt-get build-dep python-lxml # probably not needed
sudo apt-get install -y python-dev lib32z1-dev libxml2-dev libxslt1-dev # lxml

## Install supervisor
sudo apt-get install -y supervisor

## Set up pyenv
## https://github.com/yyuu/pyenv-installer
# git clone https://github.com/yyuu/pyenv.git ~/.pyenv # not this way
curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash

## Put following in $USER's .bash_profile
cat << "EOF" >> .bash_profile
## Pyenv
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
EOF

## And source it
source .bash_profile

## Set up pyenv
pyenv update
pyenv install $PYTHON_VER
pyenv rehash
pyenv global $PYTHON_VER

## Set up pyenv-virtualenv, but should be set already
pyenv virtualenv env
# git clone https://github.com/yyuu/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv

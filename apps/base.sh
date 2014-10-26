#!/bin/bash
echo "
############################################################
## Base app
## User: $USER (e.g.: svven, ducu, jon etc.)
############################################################
"

## Go home
cd $HOME
## Locale fix just in case
export LC_ALL=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

## Install git
sudo apt-get install -y git

## Pyenv requirements
## https://github.com/yyuu/pyenv/wiki/Common-build-problems
sudo apt-get install -y libbz2-dev libreadline-dev libsqlite3-dev libssl-dev
# sudo apt-get install -y llvm

## Install pip
sudo apt-get install -y python-pip

## Install dependencies of requirements
# sudo apt-get build-dep python-lxml # probably not needed
sudo apt-get install -y python-dev lib32z1-dev libxml2-dev libxslt1-dev # lxml
sudo apt-get install -y libjpeg8-dev # PIL
sudo apt-get install -y libpq-dev # psycopg2

## Install supervisor
sudo apt-get install -y supervisor

## And again
# sudo apt-get update
# sudo apt-get -y upgrade

## Set up pyenv
## https://github.com/yyuu/pyenv-installer
# git clone https://github.com/yyuu/pyenv.git ~/.pyenv # not this way
curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash

## Put following in $USER's .bash_profile
touch .bash_profile
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
pyenv install 2.7.7
pyenv rehash
pyenv global 2.7.7

## Set up pyenv-virtualenv, but should be set already
# git clone https://github.com/yyuu/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv

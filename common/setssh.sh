#!/bin/bash
echo "
############################################################
## Set ssh
## User: $USER (e.g.: svven, ducu, jon etc.)
############################################################
"

## Make sure
cd $HOME

if [ ! -d .ssh ]; then
    mkdir .ssh; chmod 700 .ssh
fi

if [ ! -f .ssh/known_hosts ]; then
    ## Add bitbucket.org to known hosts
    touch .ssh/known_hosts; chmod 600 .ssh/known_hosts
    ssh-keygen -R bitbucket.org; ssh-keyscan -H bitbucket.org > .ssh/known_hosts
fi

if [ $# -lt 1 ]; then
    echo "Nothing to set. Missing arguments:
## Optional:
##   $1 - User public key for SSH access (i.e. URL to id_rsa.pub)
##   $2 - User private key for deployment (i.e. URL to id_rsa)"
    exit 0
fi

if [ $1 ]; then
    # No password ssh access
    curl $1 > .ssh/id_rsa.pub
    cat .ssh/id_rsa.pub > .ssh/authorized_keys
    chmod 600 .ssh/authorized_keys
fi

if [ $2 ]; then
    ## Set ssh deployment keypair
    curl $2 > .ssh/id_rsa
    chmod 600 .ssh/id_rsa
fi

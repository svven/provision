#!/bin/bash
echo "
############################################################
## Set ssh
## User: $USER (e.g.: svven, ducu, jon etc.)
############################################################
"
if [ $# -lt 1 ]; then
    echo "Not much to set. Missing arguments:
## Optional:
##   $1 - User public key for SSH access (i.e. URL to id_rsa.pub)
##   $2 - User private key for deployment (i.e. URL to id_rsa)"
fi

## Go home
cd $HOME

if [ ! -d .ssh ]; then
    mkdir .ssh; chmod 700 .ssh
fi

if [ ! -f .ssh/known_hosts ]; then
    ## Add bitbucket.org to known hosts
    touch .ssh/known_hosts; chmod 600 .ssh/known_hosts
    ssh-keygen -R bitbucket.org; ssh-keyscan -H bitbucket.org > .ssh/known_hosts
fi

if [ ! -f .bash_profile ]; then
    touch .bash_profile
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

cat << "EOF" >> .bash_profile
## SSH agent
SSH_ENV="$HOME/.ssh/environment"
function start_agent {
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;
}
## Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    #ps ${SSH_AGENT_PID} doesn't work under cywgin
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi
EOF

Provision
=========

Centralized repo containing provisioning scripts for various system components.

AMI: ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-20140927
Ubuntu Server 14.04 LTS (Trusty Tahr) http://cloud-images.ubuntu.com/releases/14.04/

This repo can be deployed on AWS EC2 by calling `base.sh` via cloud-init user data. It gets and uses a set of sysadmin helper scripts from https://bitbucket.org/svven/sysadmin, and it sets up working user. Resulting instance can be registered as base AMI for further provisioning.

Call `install.sh` with available arguments to install one or more components (e.g. "postgre", "nginx web app").

Base AMI: xxx
AMI with working user (svven) ready for component setup.

When starting from the base AMI, call `setup.sh` with desired variables.

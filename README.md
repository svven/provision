Provision
=======

Centralized repo containing provisioning scripts for various system components.

Base AMI: **ami-f0b11187**  
Ubuntu Server 14.04 LTS (Trusty Tahr) http://cloud-images.ubuntu.com/releases/14.04/

This repo can be deployed on AWS EC2 by calling `provision.sh` via cloud-init user data. It gets and uses a set of sysadmin helper scripts from https://bitbucket.org/svven/sysadmin

Call `install.sh` with available arguments to provision a single component, or manually call existing provisioning scripts to install several components on the same instance (e.g. poller and summarizer).

When starting from vanilla AMI, user data script can look like

```
#!/bin/bash
sudo -u svven -H bash /home/ubuntu/provision/install.sh "nginx web app"
```

Bootstrap
=========

Centralized repo containing bootstrap scripts for various system components. 

Each system component such as 'web', 'poller' and 'rdbms' is coded in its own git repo. Every repo contains a script named `provision.sh` that is used for provisioning, and that relies on its specific set of scripts that are found in this 'bootstrap' repo.

Make sure you make these scripts available on the box before running the provision routine. It can be done either through a shared folder on vagrant, or by scp-ing the 'bootstrap' folder to the AWS instance. The default location would be the home directory of the admin user (e.g.: ubuntu, vagrant) that is running the routine.


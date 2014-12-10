Bootstrap
=========

Centralized repo containing bootstrap scripts for various system components. 

Use `install.sh` with available arguments to bootstrap a single component, or manually call various scripts to install several components on the same instance (e.g. poller and summarizer).

Deploying this repo can be done either through a shared folder on vagrant, or by scp-ing the 'bootstrap' folder to the AWS instance. The default location would be the home directory of the admin user (e.g.: ubuntu, vagrant) that is running the routine.


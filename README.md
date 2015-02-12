Provision
=======

Centralized repo containing provisioning scripts for various system components.

Use `install.sh` with available arguments to provision a single component, or manually call existing scripts to install several components on the same instance (e.g. poller and summarizer).

Deploying this repo can be done either through a shared folder on vagrant, by scp-ing the 'provision' folder to the instance, or by running the bootstrap scripts available on github (https://github.com/svven/bootstrap).
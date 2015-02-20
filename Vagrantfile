# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "ubuntu/trusty64" # "phusion/ubuntu-14.04-amd64"

  config.vm.network "forwarded_port", guest: 80, host: 8080 # web

  # config.vm.synced_folder "../", "/project", 
  #   owner: "svven", group: "devs", mount_options: ["dmode=750,fmode=640"]
  config.vm.synced_folder "../sysadmin/", "/home/ubuntu/sysadmin"
  config.vm.synced_folder "../provision/", "/home/ubuntu/provision"

  config.vm.provision :shell, path: "../provision/provision.sh", 
    keep_color: "true" #, args: "web"

  config.vm.provider "virtualbox" do |vb|
    vb.name = "all"
    vb.customize ["modifyvm", :id, "--memory", "512"]
  end

end

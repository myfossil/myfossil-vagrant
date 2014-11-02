# -*- mode: ruby -*-
project_name = "myfossil"

VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"

  # Create a forwarded port mapping which allows access to a specific port
  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "forwarded_port", guest: 3306, host: 13306

  # Configure VirtualBox options
  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.customize ["modifyvm", :id, "--memory", "1024", "--natdnshostresolver1", "on"]
  end

  # Puppet manifests
  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path = "puppet/local/manifests"
    puppet.module_path = "puppet/local/modules"
    puppet.manifest_file  = "init.pp"
  end

  # Set hostname using vagrant-hostmanager plugin
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true

  # Configure WordPress server
  config.vm.define :myfossil, primary: true do |wp|
    wp.vm.hostname = project_name + ".local"
    wp.vm.network :private_network, :ip => '10.0.0.5'
    wp.hostmanager.aliases = [ project_name + ".dev" ]
    wp.vm.provision :hostmanager
  end
end

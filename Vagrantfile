# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"
  config.vm.hostname = "local-server-u18"
  config.disksize.size = "20GB"
  config.vm.network "public_network", ip: "192.168.0.19"
  config.vm.synced_folder "d:/codes", "/projects"
  config.vm.provider "virtualbox" do |vb|
    # Customize the amount of memory on the VM:
    vb.memory = "4096"
  end
  config.vm.provision "shell", path: "bootstrap.sh" 
  config.vm.provision "file", source: "config.fish", destination: "/home/vagrant/.config/fish/config.fish"
  config.vm.provision "shell", path: "configuration.sh", privileged: false
end

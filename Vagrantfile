# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  (1..6).each do |i|
    config.vm.define "test#{i}" do |node|
      node.vm.box = "box-cutter/centos72"
      node.vm.hostname = "test#{i}"
      node.vm.network :private_network, ip: "10.0.15.1#{i}"
      node.vm.provider "virtualbox" do |vb|
        vb.memory = "1024"
      end
    end
  end


end

# -*- mode: ruby -*-
# vi: set ft=ruby :

dir = Dir.pwd
vagrant_dir = File.expand_path(File.dirname(__FILE__))

# Vagrantfile API/syntax version.
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at docs.vagrantup.com/v2/.

  # Default Ubuntu Box (feel free to (i) comment out the URL for the default
  # box; and (ii) uncomment the URL for the 64-bit box; or (iii) forego
  # either of the boxes provided, in favor of your own `vagrant box`).
  #
  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "ubuntu"
  #
  # The URL from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system. Sources of other Vagrant
  # boxes are provided in this Project's README.
  #
  # 32-bit Ubuntu 12.04 LTS
  config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/precise/current/precise-server-cloudimg-i386-vagrant-disk1.box"
  #
  # 64-bit Ubuntu 12.04 LTS
  # config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/precise/current/precise-server-cloudimg-amd64-vagrant-disk1.box"
  config.vm.hostname = "ubuntu"

  # Forward Agent
  #
  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  config.ssh.forward_agent = true

  # VirtualBox-specific configuration, to fine-tune various options; as
  # described in http://docs.vagrantup.com/v2/virtualbox/configuration.html
  #
  config.vm.provider :virtualbox do |vb|
  # Boot with graphical user interface ("GUI")
    vb.gui = true
  #
  # You may have to comment out or tinker with the values of some of the
  # customizations, below, to suit the needs/limits of your local machine.
  #
  # Optimized for an Ubuntu 12.04 32-bit VM on a host running Windows XP SP3 32-bit
    # Set the amount of RAM, in MB, that the VM should allocate for itself, from the host
    #vb.customize ["modifyvm", :id, "--memory", "1024"]
    # Allow the VM to display the desktop environment
    #vb.customize ["modifyvm", :id, "--graphicscontroller", "vboxvga"]
    # Set the amount of RAM that the virtual graphics card should have
    #vb.customize ["modifyvm", :id, "--vram", "64"]
    # Advanced Programmable Interrupt Controllers (APICs) are a newer x86 hardware feature
    #vb.customize ["modifyvm", :id, "--ioapic", "on"]
    # Default host uses a USB mouse instead of PS2
    #vb.customize ["modifyvm", :id, "--mouse", "usb"]
    # Enable audio support for the VM & specify the audio controller
    #vb.customize ["modifyvm", :id, "--audio", "dsound", "--audiocontroller", "ac97"]
    # Enable the VM's virtual USB controller & enable the virtual USB 2.0 controller
    #vb.customize ["modifyvm", :id, "--usb", "on", "--usbehci", "on"]
    # Add IDE controller to the VM, to allow virtual media to be attached to the controller
    #vb.customize ["storagectl", :id, "--name", "IDE Controller", "--add", "ide"]
    # Give the VM access to the host's CD/DVD drive, by attaching the medium to the virtual IDE controller
    #vb.customize ["storageattach", :id, "--storagectl", "IDE Controller", "--port 0", "--device 0", "--type", "dvddrive"]
  #
  # For a 64-bit VM (courtesy of https://gist.github.com/mikekunze/7486548#file-ubuntu-desktop-vagrantfile)
  # vb.customize ["modifyvm", :id, "--memory", "2048"]
    # Set the number of virtual CPUs for the virtual machine
  # vb.customize ["modifyvm", :id, "--cpus", "2"]
  # vb.customize ["modifyvm", :id, "--graphicscontroller", "vboxvga"]
  # vb.customize ["modifyvm", :id, "--vram", "128"]
    # Enabling the I/O APIC is required for 64-bit guest operating systems, especially Windows Vista;
    # it is also required if you want to use more than one virtual CPU in a VM.
  # vb.customize ["modifyvm", :id, "--ioapic", "on"]
    # Enable the use of hardware virtualization extensions (Intel VT-x or AMD-V) in the processor of your host system
  # vb.customize ["modifyvm", :id, "--hwvirtex", "on"]
    # Enable, if Guest Additions are installed, whether hardware 3D acceleration should be available
  # vb.customize ["modifyvm", :id, "--accelerate3d", "on"]
  #
  # See Chapter 8. VBoxManage | VirtualBox Manual located @ virtualbox.org/manual/ch08.html
  # for more information on available options.
  end
  
  # Provisioning
  #
  # Process one or more provisioning scripts depending on the existence of custom files.
  #
  # provison-pre.sh
  #
  # provison-pre.sh acts as a pre-hook to the default provisioning script. Anything that
  # should run before the shell commands laid out in bootstrap.sh (or your provision-custom.sh
  # file) should go in this script. If it does not exist, no extra provisioning will run.
  if File.exists?(File.join(vagrant_dir,'provision','provision-pre.sh')) then
    config.vm.provision :shell, :path => File.join( "provision", "provision-pre.sh" )
  end
  #
  # bootstrap.sh or provision-custom.sh
  #
  # By default, our Vagrantfile is set to use the bootstrap.sh bash script located in the
  # provision directory. If it is detected that a provision-custom.sh script has been
  # created, it is run as a replacement. This is an opportunity to replace the entirety
  # of the provisioning provided by the default bootstrap.sh.
  if File.exists?(File.join(vagrant_dir,'provision','provision-custom.sh')) then
    config.vm.provision :shell, :path => File.join( "provision", "provision-custom.sh" )
  else
    config.vm.provision :shell, :path => File.join( "provision", "bootstrap.sh" )
  end
  #
  # provision-post.sh
  #
  # provision-post.sh acts as a post-hook to the default provisioning. Anything that should
  # run after the shell commands laid out in bootstrap.sh or provision-custom.sh should be
  # put into this file. This provides a good opportunity to install additional packages
  # without having to replace the entire default provisioning script.
  if File.exists?(File.join(vagrant_dir,'provision','provision-post.sh')) then
    config.vm.provision :shell, :path => File.join( "provision", "provision-post.sh" )
  end
end

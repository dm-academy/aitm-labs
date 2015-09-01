# Running Vagrant on the Course Server #

Vagrant is already installed on the SEIS660 course server, but you need to take a few steps before you can use it. 
Assuming you have .ssh configured and have logged in, you should find yourself in your default directory.

Note, in the following instructions when you see teststu1, substitute your user id. 

Do not type the "$" symbol - this represents the command prompt you see when you log into Linux. It may also be a "#" or have some directory information in front of it, e.g. 

	teststu1@seis660:~$

First, always confirm where you are by issuing the "pwd" (print working directory) command:

    $ pwd
    /home/student/teststu1

and examine what is in your directory:

	teststu1@seis660:~$ ls -al
	total 28
	drwxr-xr-x  6 teststu1 student 4096 Feb  8 11:37 .
	drwxr-xr-x 25 root     root    4096 Feb  8 11:28 ..
	-rw-------  1 teststu1 student  263 Feb  8 11:34 .bash_history
	-rw-r--r--  1 teststu1 student  220 Feb  8 11:28 .bash_logout
	-rw-r--r--  1 teststu1 student 3760 Feb  8 11:28 .bashrc
	-rw-r--r--  1 teststu1 student  675 Feb  8 11:28 .ssh

In any command line environment, it is good to run these commands (pwd and ls, or their equivalents) frequently so you maintain situational awareness of where you are and what might be affected by any commands you run. 

Now, make a "vagrant" directory:

	teststu1@seis660:~$ mkdir vagrant
	teststu1@seis660:~$

Type "ls -al" again:

	total 28
	drwxr-xr-x  6 teststu1 student 4096 Feb  8 11:37 .
	drwxr-xr-x 25 root     root    4096 Feb  8 11:28 ..
	-rw-------  1 teststu1 student  263 Feb  8 11:34 .bash_history
	-rw-r--r--  1 teststu1 student  220 Feb  8 11:28 .bash_logout
	-rw-r--r--  1 teststu1 student 3760 Feb  8 11:28 .bashrc
	-rw-r--r--  1 teststu1 student  675 Feb  8 11:28 .profile
	-rw-r--r--  1 teststu1 student  675 Feb  8 11:28 .ssh 
	drwxr-xr-x  2 teststu1 student 4096 Feb  8 12:19 vagrant

Confirm that you now have the directory. 

Change to it:

	teststu1@seis660:~$ cd vagrant
	teststu1@seis660:~/vagrant$

Type the following command carefully:

	teststu1@seis660:~/vagrant$ vagrant init precise64

You should see the following:

	A `Vagrantfile` has been placed in this directory. You are now
	ready to `vagrant up` your first virtual environment! Please read
	the comments in the Vagrantfile as well as documentation on
	`vagrantup.com` for more information on using Vagrant.
	teststu1@seis660:~/vagrant$
	
If you get an error with "vagrant up" like this:

````
An error occurred while downloading the remote file. The error message, if any, is reproduced below. Please fix this error and try again.


Couldn't open file /home/student/akou0009/vagrant/precise64
````

try 

    vagrant box add "precise64" http://files.vagrantup.com/precise64.box

Now, let's try something that will not work:

	teststu1@seis660:~/vagrant$ vagrant up
	Bringing machine 'default' up with 'virtualbox' provider...
	==> default: Importing base box 'precise64'...
	==> default: Matching MAC address for NAT networking...
	==> default: Setting the name of the VM: vagrant_default_1423420554497_66907
	==> default: Fixed port collision for 22 => 2222. Now on port 2203.
	==> default: Clearing any previously set network interfaces...
	==> default: Preparing network interfaces based on configuration...
	    default: Adapter 1: nat    ==> default: Forwarding ports...
	    default: 22 => 2203 (adapter 1)    ==> default: Booting VM...
	==> default: Waiting for machine to boot. This may take a few minutes...
	The private key to connect to the machine via SSH must be owned
	by the user running Vagrant. This is a strict requirement from
	SSH itself. Please fix the following key to be owned by the user
	running Vagrant:
	
	/var/vagrant/.vagrant.d/insecure_private_key
	teststu1@seis660:~/vagrant$

What happened? Let's do a little troubleshooting. Unlike a lot of error messages, this one gives you everything you need to fix the problem. It's an ownership issue with a file called "insecure_private_key" in the directory  /var/vagrant/.vagrant.d/.

When you create a new virtual machine with Vagrant and VirtualBox, Vagrant needs to be able to talk to it on your behalf, and uses .ssh for this purpose. Just as we created a private key for you to hold on your laptop, with a matching public key on the server, so you need to have ANOTHER private/public key pair to communicate between your ssh session running directly on seis660, and your new virtual machine. And, because the Vagrant machine is pre-baked (more on this to come), you have to start by using a predefined key pair that comes with Vagrant. 

Review the image below. Right-click and open the image below in its own window or tab if it is too small.  ![architecture](Resources/sshDetails.jpg) 


So, let's copy the key to your own .ssh directory. First, we need to clean up our failed attempt:

	teststu1@seis660:~$ vagrant destroy
	default: Are you sure you want to destroy the 'default' VM? [y/N] y
	==> default: Forcing shutdown of VM...
	==> default: Destroying VM and associated drives...

Then:

	teststu1@seis660:~$ pwd
	/home/student/teststu1/vagrant
	teststu1@seis660:~$ cd ../.ssh
	teststu1@seis660:~/.ssh$ cp /var/SEIS660/public/insecure_private_key .   #DON"T miss the period there
	teststu1@seis660:~/.ssh$ ls -al
	total 12
	drwxr-xr-x 2 teststu1 student 4096 Feb  8 13:45 .
	drwxr-xr-x 6 teststu1 student 4096 Feb  8 13:18 ..
	-rw-r--r-- 1 teststu1 student    0 Feb  8 13:18 authorized_keys
	-rw-r----- 1 teststu1 student 1675 Feb  8 13:45 insecure_private_key
	teststu1@seis660:~/.ssh$ chmod 600 insecure_private_key
	teststu1@seis660:~/.ssh$ ls -al
	total 12
	drwxr-xr-x 2 teststu1 student 4096 Feb  8 13:45 .
	drwxr-xr-x 6 teststu1 student 4096 Feb  8 13:18 ..
	-rw-r--r-- 1 teststu1 student    0 Feb  8 13:18 authorized_keys
	-rw------- 1 teststu1 student 1675 Feb  8 13:45 insecure_private_key

What did we just do? 

1. We changed our working directory to .ssh
2. We copied the key there
3. We changed the permissions on the key so that only we can read and write it (ssh requires this).
However, this isn't enough. We need to tell Vagrant to look at this key, not its default. So:


```
teststu1@seis660:~/.ssh$ cd ../vagrant/	
teststu1@seis660:~/vagrant$ nano Vagrantfile
GNU nano 2.2.6                   File: Vagrantfile

# -*- mode: ruby -*-
	  
# vi: set ft=ruby :
	
# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
# The most common configuration options are documented and commented below.
# For a complete reference, please see the online documentation at
# https://docs.vagrantup.com.
	
# Every Vagrant development environment requires a box. You can search for
# boxes at https://atlas.hashicorp.com/search.
	  config.vm.box = "precise64"
	
# Disable automatic box update checking. If you disable this, then
# boxes will only be checked for updates when the user runs
# `vagrant box outdated`. This is not recommended.
# config.vm.box_check_update = false

# Create a forwarded port mapping which allows access to a specific port
# within the machine from a port on the host machine. In the example below,
# accessing "localhost:8080" will access port 80 on the guest machine.
# config.vm.network "forwarded_port", guest: 80, host: 8080

# Create a private network, which allows host-only access to the machine
# using a specific IP.
# config.vm.network "private_network", ip: "192.168.33.10"

# Create a public network, which generally matched to bridged network.
# Bridged networks make the machine appear as another physical device on
# your network.
# config.vm.network "public_network"

# Share an additional folder to the guest VM. The first argument is
# the path on the host to the actual folder. The second argument is
# the path on the guest to mount the folder. And the optional third
# argument is a set of non-required options.
# config.vm.synced_folder "../data", "/vagrant_data"

# Provider-specific configuration so you can fine-tune various
# backing providers for Vagrant. These expose provider-specific options.
# Example for VirtualBox:
#
# config.vm.provider "virtualbox" do |vb|
#   # Display the VirtualBox GUI when booting the machine
#   vb.gui = true
#
#   # Customize the amount of memory on the VM:
#   vb.memory = "1024"
# end
#
# View the documentation for the provider you are using for more
# information on available options.

# Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
# such as FTP and Heroku are also available. See the documentation at
# https://docs.vagrantup.com/v2/push/atlas.html for more information.
# config.push.define "atlas" do |push|
#   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
# end

# Enable provisioning with a shell script. Additional provisioners such as
# Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
# documentation for more information about their specific syntax and use.
# config.vm.provision "shell", inline: <<-SHELL
#   sudo apt-get update
#   sudo apt-get install -y apache2
# SHELL
end
                                [ Read 71 lines ]
^G Get Help     ^O WriteOut     ^R Read File    ^Y Prev Page    ^K Cut Text     ^C Cur Pos
^X Exit         ^J Justify      ^W Where Is     ^V Next Page    ^U UnCut Text   ^T To Spell
```	

The above is a representation of being in nano, a simple editor for Linux (easier to learn than vi). In the Vagrantfile, use your down arrow key until you find the line:

	config.vm.box = "precise64"

and immediately under it, add the line:

	  config.ssh.private_key_path = "~/.ssh/insecure_private_key"

Holding down the Ctrl key, type the letter X. At the bottom of the screen it will say

	Save modified buffer (ANSWERING "No" WILL DESTROY CHANGES) ?

Type Y

It will then say:

	File Name to Write: Vagrantfile

Hit Return. 

Now, you should be able to start your virtual machine!

	teststu1@seis660:~/vagrant$ vagrant up
	Bringing machine 'default' up with 'virtualbox' provider...
	==> default: VirtualBox VM is already running.
	teststu1@seis660:~/vagrant$ vagrant destroy
	    default: Are you sure you want to destroy the 'default' VM? [y/N] y
	==> default: Forcing shutdown of VM...
	==> default: Destroying VM and associated drives...
	teststu1@seis660:~/vagrant$ vagrant up
	Bringing machine 'default' up with 'virtualbox' provider...
	==> default: Importing base box 'precise64'...
	==> default: Matching MAC address for NAT networking...
	==> default: Setting the name of the VM: vagrant_default_1423425861594_60243
	==> default: Fixed port collision for 22 => 2222. Now on port 2203.
	==> default: Clearing any previously set network interfaces...
	==> default: Preparing network interfaces based on configuration...
	    default: Adapter 1: nat
	==> default: Forwarding ports...
	    default: 22 => 2203 (adapter 1)
	==> default: Booting VM...
	==> default: Waiting for machine to boot. This may take a few minutes...
	    default: SSH address: 127.0.0.1:2203
	    default: SSH username: vagrant
	    default: SSH auth method: private key
	    default: Warning: Connection timeout. Retrying...
	    default:
	    default: Vagrant insecure key detected. Vagrant will automatically replace
	    default: this with a newly generated keypair for better security.
	    default:
	    default: Inserting generated public key within guest...
	    default: Removing insecure key from the guest if its present...
	    default: Key inserted! Disconnecting and reconnecting using new SSH key...
	==> default: Machine booted and ready!
	==> default: Checking for guest additions in VM...
	    default: The guest additions on this VM do not match the installed version of
	    default: VirtualBox! In most cases this is fine, but in rare cases it can
	    default: prevent things such as shared folders from working properly. If you see
	    default: shared folder errors, please make sure the guest additions within the
	    default: virtual machine match the version of VirtualBox you have installed on
	    default: your host and reload your VM.
	    default:
	    default: Guest Additions Version: 4.2.0
	    default: VirtualBox Version: 4.3
	==> default: Mounting shared folders...
	    default: /vagrant => /home/student/teststu1/vagrant
	teststu1@seis660:~/vagrant$

Congratulations! But, what does this all mean? 

You now have your own personal Linux machine, operating within the main course server, on which you are the administrator. You have tremendous freedom to experiment with its configuration. If you damage something, you simply need to exit out to the main server command prompt and run "vagrant destroy." This will erase the machine. You can then run "vagrant up" again and the machine will be restored. Note, if you destroy the VM you will LOSE ALL DATA you have on the machine, unless that data is stored in your ~/vagrant directory.

DO NOT ATTEMPT to bridge your VM to the external world. It is not hardened and possibly vulnerable. As long as you do not mess with the network configuration, you will be fine. In a future lab, you will see how to run Firefox on the course server in a X11 window over ssh on your local machine, so you can safely browse to your VM. 

For further information, see https://docs.vagrantup.com/.

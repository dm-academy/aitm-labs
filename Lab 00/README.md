# Lab-00
## Configure ssh access to a remote server

**Note: This is a rough copy of the lab instructions for an already-passed lab. They need further work for the next semester.**


**Objectives for this lab:**
* Configure your machine
* Securely connect to course server
* Learn basic skills of navigating Linux command line.
* Collaborate and support each other. 
* (Optional) Configure VirtualBox & Vagrant

**Prerequisites:**

Access to a Windows, Mac or Linux machine on the St. Thomas network. 

**Tasks: 
**

* Log into discussion board and lecture hall
* Configuring your machine:
	* Classroom machine: PuTTY should be installed
	* On MacOS, go to Applications|Utilities|Terminal and put it in your Dock. 
	* Windows on your laptop: install PuTTY and PuTTYGen
	* http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html    

Advanced Windows: install Cygwin for SSH from command line. This allows use of command line SSH from the Windows prompt, and standard OpenSSH tools. 		
You may also use TeraTerm, Bitvise, or any other SSH client of your choice. You’re on your own for this. 


**Accessing the course server:**	

Windows: follow these instructions 

http://www.ualberta.ca/CNS/RESEARCH/LinuxClusters/pka-putty.html

Navigate to

Copy the PUBLIC key to your clipboard. 
	
Mac: bring up your Terminal application (under Applications|Utilities). Type:
	
    $ cd
    $ ssh-keygen
    $ cat id_rsa.pub
		
You will get output like:
```
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDRycwk4jklWQyzmXi/QtM6ky+85O3C5291GDCOuvzn3Q4t83Sv2wkN69aLhLk53Lfw5SU1unOWb0Cj2xi+El8D5oR+Yncovz53uqSFmiDuHKNH3bQBUS4v15n6AkJ9nqvJtJZ0iuFD1zSlP3JqeSk5e2NPCmqSbWKEOijOsGWeVHxbs2z8I5PcD2Yrd9nDwhpg84eRUHamgZvvDS83lb5A0cUK5lQXr6zinAhWsELtCZCfSOYf5gaL3ADI53hSHekDMeJvK0r+em0NLb9dwSJnJJYBJ+Eb8xhj+hSrw3pkSHGhsPYDth99vkDnPdSQNrNoVhwmJxa3T4sbLy2O+WWn Char@Charless-MacBook-Air.local
```

Copy this to your Clipboard (highlight and command-V). 	

Both PC and Mac, when you have your key copied to the clipboard:

Paste this to the “Access Requests” topic in the discussion board following the example of the “Test Student Access Request,” and an admin will install it on the server in your home directory. 

Class discussion: why didn’t I automate this? It would have been a simple script to generate all of these on the server and then email you your private keys. 

Learning Linux
* Log in to seis660.gps.stthomas.edu
* Log into your account on the server. 
* Run the first 2 Linux tutorials. 
    * http://www.ee.surrey.ac.uk/Teaching/Unix/unix1.html
    * http://www.ee.surrey.ac.uk/Teaching/Unix/unix2.html
* Recommended: Run as many of these as you have time for. 
	
If you have trouble, do not raise your hand. Instead, first ask the question in the chat room. If you are still having trouble after 5 minutes, post a question to the Github forum. 

WHEN you are done with the lab, log into the chat room and discussion board and assist until all of your classmates are done.

Lab 02 preview/prep: 

Download and install VirtualBox and Vagrant on your local system (these are not yet available on the classroom machines).  Next week, we will work on setting these up. 

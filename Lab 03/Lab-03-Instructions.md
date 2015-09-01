# IT Infrastructure Lab 3 Instructions #
**Overview** 

In this lab, you will get a very simple introduction to the concept of "infrastructure as code" using shell scripting on your virtual machine in conjunction with Git and Github

**Prerequisites**

Lab 1: You must have configured ssh and run the Linux tutorial (or be comfortable otherwise with Linux command-line tools). 

Lab 2: You must have successfully created your own virtual machine (VM) using Vagrant. 


## Part 1: Command line operations ##

You will do the exercises in this part on your new Vagrant VM. 

Using the skills you learned in the previous lab,  perform the following steps:

**Configure a directory structure**
   
* Directory A should contain directories B, C and D

* Directory C should contain directories E and F

* Directory D should contain directories G, H and I

* Directory H should contain directories J and K


Every directory should have a file in it, with the letter of the directory doubled in lower case. E.g., directory A should have aa, F would have ff, etc. 

**Install and use tree**

Install tree 

    vagrant@precise64~: sudo apt-get install -y tree
    
> Note, the "-y" is critical, as this makes it possible to script apt-get

Use it to inspect your directory structure. It should look like:

````
vagrant@precise64:~$ tree

|-- A
|   |-- aa
|   |-- B
|   |   `-- bb
|   |-- C
|   |   `-- cc
|   `-- D
|       `-- dd
|-- C
|   |-- cc
|   |-- E
|   |   `-- ee
|   `-- F
|       `-- ff
|-- D
|   |-- dd
|   |-- G
|   |   `-- gg
|   |-- H
|   |   |-- hh
|   |   |-- J
|   |   |   `-- jj
|   |   `-- K
|   |       `-- kk
|   `-- I
|       `-- ii
````

Now, output the tree to a file. How? 

    vagrant@precise64:~$tree > tree.txt
    
Review the text file: 

    vagrant@precise64:~$cat tree.txt

Why did I make the directory structure so detailed? This is typical of setting up infrastructure as code - you need to be able to maintain focus and successfully set up instructions that are both complicated and yet repetitive. 

	⁃	If you have developed an approach to "mkdir" and "touch" that you wish to refer to later you should copy it to an external text file (outside of your Vagrant VM). 

Exit and destroy your VM. 

````
vagrant@precise64:~$ exit
YourStudentID@serverXXX:~/vagrant$ vagrant destroy -f
==> default: Forcing shutdown of VM...
==> default: Destroying VM and associated drives...
````

## Part 2: Working with git

You will do the exercises in part 2 on the main server, not your VM.

**Set up Github.com & fork this lab**

Go to http://github.com and set up a user account. You probably do NOT want to use your St. Thomas email address for this (it is unlikely it will be available.) 

> Notice that you will have to keep track of TWO IDs and substitute them at appropriate times:
> YourStudentID and YourGithubID

Skim https://help.github.com/articles/fork-a-repo/ (it's OK if you don't understand it all immediately - just keep following the steps here)

Go to https://github.com/StThomas-seis660/Lab-03 and fork the repo. Press the Fork button at top right:

![fork](resources/fork.jpg)

Now, go to your home account on Github and find the URL for the forked repository. 

Important: you should NOT be copying this:

    https://github.com/StThomas-seis660/Lab-03

Instead, it should look like this:

    https://github.com/YourGithubID/Lab-03

Clone the Github repository you forked as Lab-03 to your home directory /home/student/YourID/. Go into it and verify the contents look as below. Notice the username YourID; **this must be replaced with your Github user name**. 

````
YourStudentID@serverXXX:~$ git clone https://github.com/YourGithubID/Lab-03.git
Cloning into 'Lab-03'...
remote: Counting objects: 78, done.
remote: Compressing objects: 100% (60/60), done.
remote: Total 78 (delta 31), reused 58 (delta 11)
Unpacking objects: 100% (78/78), done.
Checking connectivity... done.
YourStudentID@serverXXX:~$ cd Lab-03/
YourStudentID@serverXXX:~/Lab-03$ ls
Lab-03-Instructions.md	LICENSE  README.md  resources  starter.sh  Vagrantfile
````

**Try git out**

Be sure you are in the new Lab-03 directory that git created:

    YourStudentID@serverXXX:~$ cd ~/Lab-03/

Create a file called YourStudentID-testfile, e.g. stud0001-testfile.md.

    YourStudentID@serverXXX:~/Lab-03$ nano your_student_ID-testfile.md 
    
(Again, do not put in "YourStudentID" literally. Substitute your student ID. Notice the following examples were done with "YourStudentID" as the student ID.)
    
Put some Markdown content in it, starting with  the phrase "Hello World." ([What's Markdown?](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet)).

Exit nano (ctrl-X, saving as prompted).

Add your file to your git repository

    YourStudentID@serverXXX:~/Lab-03$ git add YourStudentID-testfile.md 
    YourStudentID@serverXXX:~/Lab-03$ git commit -m "my first commit"
    
You will get:

````
[master 312919f] my first commit
 Committer: test <YourStudentID@serverXXX.gps.stthomas.edu>
Your name and email address were configured automatically based
on your username and hostname. Please check that they are accurate.
You can suppress this message by setting them explicitly:

    git config --global user.name "Your Name"
    git config --global user.email you@example.com

After doing this, you may fix the identity used for this commit with:

    git commit --amend --reset-author

 1 file changed, 2 insertions(+)
 create mode 100644 YourStudentID-testfile.md
````

Disregard the issue with your user name and email for now.

Now, edit the file again. 

    YourStudentID@serverXXX:~/Lab-03$ nano YourStudentID-testfile.md

Add "Hello Again" as a second line and exit nano in the usual way. 

You have now made a change, relative to what you committed. You can see that change through issuing the command 'git diff':

````
YourStudentID@serverXXX:~/Lab-03$ git diff
diff --git a/YourStudentID-testfile.md b/YourStudentID-testfile.md
index 9801343..fcb9459 100644
--- a/YourStudentID-testfile.md
+++ b/YourStudentID-testfile.md
@@ -1,2 +1,3 @@
 Hello World
+Hello Again

````

We will be covering git in more detail as we go, but this clearly shows that Hello Again has been added. 

Commit it again (you only need to add it once): 

````
YourStudentID@serverXXX:~/Lab-03$ git commit YourStudentID-testfile.md -m "second commit"
[master becf9ae] second commit
 Committer: test <YourStudentID@serverXXX.gps.stthomas.edu>
[ ... email error message ... ]

 1 file changed, 1 insertion(+)
````

Go back into nano and replace "World" with "Mars." Exit nano. 

Run git diff again:

````
YourStudentID@serverXXX:~/Lab-03$ git diff
diff --git a/YourStudentID-testfile.md b/YourStudentID-testfile.md
index fcb9459..dcc7a8e 100644
--- a/YourStudentID-testfile.md
+++ b/YourStudentID-testfile.md
@@ -1,3 +1,3 @@
-Hello World
+Hello Mars
 Hello Again
 
````

Commit it again:
 
````
YourStudentID@serverXXX:~/Lab-03$ git commit YourStudentID-testfile.md -m "third commit"
[master d9b8c5d] third commit
 Committer: test <YourStudentID@serverXXX.gps.stthomas.edu>
[... email error message ...]
 1 file changed, 1 insertion(+)
````

Now, let's look at our commit history:

````

YourStudentID@serverXXX:~/Lab-03$ git log -p

commit d9b8c5d55c99279f6280c4ffb439c448f0097880
Author: test <YourStudentID@serverXXX.gps.stthomas.edu>
Date:   Wed Feb 18 19:29:00 2015 -0600

    third commit

diff --git a/YourStudentID-testfile.md b/YourStudentID-testfile.md
index fcb9459..dcc7a8e 100644
--- a/YourStudentID-testfile.md
+++ b/YourStudentID-testfile.md
@@ -1,3 +1,3 @@
-Hello World
+Hello Mars
 Hello Again
 

commit becf9ae31a722d852c4680f3839f42a628d32162
Author: test <YourStudentID@serverXXX.gps.stthomas.edu>
Date:   Wed Feb 18 19:27:22 2015 -0600

    second commit

diff --git a/YourStudentID-testfile.md b/YourStudentID-testfile.md
index 9801343..fcb9459 100644
--- a/YourStudentID-testfile.md
+++ b/YourStudentID-testfile.md
@@ -1,2 +1,3 @@
 Hello World
+Hello Again
 

commit 312919f65be24cb9b3ec32f5e17082f3a5bc63e1
Author: test <YourStudentID@serverXXX.gps.stthomas.edu>
Date:   Wed Feb 18 19:23:15 2015 -0600

    my first commit

diff --git a/YourStudentID-testfile.md b/YourStudentID-testfile.md
new file mode 100644
index 0000000..9801343
--- /dev/null
+++ b/YourStudentID-testfile.md
@@ -0,0 +1,2 @@
+Hello World
+

````

Hit "q" to exit the commit review. (You can keep going back, but then you are getting into earlier commits on the cloned repository that I did while setting it up. More on that later.)

All of these changes have been locally committed to your git instance on your Vagrant virtual machine. Let's send them back up to your fork at Github. You will need to authenticate (we could set up ssh to github, but not right now):

````
YourStudentID@serverXXX:~/Lab-03$ git push origin master
Username for 'https://github.com': YourGithubID
Password for 'https://YourGithubID@github.com': 
Counting objects: 9, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (6/6), done.
Writing objects: 100% (9/9), 749 bytes | 0 bytes/s, done.
Total 9 (delta 3), reused 0 (delta 0)
To https://github.com/YourGithubID/Lab-03.git
   88af368..d9b8c5d  master -> master
````

At this point you have pushed your file up to your LOCAL fork of the Lab-03 repository on your Github account. I cannot see it unless I navigate to your Github site. 

Go back to your browser and issue a pull request:

![pull](resources/pull.jpg)

If your work is acceptable, I will allow it to be merged back into the main Lab-03 repository (actually the Spring 2015 branch).

There is much to learn about git and this lab is not intended to be a full tutorial, but rather means to an end, and a quick flavor of the techniques. We will cover further aspects as necessary. 

##Part 3: Automated provisioning and infrastructure as code

This section will bring together your VM work with git, as you develop a script to automate your activities and commit it to source control. 

**Vagrant up from the lab directory**
We will not vagrant up from your ~/vagrant directory. Instead, we will vagrant up from your ~/Lab-03 directory. A Vagrantfile has been placed there with the correct private key location. 

````
teststud@seis660:~/Lab-03$ vagrant up
Bringing machine 'default' up with 'virtualbox' provider...
==> default: Importing base box 'opscode-ubuntu-14.04a'...
==> default: Matching MAC address for NAT networking...
==> default: Setting the name of the VM: Lab-03_default_1424923870330_27416
==> default: Fixed port collision for 22 => 2222. Now on port 2201.
==> default: Clearing any previously set network interfaces...
==> default: Preparing network interfaces based on configuration...
[more]
````
You will get the following prompt. It is a bug of some sort I have not been able to figure out. 50 points for anyone who can fix it. Type "vagrant" to move past it:

````    
Text will be echoed in the clear. Please install the HighLine or Termios libraries to suppress echoed text.
vagrant@127.0.0.1's password:vagrant

[ ... a whole lot of stuff ... ]
stdin: is not a tty
==> default: Checking for guest additions in VM...
==> default: Mounting shared folders...
    default: /vagrant => /home/student/YourStudentID/Lab-03
````

**Script your work**

Go into your VM:

````
YourStudentID@serverXXX:~/Lab-03$ vagrant ssh
Welcome to Ubuntu 12.04 LTS (GNU/Linux 3.2.0-23-generic x86_64)

 * Documentation:  https://help.ubuntu.com/
New release '14.04.1 LTS' available.
Run 'do-release-upgrade' to upgrade to it.

Welcome to your Vagrant-built virtual machine.
Last login: Fri Sep 14 06:23:18 2012 from 10.0.2.2
vagrant@precise64:~$ 
````

Go to the /vagrant directory. (Not to be confused with /home/vagrant.) 

This is important. Your /vagrant directory is linked to the host machine on the outside. In fact, if you examine it, you will realize it is your ~/Lab-03 directory! You should see your *-testfile.md. 

````
vagrant@precise64:~$ cd /vagrant
vagrant@precise64:/vagrant$ ls
Lab-03-Instructions.md  LICENSE  README.md  resources  starter.sh  YourStudentID-testfile.md  Vagrantfile
````

Now for the main work of Part 3:

Starting with starter.sh, write a shell script that automates:

1. the directory creation you did manually in Part 1  
2. tree installation and use.  
3. git installation

Review your Unix commands as necessary. The install commands are: 

    apt-get install -y tree
    apt-get install -y git

  * Use Nano. Notice the shebang (#!/bin/bash) at the top of starter.sh. 

  * Name it YourStudentID-Lab03.sh

  * You will need to change (chmod) the permissions correctly to run it. 
  
So:

    vagrant@precise64:/vagrant$ cp starter.sh YourStudentID-Lab03.sh
    vagrant@precise64:/vagrant$ sudo chmod 755 YourStudentID-Lab03.sh   
        
Remember to substitute your actual ID for "YourStudentID." 

````
vagrant@vagrant:/vagrant$ sudo chmod 755 YourStudentID-Lab03.sh 
vagrant@vagrant:/vagrant$ ls -l
total 44
-rw-r--r-- 1 vagrant vagrant 14183 Feb 20 15:22 Lab-03-Instructions.md
-rw-r--r-- 1 vagrant vagrant  1084 Feb 20 15:22 LICENSE
-rw-r--r-- 1 vagrant vagrant    33 Feb 20 15:22 README.md
drwxr-xr-x 1 vagrant vagrant  4096 Feb 20 15:22 resources
-rw-r--r-- 1 vagrant vagrant   152 Feb 20 15:22 starter.sh
-rwxr-xr-x 1 vagrant vagrant   152 Feb 20 15:58 YourStudentID-Lab03.sh
-rw-r--r-- 1 vagrant vagrant    24 Feb 20 15:33 YourStudentID-testfile.md
-rw-r--r-- 1 vagrant vagrant   296 Feb 20 15:45 Vagrantfile
````

Run the script to confirm you can execute it (it's still empty, and will run fine - it just won't do anything): 

    vagrant@XXXXX:~/vagrant$ ./YourStudentID-Lab03.sh  <- notice the "./"
    
Create your script. 

    vagrant@XXXXX:~/vagrant$ nano YourStudentID-Lab03.sh  

Oops, something seems to be wrong when you run it:

````
vagrant@XXXXX:/vagrant$ ./YourStudentID-Lab03.sh 
E: Could not open lock file /var/lib/dpkg/lock - open (13: Permission denied)
E: Unable to lock the administration directory (/var/lib/dpkg/), are you root?
````

Because the script has installations in it, you need to run it as superuser:

```` 
vagrant@XXXXX:/vagrant$ sudo ./YourStudentID-Lab03.sh    
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following NEW packages will be installed:
  tree
0 upgraded, 1 newly installed, 0 to remove and 0 not upgraded.
Need to get 37.8 kB of archives.
After this operation, 109 kB of additional disk space will be used.
Get:1 http://us.archive.ubuntu.com/ubuntu/ trusty/universe tree amd64 1.6.0-1 [37.8 kB]
Fetched 37.8 kB in 5s (7,309 B/s)                      
Selecting previously unselected package tree.
(Reading database ... 57318 files and directories currently installed.)
Preparing to unpack .../tree_1.6.0-1_amd64.deb ...
Unpacking tree (1.6.0-1) ...
Processing triggers for man-db (2.6.7.1-1ubuntu1) ...
Setting up tree (1.6.0-1) ...
````

Use 

    vagrant@XXXXX:/vagrant:/vagrant$ tree

to see your results and "

    vagrant@XXXXX:/vagrant:/vagrant$ rm -rf A C D

to delete the directories if you need to run the script several times to perfect it. 

You can also:

    vagrant@XXXXX:/vagrant:/vagrant$ sudo apt-get remove git
    vagrant@XXXXX:/vagrant:/vagrant$ sudo apt-get remove tree
    
if you want to reset your environment completely.  
    
Once you are happy with your script, add and commit locally:

````
vagrant@XXXXX:/vagrant$ git add YourStudentID-Lab03.sh
vagrant@XXXXX:/vagrant$ git commit YourStudentID-Lab03.sh -m "script commit"
[master b5f0950] script commit
 Committer: vagrant <vagrant@precise64.(none)>
[email error]
 1 file changed, 10 insertions(+)
 create mode 100755 YourStudentID-Lab03.sh
````

In reviewing the directory structure, there are duplicate directories. Also, it is getting messy with three directories at the same level.  

Fix the directory creation logic so that 

1. there are not duplicate C and D directories (you will need to use another letter). 
2. all the directories are inside one called "main"

Run it & confirm it works.

````
vagrant@vagrant:/vagrant$ tree
.
├── Lab-03-Instructions.md
├── LICENSE
├── main
│   ├── A
│   │   ├── aa
│   │   ├── B
│   │   │   └── bb
│   │   ├── C
│   │   │   └── cc
│   │   └── D
│   │       └── dd
│   ├── E
│   │   ├── ee
│   │   ├── F
│   │   │   └── ff
│   │   └── G
│   │       └── gg
│   └── H
│       ├── hh
│       ├── I
│       │   └── ii
│       ├── J
│       │   ├── jj
│       │   ├── K
│       │   │   └── kk
│       │   └── L
│       │       └── ll
│       └── M
│           └── mm
[more stuff]
````

Check in and review differences

    vagrant@vagrant:/vagrant$ git commit YourStudentID-Lab03.sh -m "2nd script commit"
    vagrant@vagrant:/vagrant$ git log -p

*You are now doing "infrastructure as code."* You have automated a complex set of commands, checked them into source control, made significant changes, and checked in again. You can see both versions of your script. 

When you are satisfied, push it back into your github remote account.

````
vagrant@vagrant:/vagrant$ git push origin master
Username for 'https://github.com': YourGithubID
Password for 'https://YourGithubID@github.com': 
Counting objects: 8, done.
Compressing objects: 100% (6/6), done.
Writing objects: 100% (6/6), 886 bytes | 0 bytes/s, done.
Total 6 (delta 3), reused 0 (delta 0)
To https://github.com/YourGithubIDYourGithubID/Lab-03.git
   1c23c80..72958e4  master -> master
````
Note, your script is at risk until you do this. 

Exit and vagrant destroy your vm:

    vagrant@vagrant:/vagrant$ exit
	logout
	Connection to 127.0.0.1 closed.
	YourStudentID@serverXXX:~/Lab-03$ vagrant destroy
	
Notice that your script is still in your ~/Lab-03 directory. 

````
YourStudentID@serverXXX:~/Lab-03$ cat YourStudentID-Lab03.sh 
#!/bin/bash
# Starter shell script
# Rename as YourID-Lab03.sh
# Put commands below
# To run, type ./YourID-Lab03.sh (you need the "./")
# It must have permissions starting with a "7"  

mkdir -p main/{A/{B,C,D},E/{F,G},H/{I,J/{K,L},M}}
touch main/{A/{aa,B/bb,C/cc,D/dd},E/{ee,F/ff,G/gg},H/{hh,I/ii,J/{jj,K/kk,L/ll},M/mm}}
apt-get install tree
apt-get install git
````

**Automate provisioning with Vagrant**

You should now be on the main server (you have destroyed your VM above). 

Add and commit your Vagrantfile to source control (see above).

Edit your Vagrantfile so that it calls your *-Lab03.sh script when you provision the machine. Add the "vm.provision" line, changing MyStudentID to your ID. 

````
Vagrant.configure(2) do |config|
  config.vm.box = "precise64"
  config.ssh.private_key_path =   "~/.ssh/insecure_private_key"
  config.vm.provision             :shell, path: "./MyStudentID-Lab03.sh"
end
````

Vagrant up your machine and ssh into it, verify that your script has been run. 
 1. Directory "main" properly configured in /vagrant
 2. git installed (run git --version)
 3. tree installed 

Re-commit your Vagrantfile and push it back to origin. 

Issue a pull request for me to review your work. 

That is the end of this lab. Congratulations, this was a lot of work. Next week, we will start building a continuous integration pipeline with git, Java, JUnit, Tomcat, and Ant.


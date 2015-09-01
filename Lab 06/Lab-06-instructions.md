#Lab 06

In this lab, you will assemble into your teams and install the open source monitoring tool Nagios in a client-server configuration.

YOU WILL BE GRADED ON THIS LAB. It is due by Sunday, March 22.

## Configuring X windows

We will spend some time as a class determining whether and how X-windows is working for you all.

To use X-windows, you need to be logged into seis660 but NOT into a VM.

If you are going to use X-windows, you should log in with the following options if you are on a Mac:

    ssh -XC -c blowfish-cbc,arcfour  yourID@seis660.gps.stthomas.edu
    
If you are on a PC using Putty or MobaXterm, you will have a checkbox (that may have defaulted to checked) to enable X. You're on your own to figure out compression options. 

The extra options are so that X-windows performs better (they make a big difference!)

The quickest test for X-windows is to run the command

    xclock

If it does not work, it may be an issue with X-windows on the client. Macs should have a client already installed, as should the classroom PCs.

If you are using your own PC, you need to install MobaXTerm.

Only one person per team needs to have X-windows working for this lab.

> **Some notes on working as a group**

> It is important that you all track what is happening on the console. Take turns operating the keyboard. Each command should be discussed and everyone should be aware that a new command is being issued. It is not acceptable to have the strongest technologist in the group simply do the work. 

> Although you will be graded as a group on this assignment, questions regarding it will appear on your individual quizzes and the final. So you need to understand what is being done.

## Getting started

Four pairs of virtual machines have been created:
````
manos01, nervios01
manos02, nervios02
manos03, nervios03
manos04, nervios04
````

The machines all have the LAMP stack already installed, so you don't need to do that.

The goal is to

* install the Nagios server on your nervios instance
* install the Nagios agent on your manos instance
* configure Nagios to monitor your manos instance
* confirm that manos is being monitored
* test monitoring by halting manos and observing the result

## Steps

You have a manos and a nervios instance appropriate to your team (each team has a number 1-4)

    vagrant@192.168.33.4X    # for manosXX, X=1-4
    vagrant@192.168.33.5X    # for nerviosXX, X=1-4

First, log into the nervios instance appropriate to your team 

IMPORTANT: DO NOT USE "vagrant ssh." Instead, log in using ssh:

    ssh vagrant@192.168.33.5X 

The instructions we will follow this time are at:

http://www.unixmen.com/install-configure-nagios-4-ubuntu-14-1014-04/

At this point, you should have the command line skills to install and configure nagios based on these directions, which will not be repeated or elaborated here.

Towards the end of the directions, you will see:

*Add Monitoring targets to Nagios server*

At this point, log into manosXX 

    ssh vagrant@192.168.33.4X 

(again the instance appropriate to your team) and configure it so that it can be monitored by the nagios server.

You will then make a final configuration file change on nervios and restart nagios. If you have followed the instructions correctly, it should start monitoring your manos instance.

You can log in and see your nagios instance by opening a new ssh session into seis660 (NOT your VM!!) and typing

    firefox -X -no-remote

The URL is http://192.168.33.5X/nagios

Note that you need to change "5X" appropriately, as above.

From the main Nagios screen, click on the "Hosts" link to the right. You should see a screen with two hosts, like this:

![](nagios1.png)

Take a screen shot and save.

Test that your monitoring is working correctly by going back into your MANOS VM (192.168.33.4X) and issuing the command

    sudo halt

replacing the XX as appropriate for your team.

In 5 minutes, you should see an error on the web portal, like this:

![](nagios2.png)

Take a screen shot; combine it with your previous screen shot (e.g. in Powerpoint or as a PDF) and post to Blackboard.

If you wish, ask the instructor to restart your machine and observe the result. (Not required.)

You are now complete.

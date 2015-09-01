# IT Infrastructure Lab 5 Instructions #
**Overview**

Lab objectives:
Examine the details of an end to end DevOps pipeline and participate in it using your development environment.

In this lab, you will configure and instantiate your own VM that serves as a distributed development environment. You will change software that other students are also changing at the same time, and see how git is used to manage this.

**In the following material substitute the 2-digit number you receive from the instructor, for XX**

## X-windows setup
This is an interactive session where we will establish whether it is feasible to support X-windows for everyone. There is too much variation in your clients to publish directions.

## Clone the lab and vagrant up

First, clone the "Lab O5" branch of Calavera thus (DON'T FORGET TO CHANGE XX TO YOUR 2 DIGIT #!):

    cd
    git clone https://github.com/StThomas-SEIS660/Calavera.git -b Lab-05 --single-branch manosXX

What does this do? Git repositories can be branched; a branch is a separate line of development. The Cala-dev branch gives you a single machine Vagrantfile to modify, making things a little easier for you.

Review [branching basics](https://www.atlassian.com/git/tutorials/using-branches/) for an overview and [command alternatives](http://stackoverflow.com/questions/1778088/how-to-clone-a-single-branch-in-git) for explanation of the particular command.

cd into the new manosXX directory that was created as a result of the command you just ran

    cd manosXX

and in the Vagrantfile change the machine # and related settings from 40 to the 2-digit number you have been assigned in class.

You can do this in nano easily:

````
nano Vagrantfile
  ## file is shown
Ctrl \
Enter your search term [press return]
Enter your replacement term [press return]
A [to replace all instances]
````
Vagrant up!

    vagrant up

## Go into your VM,  clone and build hijo

ssh into your development VM:

    vagrant ssh manosXX

Set your git variables:

    vagrant@manosXX:~/hijo$ git config --global user.name "Manos XX"
    vagrant@manos40:~/hijo$ git config --global user.email manosXX@calavera.biz

Now, unlike your previous manos (Lab 04) this one is empty. There is not yet a Java application in it. Type:

    vagrant@manos40:~$ git clone ssh://cerebro/home/hijo.git

You should get:

````
Cloning into 'hijo'...
The authenticity of host 'cerebro (192.168.33.30)' can't be established.
ECDSA key fingerprint is 7c:d9:8b:ec:ac:27:b5:f8:2d:2c:ff:e0:11:1e:51:f2.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added 'cerebro,192.168.33.30' (ECDSA) to the list of known hosts.
remote: Counting objects: 22, done.
remote: Compressing objects: 100% (15/15), done.
remote: Total 22 (delta 0), reused 0 (delta 0)
Receiving objects: 100% (22/22), 7.76 KiB | 0 bytes/s, done.
Checking connectivity... done.
````
Go into your new hijo directory and build:

    vagrant@manos40:~$ cd hijo
    vagrant@manos40:~/hijo$ sudo ant

You should get

````
Buildfile: /home/vagrant/hijo/build.xml

init:
     [echo]
     [echo] 			Computer name is ${my_env.COMPUTERNAME}
     [echo]                         User name is root
     [echo] 			Building from /home/vagrant/hijo/build.xml
     [echo] 			Java is version 1.7
     [echo] 			Project is ${ant.project.name}
     [echo] 			Ant is Apache Ant(TM) version 1.9.4 compiled on April 29 2014
     [echo] 			Basedir is /home/vagrant/hijo
     [echo] 			Source is ./src/main/java/biz/calavera
     [echo] 			Build target is ./target
     [echo] 			Deployment target is /var/lib/tomcat6/webapps/ROOT/WEB-INF/lib
     [echo]

compile:
    [javac] Compiling 2 source files to /home/vagrant/hijo/target
    [javac] Compiling 1 source file to /home/vagrant/hijo/target

test:
     [echo]
     [echo] 			entering test
     [echo]
    [junit] Running biz.calavera.TestClass1
    [junit] Tests run: 1, Failures: 0, Errors: 0, Skipped: 0, Time elapsed: 0.064 sec

compress:
      [jar] Building jar: /home/vagrant/hijo/target/CalaveraMain.jar

deploy:
    [mkdir] Created dir: /var/lib/tomcat6/webapps/ROOT/WEB-INF/lib
     [copy] Copying 1 file to /var/lib/tomcat6/webapps/ROOT/WEB-INF/lib
     [copy] Copying 1 file to /var/lib/tomcat6/webapps/ROOT/WEB-INF
     [echo]
     [echo] 			Attempting Tomcat restart.
     [echo]
     [exec] The command attribute is deprecated.
     [exec] Please use the executable attribute and nested arg elements.
     [exec]  * Stopping Tomcat servlet engine tomcat6
     [exec]    ...done.
     [exec] The command attribute is deprecated.
     [exec] Please use the executable attribute and nested arg elements.
     [exec]  * Starting Tomcat servlet engine tomcat6
     [exec]    ...done.

main:
     [echo]  
     [echo] 			built and deployed to Tomcat.
     [echo]

BUILD SUCCESSFUL
Total time: 7 seconds
````
Check that your development Tomcat server is serving your page:

    vagrant@manos40:~/hijo$ curl localhost:8080/MainServlet
    <h1>This is a skeleton application-- to explore the end to end Calavera delivery framework.</h1>

## Make a change, build, test, and checkin

Up til now, this should all seem familiar as it is similar to Lab 04. However, you are now in a fully distributed development environment with many others working on the same code base.

You are going to make a change, test it out locally, commit it to git locally, and then push it to the central repository (cerebro). When you do this, it will trigger a remote build and test, and you will see on the Jenkins dashboard whether it succeeded or failed

The key principle is that you must pull very frequently, especially if you are about to change something becausee you need to be up to date with what others have put in the repository.

You need to perform the next steps in immediate order, so be sure you have some time to work uninterrupted. First, update your repository:

    git pull

This makes sure that there aren't any changes on cerebro we don't know about.

Now let's make a small change:

    nano src/main/java/biz/calavera/MainServlet.java

````
   package biz.calavera;

   //package test;

   import java.io.*;
   import javax.servlet.*;
   import javax.servlet.http.*;

   public class MainServlet extends HttpServlet {
   	// Import required java libraries

   	  private String message;
      private String manos41msg;  ## Lab 05 update

   	  public void init() throws ServletException
   	  {
   	      // Edit this message, save the file, and rebuild with Ant
                 // to see it reflected on the Web page at http://localhost:8081/MainServlet
   	      message = "This is a skeleton application-- to explore the end to end Calavera delivery framework.";
                 manos41msg = "ManosXX was here";   ## Lab 05 update
   	  }

   	  public void doGet(HttpServletRequest request,
   	                    HttpServletResponse response)
   	            throws ServletException, IOException
   	  {
   	      // Set response content type
   	      response.setContentType("text/html");

   	      // Actual logic goes here.
   	      PrintWriter out = response.getWriter();
                 Class1 oResp = new Class1(message);
   	      out.println(oResp.webMessage());

                 Class1 oM41Resp = new Class1(manos41msg);     ## Lab 05 update
                 out.println(oM41Resp.webMessage());       ## Lab 05 update
   	  }

   	  public void destroy()
   	  {
   	      // do nothing.
   	  }
   	}
````

There are FOUR places you need to make a small update. They are identified by the comment "## Lab 05 Update."  You can make up whatever you want for your manosXXmsg string as long as it is less than 30 characters.

Ok, make the updates. Now build and test:

    sudo ant
    [message as before, unless it fails]

If your build fails, go back and review and fix. Try again until it works.

When your build finally works, you should be able to curl with results like:

    <h1>This is a skeleton application-- to explore the end to end Calavera delivery framework.</h1>
    <h1>ManosXX was here</h1>

Time is of the essence. Check it in to your local repo:

    git commit -a -m "ManosXX checkin"

and push it to the master:

   git push origin master

(In a real world development, you might have committed it locally many times, but this is compressed.)

Now, when you push it to the master, one of two things will happen.

**If you are lucky**

... you will get this:

````
vagrant@manos41:~/hijo$ git push origin master
Counting objects: 15, done.
Compressing objects: 100% (6/6), done.
Writing objects: 100% (8/8), 789 bytes | 0 bytes/s, done.
Total 8 (delta 1), reused 0 (delta 0)
remote:   % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
remote:                                  Dload  Upload   Total   Spent    Left  Speed
remote: 100   100  100   100    0     0   6406      0 --:--:-- --:--:-- --:--:--  6666
remote: Scheduled polling of hijoInit
remote: No Git consumers using SCM API plugin for: git@cerebro:/home/hijo.git
To ssh://cerebro/home/hijo.git
   897638e..5fcfb04  master -> master
````

If all goes well, Jenkins has now kicked off. If you are doing the lab in class, you can see builds kicking off on the Jenkins dashboard.

![](jenkins1.png)

If you have X-windows running, you can open a window on the main seis660 server and type:

    firefox -X -no-remote

and enter the URL http://127.0.0.1:8133

If you do not have either of these options, you can query the Jenkins API and at least see if a build has just run. Type

    java -jar /mnt/public/jenkins-cli.jar -s http://127.0.0.1:8133/ console hijoInit




**If you are unlucky**
...you will get something like the following:

We will discuss this in class.


===================================================


then deploy to production (post to discussion board).


=======================

Future:

lab 6: Nagios monitoring

Lab 7: Jira & collab

Lab 8: Project/release mgmt

Lab 9: ITSM

Lab 10: ITSM?

Lab 11: Portfolio

Lab 12: Performance? Simulated outage?

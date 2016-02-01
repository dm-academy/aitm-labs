#!/bin/bash
# add users in file passed on command line

# 

for user in `cat $1`;do useradd -b "/home/student" -m -g student $user;done


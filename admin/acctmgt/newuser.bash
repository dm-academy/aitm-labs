#!/bin/bash
# add users in file passed on command line
# need to update this to set shell to bash & related
# see  http://askubuntu.com/questions/325807/arrow-keys-tab-complete-not-working

for user in `cat $1`;
    do useradd -b "/home/student" -m -g student $user &&
    chsh -s /bin/bash $user;
done

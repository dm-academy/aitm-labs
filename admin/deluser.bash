#!/bin/bash
# delete users in file passed on command line

# dangerous. deletes the users & their directories 
# enhanced to take file name as parameter

for user in `cat $1`;do userdel -r $user;done


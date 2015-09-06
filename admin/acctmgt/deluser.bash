cd#!/bin/bash
# delete users in file del.user
for user in `cat ~/courseadmin/delusers.txt`;do userdel -r $user;done


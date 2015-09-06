#!/bin/bash
# delete users in file passed on command line

# dangerous. deletes the users & their directories listed in the hardcoded file below
# enhance to take file name as parameter

for user in `cat ~/courseadmin/justUserIDs.txt`;do userdel -r $user;done


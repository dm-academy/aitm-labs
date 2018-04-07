
Scripts for user creation and deletion using perl and shell.

Perl script takes a comma-delimited list of emails. 
There is an older one to work with newline-separated emails in the archive folder.

The output files are then run through 

newuser.bash IDs.txt
chpasswd IDsPWs.txt

Use deluser.bash on the previous semester's IDs, that should be archived in ~/courseadmin

Handle with care. 

#!/usr/bin/perl
# this version only create a list of users from a list of emails (not including quoted names)
# and not the input file for newusers
# assuming final email doesn't have comma
# but does have a newline at end of file - be careful
# UNDECLARED VARIABLES very bad

#use Tie::File;
# creates a new users file from a comma delimited list of emails
# pw_name:pw_passwd:pw_uid:pw_gid:pw_gecos:pw_dir:pw_shell

#read in file
$filename = $ARGV[0]; 
open FILE, $filename||die $!;
$emails=<FILE>;
close(FILE);
chomp $emails; #remove newline from EOF
$emails .= ", ";  # add comma/space to last email - kind of lame
#remove domain, comma, space, add newlines
$emails =~ s/@.*?, ?/\n/g;  # could make this more robust
@arrEmails=split("\n", $emails);
map ($_ = lc($_), @arrEmails);

open(FILE, "> /home/char/courseadmin/justUserIDs.txt") || die "can't open output"; #for change loop and 
#also can be used for deleting users
@justUserIDs = @arrEmails;
map ($_ .= "\n", @justUserIDs); # add back newlines

print FILE @justUserIDs;
close (FILE);






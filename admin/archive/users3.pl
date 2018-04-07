#!/usr/bin/perl

# script takes comma/space delimited email file of form "first last" <email@stthomas.edu>, 
# and generates file suitable for 
#Linux newusers command.
# pw_name:pw_passwd:pw_uid:pw_gid:pw_gecos:pw_dir:pw_shell

# UNDECLARED VARIABLES very bad

#use Tie::File;
use String::Random;

#read in file
$filename = $ARGV[0]; 
open FILE, $filename||die $!;
$emails=<FILE>;
close(FILE);

$emails =~ s/>,? ?/\n/g;  # swap newlines & occasional spaces for > plus comma

$emails =~ s/".+?<//g;  # strip out names from " through left <

$emails =~ s/\@stthomas\.edu//g;  # #remove domain

# print $emails;
@arrEmails=split("\n", $emails); #lose all newlines

map ($_ = lc($_), @arrEmails);   # change all to lower case - using map as a declarative operator on the array

open(FILE, ">", glob("~/courseadmin/justUserIDs.txt")) || die "can't open justusers output"; #for change loop and 
#  can be used for deleting users
@justUserIDs = @arrEmails;
map ($_ .= "\n", @justUserIDs); # add back newlines

print FILE @justUserIDs;
close (FILE);

open(FILE, ">", glob("~/courseadmin/pwReset.txt")) || die "can't open justusers output"; #for change loop and 
#  can be used for deleting users
@justUserIDs = @arrEmails;
map ($_ .= ":t%^g7&e\n", @justUserIDs); # add back newlines

print FILE @justUserIDs;
close (FILE);


#add passwords - random 8 char
#add uids (none) -":"
#add group IDs 'student'
#add GECOS (none) ":"
#add user directory "/home/student"

my $pass = String::Random->new;
map ($_ .= ":".$pass->randpattern("CCccnccn")."::student::"."/home/student/".$_, @arrEmails);

# add user shell
map ($_ .= ":/bin/bash\n", @arrEmails);

#output to file
open(FILE, ">", glob("~/courseadmin/newusers.txt")) || die "can't open newusers output"; 
print FILE @arrEmails;
close (FILE);


#run newusers command
#system ("newusers newusers.txt")  




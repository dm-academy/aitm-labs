#!/usr/bin/perl

# script takes comma/space delimited email file and generates file suitable for 
#Linux newusers command.
# assuming final email doesn't have comma

# UNDECLARED VARIABLES very bad

#use Tie::File;
use String::Random;
# creates a new users file from a comma delimited list of emails
# pw_name:pw_passwd:pw_uid:pw_gid:pw_gecos:pw_dir:pw_shell

#read in file
$filename = $ARGV[0]; 
open FILE, $filename||die $!;
$emails=<FILE>;
close(FILE);

$emails .= ", ";  # add comma/space to last line - kind of lame
#remove domain, comma, space, add newlines
$emails =~ s/@.*?, /\n/g;  # could make this more robust
@arrEmails=split("\n", $emails);
map ($_ = lc($_), @arrEmails);

open(FILE, "> justUserIDs.txt") || die "can't open output"; #for chage loop and 
# also can be used for deleting users
@justUserIDs = @arrEmails;
map ($_ .= "\n", @justUserIDs); # add back newlines

print FILE @justUserIDs;
close (FILE);

#add passwords - random 8 char
#add uids (none) -":"
#add group IDs 'student'
#add GECOS (none) ":"
#add user directory "/home/student"
my $pass = String::Random->new;
map ($_ .= ":".$pass->randpattern("CCccnccn")."::student::"."/home/student/".$_,
 @arrEmails);

#add user shell
map ($_ .= ":/bin/bash\n", @arrEmails);

#output to file
open(FILE, "> newusers.txt") || die "can't open output"; 
print FILE @arrEmails;
close (FILE);

#print $arrEmails[0]."\n";
#print $arrEmails[1]."\n";

#run newusers command
#system ("newusers newusers.txt")  #yes, hard coded

#age the user PWs to force new PW on 1st login
#yes there may be more elegant ways to do this with default addusers config but 
#couldn't get them to work

# ForEach (@justUserIDs) {
# system ("chage ".$_);
# }





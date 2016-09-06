#!/usr/bin/perl
# creates a list of users from comma delimited list of emails (not including quoted names)
# and user:passwd reset file for chpasswd batch command
# assuming final email doesn't have comma
# but does have a newline at end of file - be careful
# UNDECLARED VARIABLES very bad


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

open(FILE, "> IDs.txt") || die "can't open IDs.txt"; #for change loop and 
#also can be used for deleting users
@justUserIDs = @arrEmails;
map ($_ .= "\n", @justUserIDs); # add back newlines
print FILE @justUserIDs;
close (FILE);

open(FILE, "> IDsPWs.txt") || die "can't open IDsPWs.txt"; 
@userIDsPWs = @arrEmails;
map ($_ .= ":zfxA1i08\n", @userIDsPWs); # add  newlines & default PW
print FILE @userIDsPWs;
close (FILE);






#!/usr/bin/perl
# creates a list of users from comma delimited list of emails (not including quoted names)
# and user:passwd reset file for chpasswd batch command
# assuming final email doesn't have comma
# but does have a newline at end of file - be careful
# UNDECLARED VARIABLES very bad
# to get starter file: murphy, email class as mac or windows, copy from mailer window

#read in file
$filename = $ARGV[0];
$tempPW = $ARGV[1]; 
$idFile = "IDs-".$filename;
$idPWFile = "IDsPWs-".$filename;
open FILE, $filename||die $!;
$emails=<FILE>;
print $emails."\n";
close(FILE);
chomp $emails; #remove newline from EOF
#$emails .= ";";  # delimit last email - kind of lame - didn't need for 2018?
#remove domain, semincolon, space, add newlines
#$emails =~ s/@.*?, ?/\n/g;  # could make this more robust
$emails =~ s/@.*?;/\n/g;  # could make this more robust

@arrEmails=split("\n", $emails);
map ($_ = lc($_), @arrEmails);

open FILE, "> ".$idFile||die "can't open".$idFile; #for change loop and 
print "\nopened ".$idFile."\n";
#also can be used for deleting users
@justUserIDs = @arrEmails;
map ($_ .= "\n", @justUserIDs); # add back newlines
print @justUserIDs;
print FILE @justUserIDs;
close (FILE);

open FILE, "> ".$idPWFile||die "can't open".$idPWFile; 
@userIDsPWs = @arrEmails;
print "opened ".$idPWFile."\n";
map ($_ .= ":".$tempPW."\n", @userIDsPWs); # add  newlines & default PW THIS NEEDS RANDOMIZATION
print @userIDsPWs;
print FILE @userIDsPWs;
close (FILE);






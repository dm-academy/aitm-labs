#!/usr/bin/perl

# comprehensive rewrite 2/2016
# input from Blackboard "Roster" tool
# scrape HTML manually into spreadsheet and extract email column - no need to send test email & bother students

# no input validation - assumption is text file with one email per line
# run script from data directory, not script directory
# data directory by convention is labeled by semester e.g. 2016-02, 2015-09
# data sets are named with datestamp

# read input file

#read in file
my $emailFile = $ARGV[0]; 
open my $EMAILS, $emailFile||die $!;

my $idsOnlyFile = "YYYY-MM-IDsOnly.txt";   # need calendar function to automate naming
open my $IDS, ">", $idsOnlyFile|| die $!;

my $pwReset = "YYYY-MM-IDsPWs.txt";   # need calendar function to automate naming
open my $PWS, ">", $pwReset|| die $!;

my $newUsersFile = "YYYY-MM-newUsers.txt";   # need calendar function to automate naming
open my $NEWUSRS, ">", $newUsersFile|| die $!;

while (my $row = <$EMAILS>) {
    #input
    chomp $row;
    $row = lc($row);   # to lowercase
    my $idOnly = $row; 
    $idOnly =~ s/\@stthomas\.edu//g;   #remove domain
    next if length($idOnly)<8;   # not a valid 8 char email
    print "$idOnly\n";
    print $IDS "$idOnly\n";  # write to IDs only
    # Note: weak 
     print $PWS "$idOnly:ZFxa1ih4\n";  # every student will reset this in class and we will only allow ssh into the server after 1st night   
    
    #add passwords - random 8 char
    #add uids (none) -":"
    #add group IDs 'student'
    #add GECOS (none) ":"
    #add user directory "/home/student"
    #add shell ":/bin/bash"

    my $newUserLine = $idOnly.":ZFxa1ih4::student::/home/student/".$idOnly.":/bin/bash";
    print "$newUserLine\n";
    print $NEWUSRS "$newUserLine\n";
    
    
}

close($EMAILS);
close($IDS);
close($PWS);
close($NEWUSRS);



# newusers is run manually for now
# newusers YYYY-MM-newUsers.txt BROKEN - bug of record in newusers v 15.04
# use newuser.bash script with IDsOnly.txt "sudo $PATH/newuser.bash $PATH/YYYY-MM-IDsOnly.txt"
# then "sudo chpasswd < YYYY-MM-IDsPWs.txt "
#
# to delete all, "sudo $PATH/deluser.bash YYYY-MM-IDsOnly.txt"

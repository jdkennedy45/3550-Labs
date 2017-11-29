#by Jacob Kennedy, finalized 11/29/2017

use strict;
use warnings;
use Modern::Perl;
use Net::SSH2; #cpan Net::SSH2
use LWP::UserAgent; #cpan LWP::UserAgent

print "Looking for apache... ";

#Initital set-up not mentioned on Moodle:
#  sudo apt-get install openssh-server THEN
#  /etc/init.d/sshd restart 

# PROGRAM ONLY WORKS LOGGING IN AS ROOT! Username: root, Password: coursework
my $chan;
my $chan2;
my $counter = 0;
my $counter2 = 0;
my $ssh2 = Net::SSH2->new();
$ssh2->connect($ARGV[0]) or die;

if ($ssh2->auth_password($ARGV[1], $ARGV[2])){
	$chan = $ssh2->channel();
	$chan->exec('aptitude -q show apache2');
	while (<$chan>){
		if ($_ =~ /State: not installed/){
			print "Apache is not installed.";
			$counter++;
		}
		elsif ($_ =~ /State: installed/){
			print "Apache is installed.";
		}
}
$chan->close(); #Need to close and re-open channel every time you call exec!
}


if ($counter eq 1){
	print "\nInstalling Apache.... ";
	$chan = $ssh2->channel();
	$chan->exec("apt-get install apache2; echo DONE");  
	while (<$chan>) {
		chomp;
		if ($_ eq "DONE") {
			print "Done";
			last; #end loops once we find the "DONE" we tagged on to the end
		}
	}
	$chan->close();
}

$chan = $ssh2->channel();
$chan->exec("ps -ef");
print "\nChecking if apache is running... ";
while (<$chan>){
		if ($_ =~ /apache2/){  #it found apache2 in the running programs list
			print "Yes.";
			$counter2++;   #increase counter if it was found. used below
			last;
		}	
}
$chan->close();
if ($counter2 eq 0)  #aka, it wasn't found in the running program list
{
	$chan = $ssh2->channel();
	print "No.";
	print "\nStarting Apache... ";             
	$chan->exec("/usr/sbin/apachectl start");    #method to start apache
	print "Done."
}
$chan->close();

print "\nGetting apache response...\n";

my $ua = LWP::UserAgent->new;
$ua->agent("MyTest ");

# Create a request
my $req = HTTP::Request->new(GET => 'http://' . $ARGV[0]);

# Pass request to the user agent and get a response back
my $res = $ua->request($req);

# Check the outcome of the response
if ($res->is_success) {
chomp;
print $res->content;
}
else {
print $res->status_line, "\n";
}

#!/usr/bin/perl -w
$counter = 0;

open DATA, "apt-get -q -y -s install " . $ARGV[0] . " |" or die "Failed!";
while ( defined( my $line = <DATA> )  ) {	
	#print $line;
	if ($line =~ /libc-/) #with a "-" to distinguish from "Libcommons"
	{
		$counter++; #increases if finds 1 string of "libc-"
	}
}
close DATA;

if ($counter eq 0) #counter is 0, so no "libc" were found to be needed
{
	print "libc not found in any dependency\n";
}
else
{
	print "Warning! libc will be installed!\n";
}

#!/usr/bin/perl -w

@array = {}; #setup array to store groups in

open DATA, "groups |" or die "Couldn't find users... :(";
while ( defined( my $line = <DATA> )  ) {
	@array = split(' ', $line); #split each group into an array element
}
close DATA;

@sortedarray = sort @array;

print "\nSorted Groups:\n";
foreach $num (@sortedarray)
{
    print $num . "\n";
}
print "\n";

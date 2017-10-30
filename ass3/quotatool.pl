use strict;
use warnings;
use Cwd;
use Win32::NetAdmin;
use XML::Simple;

my $xml_file = $ARGV[0];
my $ref = XMLin($xml_file);
my $cwd = getcwd();

my @allusers = @{ $ref->{user} };
my $count = @allusers;
#print $count;

	foreach my $user (@{$ref->{user}}) {
		system("fsutil quota modify c:\\ " . $ARGV[1] . " " . $ARGV[2] . " " . $user->{username});
	}
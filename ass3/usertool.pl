use strict;
use warnings;
use Cwd;
use XML::Simple;

my $xml_file = $ARGV[1];
my $ref = XMLin($xml_file);
my $cwd = getcwd();

my @allusers = @{ $ref->{user} };
my $count = @allusers;

#print $count;

if ($ARGV[0] eq "add")
{
	foreach my $user (@{$ref->{user}}) {
		#print "$user->{username}";
		#print "$user->{password}";
		#print "$user->{fullname}";
		system("net user " . $user->{username} . " " . $user->{password} . " /add /fullname:\"$user->{fullname}\"");
	}
}

else
{
	foreach my $user (@{$ref->{user}}) {
		system ("net user " . $user->{username} . " /delete");
	}
}
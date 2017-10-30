use strict;
use warnings;
use Cwd;
use Win32::NetAdmin;
use XML::Simple;

my $xml_file = $ARGV[1];
my $ref = XMLin($xml_file);
my $cwd = getcwd();

my @allusers = @{ $ref->{user} };
my $count = @allusers;

my $added_count = 0;
my $delete_count = 0;
#print $count;

if ($ARGV[0] eq "add")
{
	foreach my $user (@{$ref->{user}}) {
		#print "$user->{username}";
		#print "$user->{password}";
		#print "$user->{fullname}";
		if (Win32::NetAdmin::UsersExist("", $user->{username}) eq 1)
		{
			printf("User " . $user->{username} . " already exists.\n");
		}

		Win32::NetAdmin::UserCreate(
		"",
		"$user->{username}",
		"$user->{password}",
		0,
		USER_PRIV_USER,
		"C:\\Users\\$user->{username}",
		"",
		UF_SCRIPT | UF_NORMAL_ACCOUNT,
		""
		);

		if (Win32::NetAdmin::GetError() eq 0)
		{
			$added_count++;
		}

		#printf(Win32::FormatMessage(Win32::NetAdmin::GetError()));
		#assignment says to do this^, but not neccessary?
		
		
	}

	printf($added_count . " users successfully added.");
}

else
{
	foreach my $user (@{$ref->{user}}) {
		if (Win32::NetAdmin::UsersExist("", $user->{username}) ne 1)
		{
			printf("User " . $user->{username} . " doesn't exist.\n");
		}

		Win32::NetAdmin::UserDelete("", $user->{username});

		if (Win32::NetAdmin::GetError() eq 0)
		{
			$delete_count++;
		}

		#printf(Win32::FormatMessage(Win32::NetAdmin::GetError()));
		#assignment says to do this^, but not neccessary?
	}
	
	printf($delete_count . " users successfully deleted.");
}
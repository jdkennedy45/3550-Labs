use strict;
use warnings;
use Cwd;
use Modern::Perl;
use Net:SSH2;
use LWP::UserAgent;

my $ssh2 = Net::SSH2->new();

$ssh2->connect($ARGV[0]) or die $!;

if ($ssh2->auth_password($ARGV[1], $ARGV[2])) {
my $chan = $ssh2->channel();

$chan->exec('ls -l')
while (<$chan>){ print }
$chan->close();
}
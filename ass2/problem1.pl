@array = {};

$numloops = $ARGV[0];

print "For:\n";
for ($i=1; $i<= $numloops; $i++)
{
    print $i . "\n";
    $array[$i-1] = $i;
}

print "\nWhile:\n";
$counter = 1;
while ($counter <= $numloops){
    print $counter . "\n";
    $counter++;
}

print "\nForeach:\n";
foreach $num (@array)
{
    print $num . "\n";
}

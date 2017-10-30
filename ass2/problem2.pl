@array = {};

print "Please enter a name: ";
$name = <>;

@names = split(' ',$name);

print "\n";

if ($names[1] eq "Smith" || $names[1] eq "Jones")
{
print $names[1]. ", " . $names[0] . " is a common name\n";
}
else 
{
    print $names[1]. ", " . $names[0] . " is not a common name\n";
}


$address = $ARGV[0];
#print "\nAddress is: $address";
@sections = split(/\./, $address);

$count = 0;
foreach $section (@sections){
    int ($section);
    if ($section < 0 || $section > 255) {
        print "\nNo, " . $address . " is not in dotted decimal notation.\n";
        exit
    }
    $count++;
    #print $section . "\n";
}
if ($count ne 4){
    print "\nNo, " . $address . " is not in dotted decimal notation.\n"
}
else{
    print "\nYes, " . $address . " is in dotted decimal notation.\n"
}

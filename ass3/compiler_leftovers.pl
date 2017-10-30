use strict;
use warnings;
use Cwd;
use File::Find::Rule;
use Term::ANSIColor;

my $cwd = getcwd();

find(\&search_stuff, '$ARGV[0]');


sub search_stuff {
	my @subdirs = File::Find::Rule->directory->in($ARGV[0]);
	my $extensions = File::Find::Rule->file
			->name('*.exe', '*.obj', '*.o');
	my @files = File::Find::Rule->or($extensions)
				    ->in($ARGV[0]);
	#print "$_\n" for @files;

	my @stat;
	my $file_name;
	my $byte_count;
	foreach $file_name (@files)
	{
		@stat = stat $file_name;
		$byte_count += $stat[7];
		#print $stat[7];
		#print "\n";
	}
	print color('reset');
	print "\nThe total bytes in .o, .obj, and .exe files is ";
	print color('bold yellow');
	printf("%.3f", $byte_count/1000);
	print " KB";
	
	print color('bold yellow');
	print "\n\nThe directories where files were found are as follows:\n";
	print color('reset');
	print "$_\n" for @subdirs;
	print "\n";
}



#! /usr/bin/perl
# Based on the function definition and intial comments this
# script generates a markdown formated set of docs for all
# matlab (.m) files in the PWD.

## Delete old version if one is present.
if (-e "SUMMARY.txt"){ `rm SUMMARY.txt`; }

@files = split(/\n/,`ls`);
for $file (@files){
	## Find the function and the intial comments
	next if($file =~ !/.m$/);
		# only process matlab (.m) files
	{
		local $/ = undef; local *FILE; open FILE, "<$file";
		$text = <FILE>; close FILE; 
	}

	@lines = split(/\n/,$text);
	$func = shift(@lines);
	for(@lines){
		chomp(); 
		break if(!/^+%/);
			# Break the first time a non-comment line is encountered.
		push(@comments);
	}

	## Write what was found into a markdown formated .txt file
	open FILE, ">>SUMMARY.txt" or die "Could not open SUMMARY.txt\n";
	print FILE "# $func\n";
	for(@comments){
		# TODO strip comments from in front
		$reform = ;
		print FILE " - $reform\n";
	}
	print FILE "\n";
	close FILE;
}

## TODO Try and run markdown.pl (if is in the PATH.


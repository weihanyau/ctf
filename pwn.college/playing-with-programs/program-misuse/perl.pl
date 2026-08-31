open(my $fh, '<', '/flag') or die $!;
print <$fh>; 
close($fh);

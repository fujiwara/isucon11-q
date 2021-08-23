#!perl

use strict;
use DBI;
my $dbh = DBI->connect("dbi:mysql:dbname=isucondition", "isucon", "isucon");
my $sth = $dbh->prepare("SELECT jia_isu_uuid, image FROM isu");
$sth->execute();
while (my $r = $sth->fetchrow_arrayref) {
    my $dir = $r->[0];
    mkdir $dir;
    open(my $fh, ">", "$dir/icon") or die $!;
    print $fh $r->[1];
    close $fh;
}



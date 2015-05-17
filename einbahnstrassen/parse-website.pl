#!/usr/bin/perl -w

@files=("frei","einbahn");
foreach my $file (@files) {
open(FILE,"$file.html");
open(OUT,">$file.csv");
$c=join("",<FILE>);
close(FILE);
$c=~s/\n//g;
$c=~s/.*<tbody>(.*)<\/tbody>.*/$1/;
    my $ende=0;
foreach my $line (split(/<\/tr>/,$c)) {

    $line=~s/<tr height="\d*">//g;
    $line=~s/<td class="xl\d*" height="\d*" width="\d*">//g;
    $line=~s/<p class="bodytext">//g;
    $line=~s/<td class="xl\d*" height="\d*">//g;
    $line=~s/<\/p>//g;
    $line=~s/<td class="xl\d*">//g;
    $line=~s/<td class="xl\d*" width="\d*">//g;
    $line=~s/\&nbsp;/ /g;
    $line=~s/<span>/ /g;
    $line=~s/<\/span>/ /g;
    @a=split(/<\/td>/,$line);
    my $zusatz="";
    foreach my $e (@a) {
        if ($e=~/\*/) {
            $zusatz=$e;
            $zusatz=~s/.*\*/*/;
            $e=~s/\*.*//;
        }
        $e=~s/^\s*(.*)\s*$/$1/;
    }
    if ($a[0] eq "") {
        $ende=1;
    }
    if ($ende==0) {
        print OUT join("\t",@a)."\n";
    }
}
close(FILE);
close(OUT);
}
#print $c;

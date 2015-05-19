#!/usr/bin/perl -w
use utf8;
use JSON qw( from_json );
use Data::Dumper;
#use open ':encoding(utf8)';
open(JSON,"strassenliste.json");
my $json =from_json(join("",<JSON>), { utf8  => 0 });
close(JSON);
my %str;
foreach my $ele (@{$json->{'elements'}}) {

#    print $ele->{'tags'}->{'name'},"\n";
    my $name=$ele->{'tags'}->{'name'};
    if(utf8::is_utf8($name)) {
       # print $name;
        utf8::decode($name);
        #print $name;
    }
    my $lname=lc($name);
    $lname=~s/[^a-z]//g;
#    print "@ $lname\n";
    my $oneway=$ele->{'tags'}->{'oneway'};
    if (!defined($oneway)) {
        $oneway="no";
    }
    my $element= {
        name=>$name,
        id=>$ele->{'id'},
        highway=>$ele->{'tags'}->{'highway'},
        oneway=>$oneway,
        lat=>$ele->{'center'}->{'lat'},
        lon=>$ele->{'center'}->{'lon'},
        };
    if (defined($str{$lname})) {
        push @{$str{$lname}},$element;
    } else {
        $str{$lname}=[$element];
    }
 #   if ($lname=~/wex/) {
 #       print Dumper($element);
 #   }
#    print "$name\t$id\t$highway\t$oneway\t$lat\t$lon\n";
}
#print Dumper($str{"wexstraße"});
open(EINBAHN,"einbahn.csv");
open(OUT,">data/einbahn-pruef.csv");
open(MAP,">data/einbahn-map.csv");
print OUT "name\tzusatz\tpolizei\tstatus\t\tlat\tlon\n";
print MAP "name\tzusatz\tpolizei\tstatus\t\tlat\tlon\n";
foreach my $line (<EINBAHN>) {
    my ($name,$pk)=split(/\t/,$line);
    $name=~s/^\s*//;
    $name=~s/\s*$//;
    if(utf8::is_utf8($name)) {
        utf8::encode($name);
    }
    my $lname=lc($name);
    $lname=~s/[^a-z]//g;
    if (defined($str{$lname})) {
        $lat=$str{$lname}[0]{'lat'};
        $lon=$str{$lname}[0]{'lon'};
        print OUT "$name\t\t$pk\tokay\t\t$lat\t$lon\n";
        print MAP "$name\t\t$pk\tokay\t\t$lat\t$lon\n";
    } else {
        print OUT "$name\t\t$pk\tpruefen\t\t\t\n";
    }
}
close(EINBAHN);
close(OUT);
close(MAP);
open(EINBAHN,"frei.csv");
open(OUT,">data/frei-pruef.csv");
open(MAP,">data/frei-map.csv");
print OUT "name\tzustatz\tpolizei\tfreigegeben\tstatus\t\tlat\tlon\n";
print MAP "name\tzustatz\tpolizei\tfreigegeben\tstatus\t\tlat\tlon\n";
foreach my $line (<EINBAHN>) {
    my ($name,$pk,$frei)=split(/\t/,$line);
    $name=~s/^\s*//;
    $name=~s/\s*$//;
    if(utf8::is_utf8($name)) {
        utf8::encode($name);
    }
    my $lname=lc($name);
    $lname=~s/[^a-z]//g;
    if (defined($str{$lname})) {
        $lat=$str{$lname}[0]{'lat'};
        $lon=$str{$lname}[0]{'lon'};
        print OUT "$name\t\t$pk\t$frei\tokay\t\t$lat\t$lon\n";
        print MAP "$name\t\t$pk\t$frei\tokay\t\t$lat\t$lon\n";
    } else {
        print OUT "$name\t\t$pk\t$frei\tpruefen\t\t\t\n";
    }
}
close(EINBAHN);
close(OUT);
close(MAP);
#print Dumper($str{'de lange tammer'});

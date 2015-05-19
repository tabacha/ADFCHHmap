use utf8;
use JSON qw( from_json );
use Data::Dumper;
#use open ':encoding(utf8)';
open(JSON,"freigegeben_in_osm.json");
my $json =from_json(join("",<JSON>), { utf8  => 0 });
close(JSON);
open(MAP,"data/frei-map.csv");
my $skip=<MAP>;
my %found;
foreach my $line (<MAP>) {
    my @a=split(/\t/,$line);
  my $lname=lc($a[0]);
    $lname=~s/[^a-z]//g;

#    print    $a[0]
        $found{$lname}=$line;
}
close(MAP);
open(OUT,">data/freigegeben_in_osm.csv");
open(NUROSM,">data/nur_in_osm_frei.csv");
open(NURADFC,">data/nur_in_adfc_frei.csv");
print OUT "name\tid\tlat\tlon\n";
print NUROSM "name\tid\tlat\tlon\n";
print NURADFC "name\tid\tlat\tlon\n";
my %str;
foreach my $ele (@{$json->{'elements'}}) {

       my $name=$ele->{'tags'}->{'name'};
       my $id=$ele->{'id'};
#       print Dumper($ele->{'center'}->{'lat'});
       my $lat=$ele->{'center'}->{'lat'};
       my $lon=$ele->{'center'}->{'lon'};
       print OUT "$name\t$id\t$lat\t$lon\n";
       my $lname=lc($name);
       $lname=~s/[^a-z]//g;
       if (defined($found{$lname})) {
           # in OSM und ADFC
           $found{$lname}="";
       } else {
           print NUROSM "$name\t$id\t$lat\t$lon\n";
       }
};
foreach my $key (keys %found) {
    if ($found{$key} ne "") {
        print NURADFC $found{$key};
    }
}
close(NUROSM);
close(NURADFC);
close(OUT);

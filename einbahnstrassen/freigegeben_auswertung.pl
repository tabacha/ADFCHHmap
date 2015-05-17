#!/usr/bin/perl -w 
use JSON qw( from_json );
use Data::Dumper;
open(CSV,"frei_bereinigt_20150517.csv");
@csv=<CSV>;
close(CSV);
open(JSON,"freigegeben_in_osm.json");
my $json =from_json(join("",<JSON>), { utf8  => 0 });
close(JSON);
#Dumper($json);
my %osmstr;
my %allstr;
foreach my $ele (@{$json->{'elements'}}) {
#    print Dumper($ele);
    $osmstr{$ele->{'tags'}->{'name'}}=$ele;
    $allstr{$ele->{'tags'}->{'name'}}="osm";
}
my %csvstr;
foreach my $line (@csv) {
#
   @a=split(/\t/,$line);
    $allstr{$a[0]}="csv";
   $csvstr{$a[0]}=$a[1];
}
my $inboth="";
my $inosm="";
my $inadfc="";
my $alllist="";
my $innureinem="";
foreach my $str (sort(keys %allstr)) {
    $alllist.=$str;
    if (defined($osmstr{$str})) {
        $alllist.=" (osm)";
    }
    if (defined($csvstr{$str})) {
        $alllist.=" (adfc)";
    }
    $alllist.="\n";

    if ((defined($osmstr{$str})) && (defined($csvstr{$str}))) {
        $inboth.="$str\n";
    } else {
        if (defined($osmstr{$str})) {
            $inosm.="$str\n";
            $innureinem.="$str (osm)\n";
        } else {
            $inadfc.="$str\n";
            $innureinem.="$str (adfc)\n";
        }
    }
}

print "== alle Staßen ==\n".$alllist;
print "\n\n== in nur einem ==\n".$innureinem;
print "\n\n== in OSM + ADFC ==\n".$inboth;
print "\n\n== nur in OpenStreetMap ==\n".$inosm;
print "\n\n== nur in ADFC ==\n".$inadfc;

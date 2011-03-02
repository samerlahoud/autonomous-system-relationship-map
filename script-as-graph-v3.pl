#!/usr/bin/perl
# -*- coding: utf-8 -*-
use GraphViz;

# using the peer cones from http://as-rank.caida.org/
open(peer_file, "<./data/as-rank.caida.peercones-with-IX.txt");
open(asn_file, "<./data/as-name-nb-120211.txt");
open(out_file, ">./output/as-peer-graph-$ARGV[0].dot");
open(asinfo_file, "<./data/as-rank.caida.as-dump-info.txt");

my $g = GraphViz->new();
my @as_list =();

sub as_to_n {
	my ($line, @split_line);
	$as_number = $_[0];
	seek asn_file, 0, 0;
	while ($line = <asn_file>) {
		if ($line =~ m/^#/i){
			next;
		}
		@split_line = split(/ +/, $line);
		if ("AS$as_number" eq $split_line[0]){
			return $split_line[1];
			last;
		}
	}
}

while ($line = <asinfo_file>) {
    if ($line !~ m/^#/i){
        @split_line = split(/\|/, $line);

        if ($split_line[3] eq $ARGV[0]){
            push(@as_list, $split_line[0]);
        }
    }
}
# foreach(@as_list){
#     print "AS: $_\n";
# }

my %as_hash = ();
while ($line = <asn_file>) {
    if ($line !~ m/^#/i){
        @split_line = split(/ +/, $line);
        foreach $as_iterator (@as_list){
             if ("AS$as_iterator" eq $split_line[0]){
             	#print "$as_iterator, $split_line[0]";
 				$as_hash{$as_iterator} = $split_line[1];
             }
        }
    }
}
#print %as_hash;
# while (($key, $value) = each(%as_hash)){
#      print "$key is named $value\n";
# }

while ($line = <peer_file>) {
     if ($line =~ m/^#/i){
     	next;
     }
	 @split_line = split(/\|/, $line);
	 $as_relation = $split_line[2];
	 if (!(exists $as_hash{$split_line[0]} || exists $as_hash{$split_line[1]})){
	 	next;
	 }
	 
	for ($i = 0; $i < 2; ++$i){
		if (exists $as_hash{$split_line[$i]}){
			$g->add_node($split_line[$i], label=>"$as_hash{$split_line[$i]}", shape => 'box', style => 'filled', color => 'green', URL => "http://bgp.he.net/AS$split_line[$i]");
		} else {
			$as_name = &as_to_n($split_line[$i]);
			$g->add_node($split_line[$i], label=>"$as_name", shape => 'ellipse', style => 'filled', color => 'red', URL => "http://bgp.he.net/AS$split_line[$i]");
		}
	}
	if ($as_relation == -1){
		$g->add_edge($split_line[0] => $split_line[1]);
	} 
}
print out_file $g->as_text;

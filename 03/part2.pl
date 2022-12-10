#!/usr/bin/env perl

use strict;
use warnings;

use experimental qw(signatures);
use feature qw(state);

my $priority;

while (my $line = <<>>) {
  state @group;

  chomp($line);

  push @group, $line;

  if (@group == 3) {
    my %all;

    for my $c (split(//, $group[0])) {
      $all{$c} = 1;
    }

    my %done;

    for my $c (split(//, $group[1])) {
      next if $done{$c}++;

      $all{$c} && $all{$c}++;
    }

    %done = ();
    for my $c (split(//, $group[2])) {
      next if $done{$c}++;

      $all{$c} && $all{$c}++;
    }

    my @dup = grep { $all{$_} == 3 } keys %all;
    for my $c (@dup) {
      print "HEY: $c\n";
      $priority += $c =~ /[a-z]/ ? ord($c) - 96 : ord($c) - 38;
    }

    @group = ();
  }
}

print "priority: $priority\n";

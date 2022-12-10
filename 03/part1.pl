#!/usr/bin/env perl

use strict;
use warnings;

use experimental qw(signatures);
use feature qw(state);

my $priority;

while (my $line = <<>>) {
  chomp($line);
  my $len = length($line);
  my $half = $len / 2;
  unless (int($half) == $half) {
    die "Weirdly lenghted line: $line\n";
  }

  my ($c1, $c2) = $line =~ /^(.{$half})(.*)$/;
  warn "C1: $c1, C2: $c2\n";

  my %all;

  for my $c (split(//, $c1)) {
    $all{$c} = 1;
  }

  for my $c (split(//, $c2)) {
    $all{$c} && $all{$c}++;
  }

  my @dup = grep { $all{$_} > 1 } keys %all;
  for my $c (@dup) {
    $priority += $c =~ /[a-z]/ ? ord($c) - 96 : ord($c) - 38;
  }
}

print "priority: $priority\n";

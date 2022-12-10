#!/usr/bin/env perl

use strict;
use warnings;

use experimental qw(signatures);
use feature qw(state);

my $overlaps = 0;

while (my $line = <<>>) {
  my ($e1, $e2) = split(',', $line);

  my ($min1, $max1) = split('-', $e1);
  my ($min2, $max2) = split('-', $e2);

  if ($min1 >= $min2 && $min1 <= $max2) {
    $overlaps++;
  } elsif ($max1 >= $min2 && $max1 <= $max2) {
    $overlaps++;
  } elsif ($min2 >= $min1 && $min2 <= $max1) {
    $overlaps++;
  } elsif ($max2 >= $min1 && $max2 <= $max1) {
    $overlaps++;
  }
}

print "Overlaps: $overlaps\n";

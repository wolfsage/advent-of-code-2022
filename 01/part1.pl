#!/usr/bin/env perl

use strict;
use warnings;

use experimental qw(signatures);
use feature qw(state);

my %elves;
my %most;

while (my $line = <<>>) {
  state $accum = 0;
  state $elf = 1;

  if ($line =~ /^(\d+)$/) {
    $accum += $1;
  } elsif ($line =~ /^\s*$/) {
    $elves{$elf} = $accum;

    if ($accum > ($most{calories} // 0)) {
      $most{calories} = $accum;
      $most{elf} = $elf;
    }

    $accum = 0;

    $elf++;
  } else {
    die "Unknown line: $line\n";
  }
}

print "Most $most{elf} with $most{calories} calories\n";

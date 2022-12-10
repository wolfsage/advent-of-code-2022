#!/usr/bin/env perl

use strict;
use warnings;

use experimental qw(signatures);
use feature qw(state say);

my %elves;

while (my $line = <<>>) {
  state $accum = 0;
  state $elf = 1;

  if ($line =~ /^(\d+)$/) {
    $accum += $1;
  } elsif ($line =~ /^\s*$/) {
    $elves{$elf++} = $accum;

    $accum = 0;
  } else {
    die "Unknown line: $line\n";
  }
}

my ($first, $second, $third) = reverse sort {
  $elves{$a} <=> $elves{$b}
} keys %elves;

say "1: $first, $elves{$first}";
say "2: $second, $elves{$second}";
say "3: $third, $elves{$third}";

say "total: " . ($elves{$first} + $elves{$second} + $elves{$third});


#!/usr/bin/env perl

use strict;
use warnings;

use experimental qw(signatures);
use feature qw(state);

# A = Rock, B = Paper, C = Scissors
# X = Rock, Y = Paper, Z = Scissors
# Score: X = 1, Y = 2, Z = 3
# Lose = 0, Draw = 3, Win = 6

my %equiv_key = (
  X => 'A',
  Y => 'B',
  Z => 'C',
);

my %outcome_key = (
  X => {
    B => 'lose',
    C => 'win',
  },
  Y => {
    A => 'win',
    C => 'lose',
  },
  Z => {
    A => 'lose',
    B => 'win',
  },
);

my %score_key = (
  X => 1,
  Y => 2,
  Z => 3,
  lose => 0,
  draw => 3,
  win => 6,
);

my $score;

while (my $line = <<>>) {
  my ($them, $me) = $line =~ /^(\S+)\s+(\S+)$/;
  unless ($them && $me) {
    die "Unknown line: $line\n";
  }

  my $outcome = $equiv_key{$me} eq $them ? 'draw' : $outcome_key{$me}{$them};
  unless ($outcome) {
    die "Unknown pairing: $me vs $them\n";
  }

  $score += $score_key{$me} + $score_key{$outcome};
}

print "Score: $score\n";

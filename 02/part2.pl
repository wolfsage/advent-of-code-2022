#!/usr/bin/env perl

use strict;
use warnings;

use experimental qw(signatures);
use feature qw(state);

# A = Rock, B = Paper, C = Scissors
# X = Rock, Y = Paper, C = Scissors
# AND ALSO
# X = lose, Y = draw, Z = win (from the input)
# Score: X = 1, Y = 2, Z = 3
# Lose = 0, Draw = 3, Win = 6

my %equiv_key = (
  A => 'X',
  B => 'Y',
  C => 'Z',
);

my %how_to_respond_key = (
  A => {
    X => 'Z',
    Z => 'Y',
  },
  B => {
    X => 'X',
    Z => 'Z',
  },
  C => {
    X => 'Y',
    Z => 'X',
  },
);

my %outcome_key = (
  X => 'lose',
  Y => 'draw',
  Z => 'win',
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
  # Goal is should we win lose or tie
  my ($them, $goal) = $line =~ /^(\S+)\s+(\S+)$/;
  unless ($them && $goal) {
    die "Unknown line: $line\n";
  }

  my $outcome = $outcome_key{$goal};
  my $how_to_respond = $outcome eq 'draw' ? $equiv_key{$them}
                                          : $how_to_respond_key{$them}{$goal};

  $score += $score_key{$how_to_respond} + $score_key{$outcome};
}

print "Score: $score\n";

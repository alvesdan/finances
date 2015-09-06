package Finances::Command;

use strict;
use warnings;

our %handlers = (
  wallets => 'Finances::Wallets',
  categories => 'Finances::Categories',
  expenses => 'Finances::Expenses'
);

sub read {
  shift;
  my $schema = shift @_;
  my @arguments = @{shift @_};
  my $command = shift @arguments;

  unless ($command) {
    print "Yes, how can I help?\n";
    return;
  }

  my $key = grep { $_ eq $command } keys %handlers;
  if ($key) {
    my $handler = $handlers{$command};
    $handler->call($schema, \@arguments);
  } else {
    print "Sorry, I don't understand this command.\n";
  }
}

1;

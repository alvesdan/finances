package Finances::Wallets;
use Finances::Callable qw/add_commands schema/;
use base 'Finances::Callable';
use strict;
use warnings;

add_commands(__PACKAGE__, 'list', 'add');

sub list {
  my $self = shift;
  my @wallets = schema()->resultset('Wallet')->all;
  Finances::Presenter->list(\@wallets, 'name');
}

sub add {
  my $self = shift;
  my @arguments = @{shift @_};
  my ($wallet_name, $wallet_description) = @arguments;

  unless ($wallet_name) {
    print "Name is required.\n";
    return;
  }

  my $insert = schema()->resultset('Wallet')->create({
    name => $wallet_name,
    description => $wallet_description
  });

  print $insert->name, "\n";
}

1;

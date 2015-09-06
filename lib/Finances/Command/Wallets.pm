package Finances::Command::Wallets;
use Finances::Command::Callable qw/add_commands schema/;
use Finances::Utils;
use base 'Finances::Command::Callable';
use strict;
use warnings;

add_commands(__PACKAGE__, 'list', 'add', 'remove');

sub list {
  my $self = shift;
  my @wallets = schema()->resultset('Wallet')->all;

  if (@wallets) {
    Finances::Presenter->list(\@wallets, 'name',
      'description');
  } else {
    p "No wallets found.";
  }
}

sub add {
  my $self = shift;
  my @arguments = @{shift @_};
  my ($wallet_name, $wallet_description) = @arguments;

  require_or_exit(
    $wallet_name, "Name is required.");

  my $insert = schema()->resultset('Wallet')->create({
    name => $wallet_name,
    description => $wallet_description
  });

  p $insert->name;
}

sub remove {
  my $self = shift;
  my @arguments = @{shift @_};
  my ($wallet_name) = @arguments;

  require_or_exit(
    $wallet_name, "Name is required.");

  my $remove = schema()->resultset('Wallet')->find({
    name => $wallet_name
  });

  if ($remove) {
    $remove->delete;
    p "Removed $wallet_name.";
  } else {
    p "Could not find $wallet_name.";
  }
}

1;

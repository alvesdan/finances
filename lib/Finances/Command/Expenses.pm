package Finances::Command::Expenses;
use Finances::Command::Callable qw/add_commands schema/;
use Finances::Utils;
use base 'Finances::Command::Callable';
use strict;
use warnings;

add_commands(__PACKAGE__, 'list', 'add');

sub find_wallet {
  my $wallet_name = shift;

  schema()->resultset('Wallet')->find({
    name => $wallet_name
  });
}

sub find_category {
  my $category_name = shift;

  schema()->resultset('Category')->find({
    name => $category_name
  });
}

sub list {
  my $self = shift;
  my $wallet_name = shift;
  my $wallet = find_wallet($wallet_name);

  if ($wallet) {
    my @expenses = $wallet->expenses;
    Finances::Presenter->list(
      \@expenses, 'amount', 'description',
      'wallet_name', 'category_name');
  } else {
    p "Wallet not found.";
  }
}

sub add {
  my $self = shift;
  my @arguments = @{shift @_};
  my $wallet_name = shift @arguments;
  my $category_name = shift @arguments;
  my $amount = shift @arguments;
  my $description = shift @arguments;
  my $wallet = find_wallet($wallet_name);
  my $category = find_category($category_name);

  if ($wallet and $category) {
    my $insert = schema()->resultset('Expense')->create({
      wallet_id => $wallet->id,
      category_id => $category->id,
      amount => $amount,
      description => $description
    });
  } else {
    p "Please provide a valid wallet and category.";
  }
}

1;


package Finances::Categories;
use Finances::Callable qw/add_commands schema/;
use Finances::Utils;
use base 'Finances::Callable';
use strict;
use warnings;

add_commands(__PACKAGE__, 'list', 'add');

sub list {
  my $self = shift;
  my @categories = schema()->resultset('Category')->all;
  Finances::Presenter->list(\@categories, 'name');
}

sub add {
  my $self = shift;
  my @arguments = @{shift @_};
  my ($category_name, $category_description) = @arguments;

  require_or_exit(
    $category_name, "Name is required.");

  my $insert = schema()->resultset('Category')->create({
    name => $category_name,
    description => $category_description
  });

  p $insert->name;
}

1;

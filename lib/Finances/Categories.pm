package Finances::Categories;
use Finances::Callable qw/add_commands schema/;
use base 'Finances::Callable';
use strict;
use warnings;

add_commands(__PACKAGE__, 'list');

sub list {
  my $self = shift;
  my @categories = $self->schema()->resultset('Category')->all;
  Finances::Presenter->list(\@categories, 'name');
}

1;

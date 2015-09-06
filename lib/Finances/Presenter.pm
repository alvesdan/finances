package Finances::Presenter;

use strict;
use warnings;

sub list {
  shift;
  my $object_ref = shift;
  my $method = shift;

  my @list = @$object_ref;
  foreach my $item_ref (@list) {
    print $item_ref->id, " ";
    print $item_ref->$method, "\n";
  }
}

1;

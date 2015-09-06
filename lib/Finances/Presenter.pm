package Finances::Presenter;

use strict;
use warnings;

sub list {
  shift;
  my $object_ref = shift;
  my @methods = @_;

  my @list = @$object_ref;
  foreach my $item_ref (@list) {
    my @info = ();
    push @info, $item_ref->id;
    foreach my $method (@methods) {
      push @info, $item_ref->$method;
    }

    my @filtered = grep { $_ } @info;
    print join(', ', @filtered), "\n";
  }
}

1;

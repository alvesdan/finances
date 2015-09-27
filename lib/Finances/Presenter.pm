package Finances::Presenter;

use strict;
use warnings;

sub show {
    shift;
    my $object_ref = shift;
    my @attributes = @_;
    my @info = ();
    foreach my $attribute (@attributes) {
        push @info, $object_ref->$attribute;
    }

    my @filtered = grep { $_ } @info;
    print join(', ', @filtered), "\n";
}

sub list {
    shift;
    my $object_ref = shift;
    my @methods = @_;

    my @list = @$object_ref;
    foreach my $item_ref (@list) {
        __PACKAGE__->show($item_ref, @methods);
    }
}

1;

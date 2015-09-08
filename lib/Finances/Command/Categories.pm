package Finances::Command::Categories;
use Finances::Command::Callable qw/add_commands schema/;
use Finances::Utils;
use base 'Finances::Command::Callable';
use strict;
use warnings;

add_commands(__PACKAGE__, 'list', 'add', 'remove');

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

sub remove {
    my $self = shift;
    my @arguments = @{shift @_};
    my ($category_name) = @arguments;

    require_or_exit(
        $category_name, "Name is required.");

    my $category = schema()->resultset('Category')->find({
            name => $category_name
        });

    if ($category) {
        if ($category->expenses->count) {
            p "Can't delete a category with expenses.";
            return;
        }

        $category->delete;
        p "Removed $category_name.";
    } else {
        p "Could not find $category_name.";
    }
}

1;

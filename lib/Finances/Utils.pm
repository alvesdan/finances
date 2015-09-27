package Finances::Utils;
use strict;
use warnings;

use Exporter 'import';
our @EXPORT = qw/require_or_exit p read_user_input/;
our @EXPORT_OK = qw/require_or_exit p read_user_input/;

sub require_or_exit {
    my $required = shift;
    my $message = shift;

    return if $required;
    print $message, "\n";
    exit;
}

sub p {
    my $message = shift;
    print $message, "\n";
}

sub read_user_input {
    my $record = shift;
    my @columns = @{shift @_};
    my %edited = ();
    p "To erase the column content use '-' as value.", "\n";

    foreach my $column (@columns) {
        my $value = $record->$column || "";
        print "$column ($value): ";
        my $user_input = <STDIN>;
        chomp($user_input);
        $value = $user_input if $user_input;
        $value = "" if $user_input eq "-";
        $edited{$column} = $value;
    }

    %edited;
}

1;

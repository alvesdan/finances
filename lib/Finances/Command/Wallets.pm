package Finances::Command::Wallets;
use Finances::Command::Callable qw/add_commands schema/;
use Finances::Utils;
use base 'Finances::Command::Callable';
use strict;
use warnings;

add_commands(__PACKAGE__, 'list', 'add', 'edit', 'remove');

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
sub edit {
    my $self = shift;
    my @arguments = @{shift @_};
    my ($wallet_name) = @arguments;
    my $wallet = schema()->resultset('Wallet')->find({
        name => $wallet_name
    });

    require_or_exit($wallet, "Wallet not found.");
    my @editable_columns = ('name', 'description');
    my %edited_columns = read_user_input($wallet, \@editable_columns);

    $wallet->update(\%edited_columns);
    Finances::Presenter->show($wallet, 'name', 'description');
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

package Finances::Command::Expenses;
use Finances::Command::Callable qw/add_commands schema/;
use Finances::Utils;
use base 'Finances::Command::Callable';
use strict;
use warnings;

add_commands(__PACKAGE__, 'list', 'add', 'edit', 'remove');

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
            \@expenses, 'id', 'amount', 'description',
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
        require_or_exit(
            $amount, "Amount is required.");

        my $expense = schema()->resultset('Expense')->create({
            wallet_id => $wallet->id,
            category_id => $category->id,
            amount => $amount,
            description => $description
        });

        Finances::Presenter->show(
            $expense, 'id', 'amount', 'description',
            'wallet_name', 'category_name');
    } else {
        p "Please provide a valid wallet and category.";
    }
}

sub edit {
    my $self = shift;
    my @arguments = @{shift @_};
    my ($id) = @arguments;
    my $expense = schema()->resultset('Expense')->find($id);

    require_or_exit($expense, "Expense not found.");
    my %edited_columns = read_user_input(
        $expense, 'amount', 'description');

    $expense->update(\%edited_columns);
    Finances::Presenter->show(
        $expense, 'amount', 'description',
        'wallet_name', 'category_name');
}

sub remove {
    my $self = shift;
    my @arguments = @{shift @_};
    my $id = shift @arguments;

    require_or_exit(
        $id, "ID is required.");

    my $expense = schema()->resultset('Expense')->find($id);

    if ($expense) {
        my $expense_amount = $expense->amount;
        $expense->delete;
        p "Removed expense $id, $expense_amount.";
    } else {
        p "Could not find $id.";
    }
}

1;


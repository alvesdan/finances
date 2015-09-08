package Finances;
use Finances::Schema;
use Finances::Command;

use warnings;
use strict;

our $schema;

sub s {
    return $schema if $schema;
    $schema = Finances::Schema->connect(
        'DBI:Pg:dbname=finances'
    );
}

1;

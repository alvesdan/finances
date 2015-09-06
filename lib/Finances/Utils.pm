package Finances::Utils;
use strict;
use warnings;

use Exporter 'import';
our @EXPORT = qw/require_or_exit p/;
our @EXPORT_OK = qw/require_or_exit p/;

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

1;

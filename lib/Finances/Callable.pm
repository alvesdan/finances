package Finances::Callable;
use strict;
use warnings;

our $schema;
our %commands = ();

use Exporter 'import';
our @EXPORT_OK = qw/add_commands schema/;
sub add_commands {
  my $class = shift;
  my $key = command_key($class);
  $commands{$key} = \@_;
}

sub command_key {
  my $package_name = shift;
  $package_name =~ s/[^a-zA-z]+//;
  lc $package_name;
}

sub call {
  my $self = shift;
  $schema = shift;
  my @arguments = @{shift @_};

  if (@arguments) {
    $self->call_with_arguments(\@arguments);
  } else {
    $self->list();
  }
}

sub call_with_arguments {
  my $self = shift;
  my @arguments = @{shift @_};
  my $command = shift @arguments;
  my $key = command_key($self);
  my @commands = @{$commands{$key}};
  my @valid_command = grep { $_ eq $command } @commands;

  if (@valid_command) {
    my $valid_command = shift @valid_command;
    $self->$valid_command(\@arguments);
  } else {
    print "Sorry, invalid command.\n";
  }
}

sub schema {
  $schema;
}

1;

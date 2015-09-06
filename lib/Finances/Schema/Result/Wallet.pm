package Finances::Schema::Result::Wallet;

use warnings;
use strict;

use base qw( DBIx::Class::Core );

__PACKAGE__->table('wallets');
__PACKAGE__->load_components(qw( TimeStamp Result::Validation ));

__PACKAGE__->add_columns(
  id => {
    data_type => 'integer',
    is_auto_increment => 1
  },
  name => { data_type => 'varchar', size => 255 },
  description => { data_type => 'text', is_nullable => 1 },

  created_at => { data_type => 'datetime', set_on_create => 1 },
  updated_at => {
    data_type => 'datetime',
    set_on_create => 1,
    set_on_update => 1
  }
);

__PACKAGE__->set_primary_key('id');

__PACKAGE__->has_many(
  'expenses', 'Finances::Schema::Result::Expense', 'wallet_id');

sub _validate {
  my $self = shift;
  my @other = $self->result_source->resultset->search({
    name => $self->name,
    id => { '!=', $self->id }
  });

  if (scalar @other) {
    $self->add_result_error('name', 'must be unique');
  }

  do {
    $self->add_result_error('name', 'is required');
  } unless $self->name;
}

1;

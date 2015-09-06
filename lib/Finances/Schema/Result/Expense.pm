package Finances::Schema::Result::Expense;

use warnings;
use strict;

use base qw( DBIx::Class::Core );

__PACKAGE__->table('expenses');
__PACKAGE__->load_components(qw( TimeStamp Result::Validation ));

__PACKAGE__->add_columns(
  id => {
    data_type => 'integer',
    is_auto_increment => 1
  },
  wallet_id => { data_type => 'integer' },
  category_id => { data_type => 'integer' },
  amount => { data_type => 'decimal', size => [9, 2] },
  description => { data_type => 'text', is_nullable => 1 },

  created_at => { data_type => 'datetime', set_on_create => 1 },
  updated_at => {
    data_type => 'datetime',
    set_on_create => 1,
    set_on_update => 1
  }
);

__PACKAGE__->belongs_to(
  'wallet',
  'Finances::Schema::Result::Wallet',
  'wallet_id'
);

__PACKAGE__->belongs_to(
  'category',
  'Finances::Schema::Result::Category',
  'category_id'
);

__PACKAGE__->set_primary_key('id');

sub wallet_name {
  my $self = shift;
  $self->wallet->name;
}

sub category_name {
  my $self = shift;
  $self->category->name;
}

1;


use DBIx::Class::Migration;
use DBIx::Class::DeploymentHandler;
use lib 'lib';
use Finances::Schema;

my $migration = DBIx::Class::Migration->new(
  schema_class => 'Finances::Schema',
  schema => Finances::Schema->connect('DBI:Pg:dbname=finances'),
  target_dir => 'db'
);

$migration->drop_tables;
$migration->delete_table_rows;
$migration->prepare_install;
$migration->install_if_needed;
$migration->diagram;


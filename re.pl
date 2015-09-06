use Devel::REPL;
use lib 'lib';
use Finances;
use strict;
use warnings;

my $repl = Devel::REPL->new;
$repl->load_plugin($_) for qw(History LexEnv);
$repl->run;

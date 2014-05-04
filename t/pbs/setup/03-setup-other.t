#!perl

use PBS::Setup::Tests ':std';
use lib 't/pbs/setup/tlib';

for my $class ('PBS::Setup::Moo', 'PBS::Setup::MooRole') {
  subtest $class => sub {
    my $test_class = $class;
    $test_class =~ s/:://g;
    my $ok = do { eval "require $test_class"; $@ || undef  };
    is($ok, undef, "loaded $test_class ok");
    is($test_class->can($_), undef, "clean of $_ import") for qw( try catch blessed has after before );

    is($test_class->something(42), 43, 'all import symbols work fine');
  };
}


done_testing();

#!perl

use PBS::Setup::Tests;
use t::PBS::Roles::PerClassSingleton::X;
use t::PBS::Roles::PerClassSingleton::Y;

subtest 'instance()' => sub {
  my $x1 = t::PBS::Roles::PerClassSingleton::X->instance;
  isa_ok($x1, 't::PBS::Roles::PerClassSingleton::X', 'instance() returns an object of the expected class');
  is(t::PBS::Roles::PerClassSingleton::X->instance, $x1, 'second call to instance() returns same object');
};


subtest 'build_default_instance' => sub {
  my $y1 = t::PBS::Roles::PerClassSingleton::Y->instance;
  is($y1->y, $$, 'default values were set properly');
};


done_testing();

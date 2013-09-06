#!perl

use PBS::Setup::Tests ':std';

plan skip_all => 'Requires PBS::Meta to test this' unless eval { require PBS::Meta };

use_ok('PBS::Setup');

subtest 'env' => sub {
  local $ENV{PROJECT_ENV};
  like(exception { PBS::Setup->env }, qr{^\QFATAL: PROJECT_ENV is required}, 'no ENV PROJECT_ENV will kill you');

  is(exception { PBS::Setup->env('setitup') }, undef, 'call env() with param will not die');
  is(PBS::Setup->env, 'setitup', '... parameter is used if no PROJECT_ENV set');

  is(exception { PBS::Setup->env('another') }, undef, 'second call to env() with param will not die');
  is(PBS::Setup->env, 'setitup', '... new parameter is ignored, only first call will be used');
};


done_testing();

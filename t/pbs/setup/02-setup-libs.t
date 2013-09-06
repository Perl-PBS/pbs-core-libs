#!perl

use PBS::Setup::Tests;

plan skip_all => 'Requires PBS::Meta to test this' unless eval { require PBS::Meta };


subtest 'basics' => sub {
  use_ok('PBS::Setup::Lib');
  is($INC[0], PBS::Meta->root_dir('lib'), 'main @INC lib is our own project lib/');
};


subtest 'single call to setup_std_libs' => sub {
  isnt($INC[1], PBS::Meta->root_dir('lib'), 'second @INC entry not our project lib/');
  PBS::Setup::Lib->setup_std_libs;
  isnt($INC[1], PBS::Meta->root_dir('lib'), 'still not the project lib/');
};


done_testing();

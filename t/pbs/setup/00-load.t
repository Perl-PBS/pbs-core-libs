#!perl

use PBS::Setup::Tests;

pass('PBS::Setup::Tests loaded ok');
ok(!main->can('cmp_deeply'), 'Test::Deep not included by default');
ok(!main->can('exception'),  '... nor is Test::Fatal');

done_testing();

#!perl

use PBS::Setup::Tests ':std';

ok(main->can('cmp_deeply'), 'Test::Deep included with :std');
ok(main->can('exception'),  '... so is Test::Fatal');

done_testing();

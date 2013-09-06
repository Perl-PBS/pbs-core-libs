package PBS::Setup::Script;

use PBS::Setup;

sub import {
  shift;

  PBS::Setup->env(@_) if @_;

  ## FIXME: would love to force autodie on caller...

  goto \&PBS::Setup::std_imports;
}


1;

package PBS::Setup::Script;

use PBS::Setup;

sub import {
  shift;

  my %options = @_ % 2 ? ('env', @_) : @_;

  PBS::Setup->env($options{env}) if $options{env};

  ## FIXME: would love to force autodie on caller...

  goto \&PBS::Setup::std_imports;
}


1;

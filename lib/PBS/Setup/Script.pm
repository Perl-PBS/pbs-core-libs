package PBS::Setup::Script;

use PBS::Setup;
use parent 'PBS::Setup';

sub import {
  shift;

  my %options = @_ % 2 ? ('env', @_) : @_;

  PBS::Setup->env($options{env}) if $options{env};

  chdir(PBS::Setup->root_dir) if $options{chdir_to_root};

  ## FIXME: would love to force autodie on caller...

  goto \&PBS::Setup::std_imports;
}


1;

package PBS::Setup::Exporter;

use PBS::Setup;
use Exporter                   ();
use Method::Signatures::Simple ();

sub import {
  my $target = caller;

  no strict 'refs';
  unshift @{ $target . '::ISA' }, 'Exporter';

  Method::Signatures::Simple->import(into => $target);

  goto \&PBS::Setup::std_imports;
}

1;

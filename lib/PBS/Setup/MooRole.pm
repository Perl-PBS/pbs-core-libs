package PBS::Setup::MooRole;

use PBS::Setup;
use Import::Into;
use Method::Signatures::Simple ();
use Moo::Role                  ();
use namespace::sweep           ();
use Try::Tiny                  ();

sub import {
  my $target = caller;

  Method::Signatures::Simple->import(into => $target);
  Scalar::Util->import::into($target, qw(blessed));
  Try::Tiny->import::into($target);
  namespace::sweep->import(-cleanee => $target);

  ## FIXME: I wonder, anyway to call PBS::Setup->std_imports one extra level above?
  ## would allow us to remove this duplicate code from here
  utf8->import();
  feature->import(':5.14');

  splice(@_, 0, 1, 'Moo::Role');
  goto \&Moo::Role::import;
}

sub unimport {
  splice(@_, 0, 1, 'Moo::Role');
  goto \&Moo::Role::unimport;
}

1;

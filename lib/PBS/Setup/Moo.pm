package PBS::Setup::Moo;

# ABSTRACT: a Moo setup class

use PBS::Setup;
use Method::Signatures::Simple ();
use Moo                        ();
use namespace::sweep           ();
use Scalar::Util               ();
use Try::Tiny                  ();

sub import {
  my $target = caller;

  Method::Signatures::Simple->import(into => $target);
  Scalar::Util->export_to_level(1, $target, qw(blessed));
  Try::Tiny->export_to_level(1);
  namespace::sweep->import(-cleanee => $target);

  ## FIXME: I wonder, anyway to call PBS::Setup->std_imports one extra level above?
  ## would allow us to remove this duplicate code from here
  utf8->import();
  feature->import(':5.14');

  splice(@_, 0, 1, 'Moo');
  goto \&Moo::import;
}

sub unimport {
  splice(@_, 0, 1, 'Moo');
  goto \&Moo::unimport;
}

1;

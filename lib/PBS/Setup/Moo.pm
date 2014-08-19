package PBS::Setup::Moo;

# ABSTRACT: a Moo setup class

use PBS::Setup;
use Import::Into;
use Method::Signatures::Simple ();
use Moo                        ();
use namespace::sweep           ();
use Scalar::Util               ();
use Try::Tiny                  ();
use experimental               ();

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
  experimental->import('switch');    ## Doesn't work, because Moo::import below will export warnings and fuck it up

  splice(@_, 0, 1, 'Moo');
  goto \&Moo::import;
}

sub unimport {
  splice(@_, 0, 1, 'Moo');
  goto \&Moo::unimport;
}

1;

package PBS::Setup::Tests;

use PBS::Setup::Std;
use strict   ();
use warnings ();
use utf8     ();
use Carp;


sub import {
  my $class = shift;

  warnings->import();
  strict->import();
  utf8->import();

  my $target = caller();
  my $add_symbol = sub { no strict 'refs'; *{ $target . "::$_[0]" } = $_[1] };
  $class->__add_symbols($add_symbol);

  ## FIXME: this should be done better somehow...
  my $code = $class->__build_setup_code($target, @_);
  eval $code;
  die if $@;
}

sub __add_symbols { }

sub __build_setup_code {
  my ($class, $target, @opts) = @_;

  my $setup_code = "package $target; use Test::More;";
  for my $opt (@opts) {
    if ($opt eq ':std') {
      $setup_code .= qq{
        use Test::Fatal;
        use Test::Deep;
      }
    }
  }

  return $setup_code;
}

1;

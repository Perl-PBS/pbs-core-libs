package PBS::Setup::Std;

# ABSTRACT: the most basic Perl setup environment

use 5.014;
use strict   ();
use warnings ();
use utf8     ();
use feature  ();

sub import {
  warnings->import();
  strict->import();
  utf8->import();
  feature->import(':5.14');
}

1;

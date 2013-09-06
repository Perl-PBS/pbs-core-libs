package PBS::Setup::Lib;

# ABSTRACT: setup extra lib directories as required by the project

use PBS::Setup::Std;
use PBS::Meta;
use File::Spec;

sub import {
  my $class = shift;
  $class->setup_std_libs;
  $class->setup_extra_libs(@_);
}

{
  my $setup_std_libs_is_done;

  sub setup_std_libs {
    return if $setup_std_libs_is_done;

    ## Ordered from lowest to highest to priority

    ## FIXME: find and setup elib's

    shift->setup_extra_libs('lib');

    $setup_std_libs_is_done = 1;
  }
}

sub setup_extra_libs {
  shift;

  for (@_) {
    my $dir = $_;
    if ($dir =~ m!^lib/?!) { $dir = PBS::Meta->root_dir($dir) }
    elsif ($dir =~ m!^sites/! or $dir =~ m!^elib/!) { $dir = PBS::Meta->root_dir($dir, 'lib') }
    else {
      die "FATAL: could not update \@INC - failed to interpret '$dir',";
    }

    next unless -d $dir;
    next if grep { $_ eq $dir } @INC;

    unshift @INC, $dir;
  }

  return;
}

1;

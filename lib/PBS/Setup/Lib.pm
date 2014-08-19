package PBS::Setup::Lib;

# ABSTRACT: setup extra lib directories as required by the project

use PBS::Setup::Std;
use PBS::Meta;
use File::Spec;
use Config;

sub import {
  my $class = shift;
  $class->setup_std_libs;
  $class->setup_extra_libs(@_);
}

{
  my $setup_std_libs_is_done;

  sub setup_std_libs {
    return if $setup_std_libs_is_done;
    my $class = shift;

    ## Ordered from lowest to highest to priority

    ## FIXME: find and setup elib's

    $class->setup_extra_libs('lib');
    $class->setup_deps;

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

sub setup_deps {
  my $deps = PBS::Meta->root_dir('../deps');
  return unless -d $deps;

  my $i = 0;
  while ($i < @INC) {
    if ($INC[$i] =~ m{/[.]?perlbrew/}) {
      splice(@INC, $i, 0, "$deps/lib/perl5/$Config{archname}", "$deps/lib/perl5");
      last;
    }
    else {
      $i++;
    }
  }
}

1;

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

  my $bin_dir = File::Spec->catdir($deps, 'bin');
  my $lib_dir = File::Spec->catdir($deps, 'lib', 'perl5');
  my @lib_dirs = (File::Spec->catdir($lib_dir, $Config{archname}), $lib_dir);

  my $i = 0;
  while ($i < @INC) {
    if ($INC[$i] =~ m{/[.]?perlbrew/}) {
      splice(@INC, $i, 0, @lib_dirs);
      last;
    }
    else {
      $i++;
    }
  }

  # Small man's perlbrew init, useful for exec'ed commands
  $ENV{PERL5LIB} = join(':', @lib_dirs, $ENV{PERL5LIB});
  $ENV{PATH} = join(':', $bin_dir, $ENV{PATH}) if -d $bin_dir;
}

1;

package PBS::Setup;

use PBS::Setup::Std;
use Carp ();

##############
# Import tools

sub import {
  require PBS::Setup::Lib;
  PBS::Setup::Lib->setup_std_libs;

  goto \&std_imports;
}

sub std_imports { goto \&PBS::Setup::Std::import }


####################
# Active environment

{
  my $env;

  sub env {
    return $env if defined $env;

    return $env = do {
      my $v = $ENV{PROJECT_ENV} || $_[1];
      Carp::confess("FATAL: PROJECT_ENV is required") unless defined $v;

      $v =~ s/^://;

      $ENV{PROJECT_ENV} = $v;
    };
  }
}


#######################
# Important directories

sub root_dir { shift; return PBS::Meta->root_dir(@_) }


1;

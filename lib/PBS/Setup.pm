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

    my ($class, $requested_default_env) = @_;

    return $env = do {
      my $v = $ENV{PROJECT_ENV} || $requested_default_env || 'auto';

      if ($v eq 'auto') {
        if (-d $class->root_dir('.git')) { $v = 'devel' }
        elsif (-e (my $dep_env_fn = $class->root_dir('.deployed_env'))) {
          open(my $fh, '<', $dep_env_fn);
          chomp($v = <$fh>);
        }

        Carp::confess("FATAL: PROJECT_ENV is required, and could not be automatically determined")
          unless $v and $v ne 'auto';
        warn "PROJECT_ENV set to '$v' automatically\n" unless $ENV{SKIP_AUTO_PROJECT_ENV_WARNING};
      }

      $v =~ s/^://;

      $ENV{PROJECT_ENV} = $v;
    };
  }
}


#######################
# Important directories

sub root_dir { shift; return PBS::Meta->root_dir(@_) }


1;

package t::PBS::Roles::PerClassSingleton::Y;

use PBS::Setup::Moo;

has 'y' => ( is => 'ro' );

method build_default_instance () { return $self->new(y => $$) }

## This needs to be at the end - method's are invisible to 'with' :(
with 'PBS::Roles::PerClassSingleton';

1;

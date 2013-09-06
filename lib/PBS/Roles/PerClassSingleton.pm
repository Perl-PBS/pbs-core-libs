package PBS::Roles::PerClassSingleton;

use PBS::Setup::MooRole;

{
  my %class2instance;

  method instance () {
    $self = blessed($self) || $self;
    return $class2instance{$self} if exists $class2instance{$self};

    return $class2instance{$self} = $self->build_default_instance(@_);
  }
}

method build_default_instance () { return $self->new(@_) }

1;

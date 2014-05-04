package PBSSetupMoo;

use PBS::Setup::Moo;

method something ($something) {
  try {
    $something++
  }
  catch {
    ...
  };
  
  $something++ if blessed($something);
  
  return $something;
}

1;

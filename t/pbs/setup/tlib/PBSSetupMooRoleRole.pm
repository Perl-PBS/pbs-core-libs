package PBSSetupMooRoleRole;

use PBS::Setup::MooRole;

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

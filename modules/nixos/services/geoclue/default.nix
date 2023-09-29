{ config
, lib
, options
, ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt;

  cfg = config.beansnix.services.geoclue;
in
{
  options.beansnix.services.geoclue = {
    enable = mkBoolOpt false "Whether or not to configure geoclue support.";
  };

  config = mkIf cfg.enable {
    services.geoclue2.enable = true;
  };
}

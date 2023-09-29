{ config
, lib
, options
, ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt enabled;

  cfg = config.beansnix.archetypes.gaming;
in
{
  options.beansnix.archetypes.gaming = {
    enable = mkBoolOpt false "Whether or not to enable the gaming archetype.";
  };

  config = mkIf cfg.enable {
    beansnix.suites = {
      common = enabled;
      desktop = enabled;
      games = enabled;
      video = enabled;
    };
  };
}

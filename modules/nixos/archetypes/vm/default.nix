{ config
, lib
, options
, ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt enabled;

  cfg = config.beansnix.archetypes.vm;
in
{
  options.beansnix.archetypes.vm = {
    enable =
      mkBoolOpt false "Whether or not to enable the vm archetype.";
  };

  config = mkIf cfg.enable {
    beansnix = {
      suites = {
        common = enabled;
        desktop = enabled;
        development = enabled;
        vm = enabled;
      };
    };
  };
}

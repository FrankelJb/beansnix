{ config
, lib
, options
, ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt enabled;

  cfg = config.beansnix.archetypes.workstation;
in
{
  options.beansnix.archetypes.workstation = {
    enable =
      mkBoolOpt false "Whether or not to enable the workstation archetype.";
  };

  config = mkIf cfg.enable {
    beansnix = {
      apps = {
        yubikey = enabled;
        monero-gui = enabled;
      };

      cli-apps = {
        yubikey = enabled;
      };

      suites = {
        common = enabled;
        desktop = enabled;
        development = enabled;
      };
    };
  };
}

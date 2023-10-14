{
  config,
  lib,
  options,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt enabled;

  cfg = config.beansnix.suites.business;
in {
  options.beansnix.suites.business = {
    enable = mkBoolOpt false "Whether or not to enable business configuration.";
  };

  config = mkIf cfg.enable {
    beansnix = {
      apps = {
        _1password = enabled;
      };
    };
  };
}

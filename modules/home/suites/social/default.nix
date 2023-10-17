{
  config,
  lib,
  options,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt;

  cfg = config.beansnix.suites.social;
in {
  options.beansnix.suites.social = {
    enable = mkBoolOpt false "Whether or not to enable social configuration.";
  };

  config = mkIf cfg.enable {
    beansnix = {
      apps = {};
    };
  };
}

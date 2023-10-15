{
  config,
  lib,
  options,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt enabled;

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

{
  config,
  lib,
  options,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt;

  cfg = config.beansnix.desktop.addons.foot;
in {
  options.beansnix.desktop.addons.foot = {
    enable = mkBoolOpt false "Whether to enable foot.";
  };

  config = mkIf cfg.enable {
    beansnix.desktop.addons.term = {
      enable = true;
      pkg = pkgs.foot;
    };
  };
}

{ config
, lib
, options
, pkgs
, ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt;

  cfg = config.beansnix.desktop.addons.kitty;
in
{
  options.beansnix.desktop.addons.kitty = {
    enable = mkBoolOpt false "Whether to enable kitty.";
  };

  config = mkIf cfg.enable {
    beansnix.desktop.addons.term = {
      enable = true;
      pkg = pkgs.kitty;
    };
  };
}

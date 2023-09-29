{ config
, lib
, options
, pkgs
, ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt;

  cfg = config.beansnix.desktop.addons.alacritty;
in
{
  options.beansnix.desktop.addons.alacritty = {
    enable = mkBoolOpt false "Whether to enable alacritty.";
  };

  config = mkIf cfg.enable {
    beansnix.desktop.addons.term = {
      enable = true;
      pkg = pkgs.alacritty;
    };
  };
}

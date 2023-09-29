{ config
, lib
, options
, pkgs
, ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt;

  cfg = config.beansnix.desktop.addons.swaylock;
in
{
  options.beansnix.desktop.addons.swaylock = {
    enable =
      mkBoolOpt false "Whether to enable swaylock in the desktop environment.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ swaylock-effects ];

    security.pam.services.swaylock = { };
  };
}

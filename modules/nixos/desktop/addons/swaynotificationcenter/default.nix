{ config
, lib
, options
, pkgs
, ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt;

  cfg = config.beansnix.desktop.addons.swaynotificationcenter;
in
{
  options.beansnix.desktop.addons.swaynotificationcenter = {
    enable =
      mkBoolOpt false "Whether to enable swaynotificationcenter in the desktop environment.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      swaynotificationcenter
      libnotify
    ];

    beansnix.home = {
      configFile."swaync/" = {
        source = lib.cleanSourceWith {
          src = lib.cleanSource ./config/.;
        };

        recursive = true;
      };
    };
  };
}

{
  config,
  lib,
  options,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt enabled;

  cfg = config.beansnix.suites.desktop;
in {
  options.beansnix.suites.desktop = {
    enable =
      mkBoolOpt false "Whether or not to enable common desktop configuration.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      bleachbit
      dupeguru
      filelight
      fontpreview
      gparted
    ];

    beansnix = {
      apps = {
        firefox = enabled;
      };

      desktop = {
        hyprland = enabled;

        addons = {
          gtk = enabled;
          qt = enabled;
          wallpapers = enabled;
        };
      };
    };
  };
}

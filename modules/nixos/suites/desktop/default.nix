{ config
, lib
, options
, pkgs
, ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt enabled;

  cfg = config.beansnix.suites.desktop;
in
{
  options.beansnix.suites.desktop = {
    enable =
      mkBoolOpt false "Whether or not to enable common desktop configuration.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      authy
      barrier
      bleachbit
      dropbox
      dupeguru
      filelight
      fontpreview
      gparted
      keepass
      pkgs.beansnix.pocketcasts
    ];

    beansnix = {
      apps = {
        _1password = enabled;
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

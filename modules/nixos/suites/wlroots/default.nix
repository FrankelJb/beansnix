{
  config,
  lib,
  options,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt enabled;

  cfg = config.beansnix.suites.wlroots;
in {
  options.beansnix.suites.wlroots = {
    enable =
      mkBoolOpt false "Whether or not to enable common wlroots configuration.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      cliphist
      grim
      slurp
      swayimg
      wdisplays
      wf-recorder
      wl-clipboard
      wlr-randr
      # Not really wayland specific, but I don't want to make a new module for it
      brightnessctl
      glib # for gsettings
      gtk3.out # for gtk-launch
      playerctl
    ];

    beansnix = {
      cli-apps = {
        wshowkeys = enabled;
      };

      desktop.addons = {
        # FIXME: for some reason, this breaks vscodium
        electron-support = enabled;
        swappy = enabled;
        swaylock = enabled;
        swaynotificationcenter = enabled;
        wlogout = enabled;
      };
    };

    programs = {
      nm-applet.enable = true;
      xwayland.enable = true;
    };
  };
}

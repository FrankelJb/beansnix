{ config
, lib
, options
, ...
}:
let
  inherit (lib) mkIf getExe';
  inherit (lib.internal) mkBoolOpt;

  cfg = config.beansnix.desktop.addons.swayidle;
in
{
  options.beansnix.desktop.addons.swayidle = {
    enable =
      mkBoolOpt false "Whether to enable swayidle in the desktop environment.";
  };

  config = mkIf cfg.enable {
    services.swayidle = {
      enable = true;
      systemdTarget = "graphical-session.target";
      # TODO: Make dynamic for window manager
      events = [
        {
          event = "after-resume";
          command = "${getExe' config.wayland.windowManager.hyprland.package "hyprctl"} dispatch dpms on";
        }
      ];
      timeouts = [
        {
          timeout = 1800;
          command = "${getExe' config.wayland.windowManager.hyprland.package "hyprctl"} dispatch dpms off";
        }
      ];
    };
  };
}

{
  config,
  lib,
  options,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt;

  cfg = config.beansnix.desktop.addons.xdg-portal;
in {
  options.beansnix.desktop.addons.xdg-portal = {
    enable = mkBoolOpt false "Whether or not to add support for xdg portal.";
  };

  config = mkIf cfg.enable {
    xdg = {
      portal = {
        enable = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-gtk
        ];
        # ++ (lib.optional config.beansnix.desktop.hyprland.enable xdg-desktop-portal-hyprland);
        # ++ (lib.optional config.beansnix.desktop.sway.enable xdg-desktop-portal-wlr);
      };
    };
  };
}

{ config
, inputs
, lib
, options
, pkgs
, system
, ...
}:
let
  inherit (lib) mkIf mkForce getExe mkMerge;
  inherit (lib.internal) mkBoolOpt;
  inherit (inputs) nixpkgs-wayland;

  cfg = config.beansnix.desktop.addons.waybar;

  theme = builtins.readFile ./styles/catppuccin.css;
  style = builtins.readFile ./styles/style.css;
  notificationsStyle = builtins.readFile ./styles/notifications.css;
  powerStyle = builtins.readFile ./styles/power.css;
  statsStyle = builtins.readFile ./styles/stats.css;
  workspacesStyle = builtins.readFile ./styles/workspaces.css;

  custom-modules = import ./modules/custom-modules.nix { inherit config lib pkgs; };
  default-modules = import ./modules/default-modules.nix { inherit lib pkgs; };
  group-modules = import ./modules/group-modules.nix;
  hyprland-modules = import ./modules/hyprland-modules.nix { inherit config lib; };

  all-modules = mkMerge [
    custom-modules
    default-modules
    group-modules
    (lib.mkIf config.beansnix.desktop.hyprland.enable hyprland-modules)
  ];

  bar = {
    "layer" = "top";
    "position" = "top";

    "margin-top" = 10;
    "margin-left" = 10;
    "margin-right" = 10;

    "modules-left" = [
      "custom/wlogout"
      "hyprland/workspaces"
      "custom/separator-left"
      "hyprland/window"
    ];
  };

  mainBar = {
    "output" = "DP-3";
    # "modules-center" = [ "mpris" ];

    "modules-right" = [
      "group/tray"
      "custom/separator-right"
      "group/stats"
      "custom/separator-right"
      "group/notifications"
      "hyprland/submap"
      # "custom/weather"
      "clock"
    ];
  };
in
{
  options.beansnix.desktop.addons.waybar = {
    enable =
      mkBoolOpt false "Whether to enable waybar in the desktop environment.";
    debug = mkBoolOpt false "Whether to enable debug mode.";
  };

  config = mkIf cfg.enable {
    systemd.user.services.waybar.Service.ExecStart = mkIf cfg.debug (mkForce "${getExe config.programs.waybar.package} -l debug");

    programs.waybar = {
      enable = true;
      package = nixpkgs-wayland.packages.${system}.waybar;
      systemd.enable = true;

      # TODO: make dynamic / support different number of bars etc
      settings = {
        mainBar = mkMerge [ bar mainBar all-modules ];
      };

      style = "${theme}${style}${notificationsStyle}${powerStyle}${statsStyle}${workspacesStyle}";
    };
  };
}

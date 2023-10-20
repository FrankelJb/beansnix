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
    "output" = "DP-3";
    "margin-top" = 10;
    "margin-left" = 10;
    "margin-right" = 10;
    # "modules-center" = [ "mpris" ];
    "modules-left" = [
      "custom/wlogout"
      "hyprland/workspaces"
      "custom/separator-left"
      "hyprland/window"
    ];
    "modules-right" = [
      "group/stats"
      "custom/separator-right"
      "group/tray"
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
      # package = nixpkgs-wayland.packages.${system}.waybar;
      package = pkgs.waybar;
      systemd.enable = true;

      # TODO: make dynamic / support different number of bars etc
      settings = {
        mainBar = mkMerge [ mainBar all-modules ];
      };

      style = "${theme}${style}";
    };
  };
}

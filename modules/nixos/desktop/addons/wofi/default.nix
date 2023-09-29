{ config
, lib
, options
, pkgs
, ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt;

  cfg = config.beansnix.desktop.addons.wofi;
in
{
  options.beansnix.desktop.addons.wofi = {
    enable =
      mkBoolOpt false "Whether to enable the Wofi in the desktop environment.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      wofi
      wofi-emoji
    ];

    beansnix.home.configFile = {
      "wofi/config".source = ./config;
      "wofi/style.css".source = ./style.css;
    };
  };
}

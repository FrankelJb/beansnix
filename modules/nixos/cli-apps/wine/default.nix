{ config
, lib
, options
, pkgs
, ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt;

  cfg = config.beansnix.cli-apps.wine;
in
{
  options.beansnix.cli-apps.wine = {
    enable = mkBoolOpt false "Whether or not to enable Wine.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # winePackages.waylandFull
      winetricks
      wine64Packages.waylandFull
    ];
  };
}

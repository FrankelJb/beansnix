{ config
, lib
, options
, pkgs
, ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt;

  cfg = config.beansnix.desktop.addons.swappy;
in
{
  options.beansnix.desktop.addons.swappy = {
    enable =
      mkBoolOpt false "Whether to enable Swappy in the desktop environment.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ swappy ];

    beansnix.home = {
      configFile."swappy/config".source = ./config;
      file."Pictures/screenshots/.keep".text = "";
    };
  };
}

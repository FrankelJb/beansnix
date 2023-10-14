{ config
, lib
, options
, pkgs
, ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt;

  cfg = config.beansnix.apps.monero-gui;
in
{
  options.beansnix.apps.monero-gui = {
    enable =
      mkBoolOpt false "Whether or not to enable Monero GUI";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      monero-gui
    ];
  };
}

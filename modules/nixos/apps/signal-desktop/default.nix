{ config
, lib
, options
, pkgs
, ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt;

  cfg = config.beansnix.apps.signal-desktop;
in
{
  options.beansnix.apps.signal-desktop = {
    enable = mkBoolOpt false "Whether or not to enable signal-desktop.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ signal-desktop ];
  };
}

{ config
, lib
, options
, pkgs
, ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt;

  cfg = config.beansnix.apps.dolphin;
in
{
  options.beansnix.apps.dolphin = {
    enable = mkBoolOpt false "Whether or not to enable Dolphin.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ dolphin-emu ];

    # Enable GameCube controller support.
    services.udev.packages = [ pkgs.dolphinEmu ];
  };
}

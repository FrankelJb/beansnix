{ config
, lib
, options
, pkgs
, ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt;

  cfg = config.beansnix.services.ios;
in
{
  options.beansnix.services.ios = {
    enable = mkBoolOpt false "Whether or not to configure ios support.";
  };

  config = mkIf cfg.enable {
    services.usbmuxd.enable = true;
    environment.systemPackages = with pkgs; [
      libimobiledevice
      ifuse # optional, to mount using 'ifuse'
      shotwell
      usbmuxd
    ];
  };

}

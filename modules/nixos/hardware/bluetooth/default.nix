{ config
, lib
, options
, ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt;

  cfg = config.beansnix.hardware.bluetooth;
in
{
  options.beansnix.hardware.bluetooth = {
    enable =
      mkBoolOpt false
        "Whether or not to enable support for extra bluetooth devices.";
  };

  config = mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
    };

    services.blueman = {
      enable = true;
    };
  };
}

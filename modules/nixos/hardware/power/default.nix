{ config
, lib
, options
, ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt;

  cfg = config.beansnix.hardware.power;
in
{
  options.beansnix.hardware.power = {
    enable =
      mkBoolOpt false
        "Whether or not to enable support for extra power devices.";
  };

  config = mkIf cfg.enable {
    services.upower = {
      enable = true;
      percentageAction = 5;
      percentageCritical = 10;
      percentageLow = 25;
    };
  };
}

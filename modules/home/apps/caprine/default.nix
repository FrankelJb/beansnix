{ config
, lib
, ...
}:
let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.beansnix.apps.caprine;
in
{
  options.beansnix.apps.caprine = {
    enable = mkEnableOption "caprine";
  };

  config = mkIf cfg.enable {
    xdg.configFile = {
      "Caprine/custom.css".source = ./custom.css;
    };
  };
}

{ config
, lib
, ...
}:
let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.beansnix.apps.armcord;
in
{
  options.beansnix.apps.armcord = {
    enable = mkEnableOption "armcord";
  };

  config = mkIf cfg.enable {
    xdg.configFile = {
      "ArmCord/themes/Catppuccin-Macchiato-BD".source = ./Catppuccin-Macchiato-BD;
    };
  };
}


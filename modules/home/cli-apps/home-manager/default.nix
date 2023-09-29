{ config
, lib
, ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (lib.internal) enabled;

  cfg = config.beansnix.cli-apps.home-manager;
in
{
  options.beansnix.cli-apps.home-manager = {
    enable = mkEnableOption "home-manager";
  };

  config = mkIf cfg.enable {
    programs.home-manager = enabled;
  };
}

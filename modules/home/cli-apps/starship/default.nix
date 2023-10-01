{ config
, lib
, options
, ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt;

  cfg = config.beansnix.cli-apps.starship;
in
{
  options.beansnix.cli-apps.starship = {
    enable = mkBoolOpt false "Whether or not to enable starship.";
  };

  config = mkIf cfg.enable {
    programs.starship = {
      enable = true;
    };
  };
}

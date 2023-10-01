{ config
, lib
, ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt;

  cfg = config.beansnix.cli-apps.zellij;
in
{
  options.beansnix.cli-apps.zellij = {
    enable = mkBoolOpt false "Whether or not to enable zellij.";
  };

  config =
    mkIf cfg.enable
      {
        programs.zellij = {
          enable = true;
        };
        xdg.configFile = {
          "zellij/config.kdl".source = ./config/config.kdl;
        };
      };
}

{
  config,
  lib,
  options,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt;

  cfg = config.beansnix.cli-apps.k9s;
in {
  options.beansnix.cli-apps.k9s = {
    enable = mkBoolOpt false "Whether or not to enable k9s.";
  };

  config = mkIf cfg.enable {
    programs.k9s = {
      enable = true;
      package = pkgs.k9s;
    };
  };
}

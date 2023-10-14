{
  config,
  lib,
  options,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt;

  cfg = config.beansnix.cli-apps.bottom;
in {
  options.beansnix.cli-apps.bottom = {
    enable = mkBoolOpt false "Whether or not to enable bottom.";
  };

  config = mkIf cfg.enable {
    programs.bottom = {
      enable = true;
      package = pkgs.bottom;

      settings = builtins.fromTOML (builtins.readFile (pkgs.catppuccin + "/bottom/macchiato.toml"));
    };
  };
}

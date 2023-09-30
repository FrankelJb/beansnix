{
  config,
  lib,
  options,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt enabled;

  cfg = config.beansnix.suites.development;
in {
  options.beansnix.suites.development = {
    enable =
      mkBoolOpt false
      "Whether or not to enable common development configuration.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      cpplint
    ];

    beansnix = {
      apps = {
        vscode = enabled;
      };

      cli-apps = {
        astronvim = {
          enable = true;
          default = true;
        };
        lazygit = enabled;
      };

      tools = {
        oh-my-posh = enabled;
      };
    };
  };
}

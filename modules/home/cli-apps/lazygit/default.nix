{ config
, lib
, options
, ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt;

  cfg = config.beansnix.cli-apps.lazygit;
in
{
  options.beansnix.cli-apps.lazygit = {
    enable = mkBoolOpt false "Whether or not to enable lazygit.";
  };

  config = mkIf cfg.enable {
    programs.lazygit = {
      enable = true;
    };

    home.shellAliases = {
      lg = "lazygit";
    };
  };
}

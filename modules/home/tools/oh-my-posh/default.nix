{ config
, lib
, options
, pkgs
, ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt;

  cfg = config.beansnix.tools.oh-my-posh;
in
{
  options.beansnix.tools.oh-my-posh = {
    enable = mkBoolOpt false "Whether or not to enable oh-my-posh.";
  };

  config = mkIf cfg.enable {
    programs.oh-my-posh = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
      package = pkgs.oh-my-posh;
      settings = builtins.fromJSON (builtins.unsafeDiscardStringContext (builtins.readFile ./config.json));
    };
  };
}

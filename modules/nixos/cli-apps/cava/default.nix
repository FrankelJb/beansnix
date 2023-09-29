{ config
, lib
, options
, pkgs
, ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt;

  cfg = config.beansnix.cli-apps.cava;
in
{
  options.beansnix.cli-apps.cava = {
    enable = mkBoolOpt false "Whether or not to enable cava.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ cava ];

    beansnix.home = {
      configFile = {
        "cava/config".source = ./config;
      };

      extraOptions.home.shellAliases = {
        cava = "TERM=st-256color cava";
      };
    };
  };
}

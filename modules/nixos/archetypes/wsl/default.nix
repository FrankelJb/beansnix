{ config
, lib
, options
, pkgs
, ...
}:
let
  inherit (lib) mkIf mkForce;
  inherit (lib.internal) mkBoolOpt;

  cfg = config.beansnix.archetypes.wsl;
in
{
  options.beansnix.archetypes.wsl = {
    enable =
      mkBoolOpt false "Whether or not to enable the wsl archetype.";
  };

  config = mkIf cfg.enable {
    environment = {
      noXlibs = mkForce false;

      sessionVariables = {
        BROWSER = "wsl-open";
      };

      systemPackages = with pkgs; [
        dos2unix
        wsl-open
        wslu
      ];
    };
  };
}

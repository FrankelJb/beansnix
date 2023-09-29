{ config
, lib
, options
, pkgs
, ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt;

  cfg = config.beansnix.suites.art;
in
{
  options.beansnix.suites.art = {
    enable = mkBoolOpt false "Whether or not to enable art configuration.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      blender
      gimp
      inkscape-with-extensions
    ];
  };
}

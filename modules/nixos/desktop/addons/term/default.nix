{ config
, lib
, options
, pkgs
, ...
}:
let
  inherit (lib) types mkIf;
  inherit (lib.internal) mkBoolOpt mkOpt;

  cfg = config.beansnix.desktop.addons.term;
in
{
  options.beansnix.desktop.addons.term = with types; {
    enable = mkBoolOpt false "Whether to install a terminal emulator.";
    pkg = mkOpt package pkgs.kitty "The terminal to install.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.pkg ];
  };
}

{ config
, lib
, ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt;

  cfg = config.beansnix.nix;
in
{
  options.beansnix.nix = {
    enable = mkBoolOpt true "Whether or not to manage nix configuration.";
  };

  # TODO: remove module? 
  config = mkIf cfg.enable {
    sops.secrets.nix = {
      sopsFile = ../../../secrets/beans/default.json;
      path = "${config.home.homeDirectory}/.config/nix/nix.conf";
    };
  };
}

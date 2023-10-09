{ config
, lib
, options
, pkgs
, ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt;

  cfg = config.beansnix.apps.virtualbox;
in
{
  options.beansnix.apps.virtualbox = {
    enable = mkBoolOpt false "Whether or not to enable Virtualbox.";
  };

  config = mkIf cfg.enable {
    beansnix.user.extraGroups = [ "vboxusers" ];

    environment.systemPackages = [
      pkgs.spice-vdagent
    ];

    virtualisation.virtualbox.host = {
      enable = true;
      enableExtensionPack = true;
    };
  };
}

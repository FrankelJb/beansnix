{ config
, lib
, options
, pkgs
, ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt;

  cfg = config.beansnix.hardware.storage;
in
{
  options.beansnix.hardware.storage = {
    enable =
      mkBoolOpt false
        "Whether or not to enable support for extra storage devices.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs;
      [
        btrfs-progs
        fuseiso
        nfs-utils
        ntfs3g
      ];
  };
}

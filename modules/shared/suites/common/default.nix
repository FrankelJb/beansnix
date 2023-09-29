{ config
, lib
, options
, pkgs
, ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt;

  cfg = config.beansnix.suites.common;
in
{
  options.beansnix.suites.common = {
    enable = mkBoolOpt false "Whether or not to enable common configuration.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      coreutils
      curl
      eza
      fd
      file
      findutils
      killall
      pciutils
      tldr
      unzip
      wget
      xclip
    ];
  };
}

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
      age
      ansible
      bottom
      coreutils
      curl
      du-dust
      duf
      fd
      file
      findutils
      killall
      lsof
      ncdu
      neofetch
      restic
      ripgrep
      # TODO: Rust toolchain
      #rust-bin.stable.latest.default
      pciutils
      sops
      tealdeer
      unzip
      wget
      xclip
      zellij
    ];
  };
}

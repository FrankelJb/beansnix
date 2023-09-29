{ config
, lib
, pkgs
, ...
}:
let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.beansnix.services.barrier;
in
{
  options.beansnix.services.barrier = {
    enable = mkEnableOption "barrier";

  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ barrier ];

    networking.firewall = {
      allowedTCPPorts = [ 24800 ];
    };
  };
}

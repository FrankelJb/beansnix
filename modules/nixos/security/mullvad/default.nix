{ config
, lib
, options
, pkgs
, ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt;

  cfg = config.beansnix.security.mullvad;
in
{
  options.beansnix.security.mullvad = {
    enable = mkBoolOpt false "Whether to enable mullvad.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      mullvad-vpn
    ];
    services = {
      mullvad-vpn.enable = true;
    };
  };
}

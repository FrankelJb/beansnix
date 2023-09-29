{ config
, lib
, options
, pkgs
, ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt;

  cfg = config.beansnix.apps.yubikey;
in
{
  options.beansnix.apps.yubikey = {
    enable = mkBoolOpt false "Whether or not to enable Yubikey.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ yubikey-manager-qt ];

    services.yubikey-agent.enable = true;
  };
}

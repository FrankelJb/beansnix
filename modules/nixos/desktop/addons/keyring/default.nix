{ config
, lib
, options
, pkgs
, ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt;

  cfg = config.beansnix.desktop.addons.keyring;
in
{
  options.beansnix.desktop.addons.keyring = {
    enable = mkBoolOpt false "Whether to enable the gnome keyring.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ gnome.seahorse ];

    services.gnome.gnome-keyring.enable = true;
  };
}

{ config
, lib
, options
, ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt;

  cfg = config.beansnix.security.keyring;
in
{
  options.beansnix.security.keyring = {
    enable = mkBoolOpt false "Whether to enable gnome keyring.";
  };

  config = mkIf cfg.enable {
    services.gnome.gnome-keyring.enable = true;
    programs.seahorse.enable = true;
  };
}

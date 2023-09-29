{ config
, lib
, options
, ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt;

  cfg = config.beansnix.desktop.addons.electron-support;
in
{
  options.beansnix.desktop.addons.electron-support = {
    enable =
      mkBoolOpt false
        "Whether to enable electron support in the desktop environment.";
  };

  config = mkIf cfg.enable {
    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };

    beansnix.home.configFile."electron-flags.conf".source =
      ./electron-flags.conf;
  };
}

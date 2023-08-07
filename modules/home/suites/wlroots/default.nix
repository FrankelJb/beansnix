{ options
, config
, lib
, ...
}:
with lib;
with lib.internal; let
  cfg = config.khanelinix.suites.wlroots;
in
{
  options.khanelinix.suites.wlroots = with types; {
    enable =
      mkBoolOpt false "Whether or not to enable common wlroots configuration.";
  };

  config = mkIf cfg.enable {
    khanelinix.cli-apps = { };

    khanelinix.desktop.addons = {
      # swappy = enabled;
      swaylock = enabled;
      # swaynotificationcenter = enabled;
      waybar = enabled;
      # wlogout = enabled;
    };

    khanelinix.security = {
      keyring = enabled;
    };

    # using nixos module
    # services.network-manager-applet.enable = true;
    services.blueman-applet.enable = true;
  };
}

{ options
, config
, lib
, pkgs
, ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt;
  cfg = config.khanelinix.desktop.addons.wofi;
in
{
  options.khanelinix.desktop.addons.wofi = {
    enable =
      mkBoolOpt false "Whether to enable the Wofi in the desktop environment.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ wofi wofi-emoji ];

    # config -> .config/wofi/config
    # css -> .config/wofi/style.css
    # colors -> $XDG_CACHE_HOME/wal/colors
    # khanelinix.home.configFile."foot/foot.ini".source = ./foot.ini;
    khanelinix.home.configFile."wofi/config".source = ./config;
    khanelinix.home.configFile."wofi/style.css".source = ./style.css;
  };
}

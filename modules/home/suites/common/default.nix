{ config
, lib
, pkgs
, ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt enabled;

  cfg = config.beansnix.suites.common;
in
{
  options.beansnix.suites.common = {
    enable =
      mkBoolOpt false
        "Whether or not to enable common configuration.";
  };

  config = mkIf cfg.enable {
    xdg.configFile.wgetrc.text = "";

    beansnix = {
      cli-apps = {
        bottom = enabled;
        btop = enabled;
        fastfetch = enabled;
        ranger = enabled;
        yazi = enabled;
      };

      desktop = {
        addons = {
          alacritty = enabled;
          kitty = enabled;
          foot = enabled;
          qt.enable = pkgs.stdenv.isLinux;
          wezterm = enabled;
        };
      };

      services = {
        udiskie.enable = pkgs.stdenv.isLinux;
      };

      security = {
        # gpg = enabled;
      };

      system = {
        shell = {
          bash = enabled;
          fish = enabled;
        };
      };

      tools = {
        bat = enabled;
        direnv = enabled;
        git = enabled;
        lsd = enabled;
        oh-my-posh = enabled;
        topgrade = enabled;
      };
    };
  };
}

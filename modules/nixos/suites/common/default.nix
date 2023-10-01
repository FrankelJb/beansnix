{ config
, lib
, pkgs
, ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.internal) enabled;

  cfg = config.beansnix.suites.common;
in
{
  imports = [ ../../../shared/suites/common/default.nix ];

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      appimage-run
      clac
      fastfetch
      feh
      fzf
      jq
      beansnix.trace-symlink
      beansnix.trace-which
      ncdu
      toilet
      upower
      util-linux
    ];

    beansnix = {
      cli-apps = {
        ranger = enabled;
      };

      hardware = {
        power = enabled;
      };

      nix = enabled;

      security = {
        gpg = enabled;
      };

      services = {
        openssh = enabled;
      };

      system = {
        fonts = enabled;
        locale = enabled;
        time = enabled;
      };

      tools = {
        colorls = enabled;
        comma = enabled;
        fup-repl = enabled;
        git = enabled;
        glxinfo = enabled;
        nix-ld = enabled;
      };
    };
  };
}

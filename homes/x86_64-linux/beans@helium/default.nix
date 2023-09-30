{ lib
, config
, pkgs
, ...
}:
let
  inherit (lib.internal) enabled;
in
{
  beansnix = {
    user = {
      enable = true;
      inherit (config.snowfallorg.user) name;
    };

    apps = {
      zathura = enabled;
    };

    cli-apps = {
      home-manager = enabled;
    };

    desktop = {
      addons = {
        swayidle = enabled;
        # waybar.debug = true;
        hyprpaper = {
          monitors = [
            {
              name = "DP-1";
              wallpaper = "${pkgs.beansnix.wallpapers}/share/wallpapers/cat-sound.png";
            }
          ];

          wallpapers = [
            # TODO: add my wallpapers
            "${pkgs.beansnix.wallpapers}/share/wallpapers/tetris.png"
          ];
        };
      };

      hyprland = enabled;
    };

    security = {
      sops = {
        enable = true;
        defaultSopsFile = ../../../secrets/beansnix/beans/default.yaml;
        sshKeyPaths = [ "${config.home.homeDirectory}/.ssh/id_ed25519" ];
      };
    };

    system = {
      xdg = enabled;
    };

    suites = {
      common = enabled;
      development = enabled;
      social = enabled;
    };

    tools = {
      git = enabled;
    };
  };

  home.shellAliases = {
    nixcfg = "nvim ~/.config/.dotfiles/dots/nixos/flake.nix";
  };

  home.stateVersion = "21.11";
}

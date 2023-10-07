{ config
, lib
, options
, pkgs
, ...
}:
let
  inherit (lib) types mkIf;
  inherit (lib.internal) mkBoolOpt mkOpt;

  cfg = config.beansnix.desktop.addons.foot;
in
{
  options.beansnix.desktop.addons.foot = with types; {
    enable = mkBoolOpt false "Whether to enable foot.";
    font = mkOpt str "FiraCode Nerd Font" "Font to use for foot.";
    theme = mkOpt str "Catppuccin-Macchiato" "Theme to use for foot.";
  };

  config = mkIf cfg.enable {
    programs.foot = {
      enable = true;

      settings = {
        main = {
          font = "${cfg.font}:size=10";
          box-drawings-uses-font-glyphs = "yes";
          dpi-aware = "yes";
          pad = "0x0center";
          notify = "notify-send -a \${app-id} -i \${app-id} \${title} \${body}";
          selection-target = "clipboard";
        };

        scrollback = {
          lines = 10000;
          multiplier = 3;
        };

        url = {
          launch = "xdg-open \${url}";
          label-letters = "sadfjklewcmpgh";
          osc8-underline = "url-mode";
          protocols = "http, https, ftp, ftps, file";
          uri-characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_.,~:;/?#@!$&%*+=\"'()[]";
        };

        cursor = {
          style = "beam";
          beam-thickness = 1;
          color = "282a36 f8f8f2";
        };

        colors = {
          foreground = "f8f8f2";
          background = "282a36";
          regular0 = "000000"; # black
          regular1 = "ff5555"; # red
          regular2 = "50fa7b"; # green
          regular3 = "f1fa8c"; # yellow
          regular4 = "bd93f9"; # blue
          regular5 = "ff79c6"; # magenta
          regular6 = "8be9fd"; # cyan
          regular7 = "bfbfbf"; # white
          bright0 = "4d4d4d"; # bright black
          bright1 = "ff6e67"; # bright red
          bright2 = "5af78e"; # bright green
          bright3 = "f4f99d"; # bright yellow
          bright4 = "caa9fa"; # bright blue
          bright5 = "ff92d0"; # bright magenta
          bright6 = "9aedfe"; # bright cyan
          bright7 = "e6e6e6"; # bright white
          # foreground = "cdd6f4"; # Text
          # background = "1e1e2e"; # Base
          # regular0 = "45475a"; # Surface 1
          # regular1 = "f38ba8"; # red
          # regular2 = "a6e3a1"; # green
          # regular3 = "f9e2af"; # yellow
          # regular4 = "89b4fa"; # blue
          # regular5 = "f5c2e7"; # pink
          # regular6 = "94e2d5"; # teal
          # regular7 = "bac2de"; # Subtext 1
          # bright0 = "585b70"; # Surface 2
          # bright1 = "f38ba8"; # red
          # bright2 = "a6e3a1"; # green
          # bright3 = "f9e2af"; # yellow
          # bright4 = "89b4fa"; # blue
          # bright5 = "f5c2e7"; # pink
          # bright6 = "94e2d5"; # teal
          # bright7 = "a6adc8"; # Subtext 0

          alpha = 0.9;
        };
      };
    };
  };
}

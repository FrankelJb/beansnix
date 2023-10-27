{ config
, lib
, options
, pkgs
, ...
}:
let
  inherit (lib) types mkIf;
  inherit (lib.internal) mkBoolOpt mkOpt;

  cfg = config.beansnix.desktop.addons.alacritty;
in
{
  options.beansnix.desktop.addons.alacritty = with types; {
    enable = mkBoolOpt false "Whether to enable alacritty.";
    font = mkOpt str "FiraCode Nerd Font" "Font to use for alacritty.";
  };

  config = mkIf cfg.enable {
    programs.alacritty = {
      enable = true;
      package = pkgs.alacritty;

      settings =
        {
          window = {
            dimensions = {
              columns = 0;
              lines = 0;
            };

            padding = {
              x = 10;
              y = 10;
            };

            dynamic_padding = true;
            dynamic_title = true;
            opacity = 0.98;
          };

          font = {
            size = 12.0;

            offset = {
              x = 0;
              y = 0;
            };

            glyph_offset = {
              x = 0;
              y = 1;
            };

            normal = {
              family = cfg.font;
            };
            bold = {
              family = cfg.font;
              style = "Bold";
            };
            italic = {
              family = cfg.font;
              style = "italic";
            };
            bold_italic = {
              family = cfg.font;
              style = "bold_italic";
            };
          };

          cursor = {
            style = {
              shape = "Block";
              blinking = "Off";
            };
          };

          mouse = {
            hide_when_typing = true;
          };

          import = [
            (pkgs.fetchurl {
              url = "https://github.com/alacritty/alacritty-theme/raw/master/themes/dracula.yaml";
              hash = "sha256-GtWmYeT7+fhJ90yz0EnxeNnN3Uq/y5Pi8CTWiSIqfDg=";
            })
          ];
        }
        // lib.optionalAttrs
          pkgs.stdenv.isLinux
          { window.decorations = "None"; }
        // lib.optionalAttrs
          pkgs.stdenv.isDarwin
          { window.decorations = "Buttonless"; };
    };
  };
}

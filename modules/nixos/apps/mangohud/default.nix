{ config
, lib
, options
, pkgs
, ...
}:
let
  inherit (lib) mkIf literalExpression;
  inherit (lib.internal) mkBoolOpt;

  cfg = config.beansnix.apps.mangohud;
in
{
  options.beansnix.apps.mangohud = {
    enable = mkBoolOpt false "Whether or not to enable mangohud.";
  };

  config = mkIf cfg.enable {
    # environment.systemPackages = with pkgs; [mangohud];
    beansnix.home.extraOptions = {
      programs.mangohud = {
        enable = true;
        package = pkgs.mangohud;
        enableSessionWide = true;
        settings = literalExpression ''
          {
            output_folder = ~/Documents/mangohud/;
            full = true;
          }
        '';
      };
    };
  };
}

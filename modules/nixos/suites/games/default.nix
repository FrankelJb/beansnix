{ config
, lib
, options
, pkgs
, ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt enabled;

  cfg = config.beansnix.suites.games;
in
{
  options.beansnix.suites.games = {
    enable =
      mkBoolOpt false "Whether or not to enable common games configuration.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      bottles
      gamescope
      lutris
      proton-caller
      protontricks
      protonup-ng
      protonup-qt
    ];

    beansnix = {
      apps = {
        gamemode = enabled;
        # mangohud = enabled;
        steam = enabled;
      };

      cli-apps = {
        wine = enabled;
      };
    };
  };
}

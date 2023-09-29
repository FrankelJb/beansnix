{ config
, lib
, options
, pkgs
, ...
}:
let
  inherit (lib) mkIf getExe;
  inherit (lib.internal) mkBoolOpt;

  cfg = config.beansnix.apps.discord;
in
{
  options.beansnix.apps.discord = {
    enable = mkBoolOpt false "Whether or not to enable Discord.";
    canary.enable = mkBoolOpt false "Whether or not to enable Discord Canary.";
    firefox.enable =
      mkBoolOpt false
        "Whether or not to enable the Firefox version of Discord.";
  };

  config = mkIf cfg.enable {
    beansnix.home.configFile = {
      "BetterDiscord/themes/catppuccin-macchiato.theme.css".source = ./catppuccin-macchiato.theme.css;
    };

    environment.systemPackages =
      lib.optional cfg.enable pkgs.discord
      ++ lib.optional cfg.canary.enable pkgs.beansnix.discord
      ++ lib.optional cfg.firefox.enable pkgs.beansnix.discord-firefox;

    system.userActivationScripts = {
      postInstall = ''
        echo "Running betterdiscord install"
        source ${config.system.build.setEnvironment}
        ${getExe pkgs.betterdiscordctl} install || true
      '';
    };
  };
}

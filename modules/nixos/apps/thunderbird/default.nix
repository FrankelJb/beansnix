{ config
, lib
, options
, pkgs
, ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt;

  cfg = config.beansnix.apps.thunderbird;
in
{
  options.beansnix.apps.thunderbird = {
    enable = mkBoolOpt false "Whether or not to enable thunderbird.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      birdtray
      davmail
      thunderbird
    ];

    beansnix.home.extraOptions = {
      accounts.email.accounts = {
        "${config.beansnix.user.email}" = {
          address = config.beansnix.user.email;
          realName = config.beansnix.user.fullName;
          flavor = "gmail.com";
          primary = true;
        };
      };

      programs.thunderbird = {
        enable = true;
        package = pkgs.thunderbird;

        profiles.${config.beansnix.user.name} = {
          isDefault = true;

          settings = {
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
            "layers.acceleration.force-enabled" = true;
            "gfx.webrender.all" = true;
            "gfx.webrender.enabled" = true;
            "svg.context-properties.content.enabled" = true;
            "browser.display.use_system_colors" = true;
            "browser.theme.dark-toolbar-theme" = true;
          };

          userChrome = ''
            #spacesToolbar,
            #agenda-container,
            #agenda,
            #agenda-toolbar,
            #mini-day-box
            {
              background-color: #24273a !important;
            }
          '';

          # TODO: Bundle extensions
          # TODO: set up accounts
        };
      };
    };
  };
}

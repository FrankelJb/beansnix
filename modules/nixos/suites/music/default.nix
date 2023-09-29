{ config
, lib
, options
, pkgs
, ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt enabled;

  cfg = config.beansnix.suites.music;
in
{
  options.beansnix.suites.music = {
    enable = mkBoolOpt false "Whether or not to enable music configuration.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      ardour
      cadence
      mpd-notification
      mpdevil
      mpdris2
      # ncmpcpp
      spotify
      tageditor
      youtube-music
      pkgs.beansnix.yt-music
    ];

    beansnix = {
      tools = {
        spicetify-cli = enabled;
      };

      user.extraGroups = [ "mpd" ];
    };

    # TODO: ?
    # services.mpd = {
    #   enable = true;
    #   user = config.beansnix.user.name;
    # };
  };
}

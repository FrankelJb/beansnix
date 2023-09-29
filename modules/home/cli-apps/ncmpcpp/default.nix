{ config
, lib
, ...
}:
let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.beansnix.cli-apps.ncmpcpp;
in
{
  options.beansnix.cli-apps.ncmpcpp = {
    enable = mkEnableOption "ncmpcpp";
  };

  config = mkIf cfg.enable {
    programs.ncmpcpp = {
      enable = true;
      mpdMusicDir = config.beansnix.services.mpd.musicDirectory;
    };
  };
}

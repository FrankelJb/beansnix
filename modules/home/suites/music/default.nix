{ config
, lib
, options
, ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt enabled;

  cfg = config.beansnix.suites.music;
in
{
  options.beansnix.suites.music = {
    enable =
      mkBoolOpt false "Whether or not to enable common music configuration.";
  };

  config = mkIf cfg.enable {
    beansnix = {
      cli-apps = {
        ncmpcpp = enabled;
      };

      services = {
        mpd = enabled;
      };
    };
  };
}

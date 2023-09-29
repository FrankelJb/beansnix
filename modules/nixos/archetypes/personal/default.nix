{ config
, lib
, options
, ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt enabled;

  cfg = config.beansnix.archetypes.personal;
in
{
  options.beansnix.archetypes.personal = {
    enable =
      mkBoolOpt false "Whether or not to enable the personal archetype.";
  };

  config = mkIf cfg.enable {
    beansnix = {
      suites = {
        art = enabled;
        common = enabled;
        music = enabled;
        photo = enabled;
        social = enabled;
        video = enabled;
      };
    };
  };
}

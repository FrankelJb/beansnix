{ config
, lib
, options
, ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt enabled;

  cfg = config.beansnix.archetypes.server;
in
{
  options.beansnix.archetypes.server = {
    enable =
      mkBoolOpt false "Whether or not to enable the server archetype.";
  };

  config = mkIf cfg.enable {
    beansnix = {
      suites = {
        common = enabled;
      };
    };
  };
}

{ config
, lib
, options
, ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt enabled;

  cfg = config.beansnix.suites.vm;
in
{
  options.beansnix.suites.vm = {
    enable =
      mkBoolOpt false
        "Whether or not to enable common vm configuration.";
  };

  config = mkIf cfg.enable {
    beansnix = {
      services = {
        spice-vdagentd = enabled;
        spice-webdav = enabled;
      };
    };
  };
}

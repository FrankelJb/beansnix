{ config
, lib
, options
, ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt;
  cfg = config.beansnix.tools.wakatime;
in
{

  options.beansnix.tools.wakatime = {
    enable = mkBoolOpt false "Whether or not to enable wakatime.";
  };

  # TODO: remove module
  config = mkIf cfg.enable {
    sops.secrets.wakatime = {
      sopsFile = ../../../../secrets/beans/default.json;
      path = "${config.home.homeDirectory}/.wakatime.cfg";
    };
  };
}

{ config
, lib
, options
, pkgs
, ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt;

  cfg = config.beansnix.cli-apps.wshowkeys;
in
{
  options.beansnix.cli-apps.wshowkeys = {
    enable = mkBoolOpt false "Whether or not to enable wshowkeys.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ wshowkeys ];

    beansnix.user.extraGroups = [ "input" ];
  };
}

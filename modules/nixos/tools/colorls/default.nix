{ config
, lib
, options
, pkgs
, ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt;

  cfg = config.beansnix.tools.colorls;
in
{
  options.beansnix.tools.colorls = {
    enable = mkBoolOpt false "Whether or not to enable colorls.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      colorls
    ];

    beansnix.home.extraOptions.home.shellAliases = {
      lc = "colorls --sd";
      lcg = "lc --gs";
      lcl = "lc -1";
      lclg = "lc -1 --gs";
      lcu = "colorls -U";
      lclu = "colorls -U -1";
    };
  };
}

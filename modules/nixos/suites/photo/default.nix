{ config
, lib
, options
, pkgs
, ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt;

  cfg = config.beansnix.suites.photo;
in
{
  options.beansnix.suites.photo = {
    enable = mkBoolOpt false "Whether or not to enable photo configuration.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      digikam
      gwenview
    ];
  };
}

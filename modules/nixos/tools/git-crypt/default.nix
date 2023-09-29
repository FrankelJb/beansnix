{ config
, lib
, options
, pkgs
, ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt;

  cfg = config.beansnix.tools.git-crypt;
in
{
  options.beansnix.tools.git-crypt = {
    enable = mkBoolOpt false "Whether or not to enable git-crypt.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      git-crypt
    ];
  };
}

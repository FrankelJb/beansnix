{ config
, lib
, options
, pkgs
, ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt;

  cfg = config.beansnix.tools.comma;
in
{
  options.beansnix.tools.comma = {
    enable = mkBoolOpt false "Whether or not to enable comma.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      comma
      beansnix.nix-update-index
    ];

    beansnix.home.extraOptions = {
      programs.nix-index.enable = true;
    };
  };
}

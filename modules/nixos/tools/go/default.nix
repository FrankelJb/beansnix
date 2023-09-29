{ config
, lib
, options
, pkgs
, ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt;

  cfg = config.beansnix.tools.go;
in
{
  options.beansnix.tools.go = {
    enable = mkBoolOpt false "Whether or not to enable Go support.";
  };

  config = mkIf cfg.enable {
    environment = {
      sessionVariables = {
        GOPATH = "$HOME/work/go";
      };

      systemPackages = with pkgs; [
        go
        gopls
      ];
    };
  };
}

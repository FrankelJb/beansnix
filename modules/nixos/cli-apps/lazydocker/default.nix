{ config
, lib
, options
, pkgs
, ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt;

  cfg = config.beansnix.cli-apps.lazydocker;
in
{
  options.beansnix.cli-apps.lazydocker = {
    enable = mkBoolOpt false "Whether or not to enable lazydocker.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ lazydocker ];

    beansnix.home = {
      extraOptions = {
        home.shellAliases = {
          # #
          # Docker aliases
          # #
          dcd = "docker-compose down";
          dcu = "docker-compose up -d";
          dim = "docker images";
          dps = "docker ps";
          dpsa = "docker ps -a";
          dsp = "docker system prune --all";
        };
      };
    };
  };
}

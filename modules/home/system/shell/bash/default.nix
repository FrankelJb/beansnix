{ config
, lib
, options
, ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt;

  cfg = config.beansnix.system.shell.bash;
in
{
  options.beansnix.system.shell.bash = {
    enable = mkBoolOpt false "Whether to enable bash.";
  };

  config = mkIf cfg.enable {
    programs.bash = {
      enable = true;

    };
  };
}


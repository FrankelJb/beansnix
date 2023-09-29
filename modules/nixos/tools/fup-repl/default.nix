{ lib
, pkgs
, config
, ...
}:
let
  inherit (lib) mkIf getExe';
  inherit (lib.internal) mkBoolOpt;

  cfg = config.beansnix.tools.fup-repl;

  fup-repl = pkgs.writeShellScriptBin "fup-repl" ''
    ${getExe' pkgs.fup-repl "repl"} ''${@}
  '';
in
{
  options.beansnix.tools.fup-repl = {
    enable = mkBoolOpt false "Whether to enable fup-repl or not";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ fup-repl ];
  };
}

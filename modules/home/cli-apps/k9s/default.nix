{ config
, lib
, options
, pkgs
, ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt;

  cfg = config.beansnix.cli-apps.k9s;

  fromYAML = f:
    let
      jsonFile =
        pkgs.runCommand "in.json"
          {
            nativeBuildInputs = [ pkgs.jc ];
          } ''
          jc --yaml < "${f}" > "$out"
        '';
    in
    builtins.elemAt (builtins.fromJSON (builtins.readFile jsonFile)) 0;
in
{
  options.beansnix.cli-apps.k9s = {
    enable = mkBoolOpt false "Whether or not to enable k9s.";
  };

  config = mkIf cfg.enable {
    programs.k9s = {
      enable = true;
      package = pkgs.k9s;

      skin = fromYAML ./themes/macchiato.yml;
    };
  };
}

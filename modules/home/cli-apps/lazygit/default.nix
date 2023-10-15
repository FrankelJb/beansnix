{
  config,
  lib,
  options,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt;

  cfg = config.beansnix.cli-apps.lazygit;

  fromYAML = f: let
    jsonFile =
      pkgs.runCommand "lazygit yaml to attribute set"
      {
        nativeBuildInputs = [pkgs.jc];
      } ''
        jc --yaml < "${f}" > "$out"
      '';
  in
    builtins.elemAt (builtins.fromJSON (builtins.readFile jsonFile)) 0;
in {
  options.beansnix.cli-apps.lazygit = {
    enable = mkBoolOpt false "Whether or not to enable lazygit.";
  };

  config = mkIf cfg.enable {
    programs.lazygit = {
      enable = true;

      settings = {
        gui = fromYAML (pkgs.catppuccin + "/lazygit/themes/macchiato-blue.yml");
      };
    };

    home.shellAliases = {
      lg = "lazygit";
    };
  };
}

{
  config,
  lib,
  options,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt enabled;

  cfg = config.beansnix.suites.development;
in {
  options.beansnix.suites.development = {
    enable =
      mkBoolOpt false
      "Whether or not to enable common development configuration.";
    dockerEnable =
      mkBoolOpt false
      "Whether or not to enable docker development configuration.";
  };

  config = mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        alejandra
        cpplint
        deadnix
        dnsutils
        lazydocker
        rnix-lsp
        onefetch
        ueberzugpp
        statix
      ];

      shellAliases = {
        prefetch-sri = "nix store prefetch-file $1";
      };
    };

    beansnix = {
      apps = {
        vscodium = enabled;
      };

      cli-apps = {
        lazydocker.enable = cfg.dockerEnable;
        lazygit = enabled;
        neovim = {
          enable = true;
          default = true;
        };
        starship = enabled;
      };

      tools = {
        oh-my-posh = enabled;
      };
    };
  };
}

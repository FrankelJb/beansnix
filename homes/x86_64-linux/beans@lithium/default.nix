{ lib
, config
, ...
}:
let
  inherit (lib.internal) enabled;
in
{
  beansnix = {
    user = {
      enable = true;
      inherit (config.snowfallorg.user) name;
    };

    cli-apps = {
      home-manager = enabled;
    };

    suites = {
      common = enabled;
      development = enabled;
    };

    tools = {
      git = enabled;
    };
  };

  home.shellAliases = {
    nixcfg = "nvim ~/.config/.dotfiles/dots/nixos/flake.nix";
  };

  home.stateVersion = "21.11";
}

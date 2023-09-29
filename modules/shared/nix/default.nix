{ config
, lib
, options
, pkgs
, ...
}:
let
  inherit (lib) types mkIf;
  inherit (lib.internal) mkBoolOpt mkOpt;
  cfg = config.beansnix.nix;
in
{
  options.beansnix.nix = with types; {
    enable = mkBoolOpt true "Whether or not to manage nix configuration.";
    package = mkOpt package pkgs.nixUnstable "Which nix package to use.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      cachix
      deploy-rs
      nix-index
      nix-prefetch-git
    ];

    nix =
      let
        users = [ "root" config.beansnix.user.name ];
      in
      {
        inherit (cfg) package;

        gc = {
          automatic = true;
          options = "--delete-older-than 30d";
        };

        settings = {
          allowed-users = users;
          auto-optimise-store = true;
          experimental-features = "nix-command flakes";
          http-connections = 50;
          keep-derivations = true;
          keep-outputs = true;
          log-lines = 50;
          sandbox = "relaxed";
          trusted-users = users;
          warn-dirty = false;
          substituters = [
            "https://cache.nixos.org"
            "https://nix-community.cachix.org"
          ];
          trusted-public-keys = [
            "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
            "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          ];
        };


        # flake-utils-plus
        generateNixPathFromInputs = true;
        generateRegistryFromInputs = true;
        linkInputs = true;
      };
  };
}

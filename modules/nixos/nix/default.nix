{ config
, lib
, ...
}:
let
  inherit (lib) mkIf;

  cfg = config.beansnix.nix;
in
{
  imports = [ ../../shared/nix/default.nix ];

  config = mkIf cfg.enable {
    nix = {
      gc = {
        dates = "weekly";
      };

      settings = {
        substituters = [
          "https://anyrun.cachix.org"
          "https://hyprland.cachix.org"
          "https://nix-gaming.cachix.org"
          "https://nixpkgs-wayland.cachix.org"
        ];
        trusted-public-keys = [
          "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
          "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
          "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
          "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
        ];
      };
    };
  };
}

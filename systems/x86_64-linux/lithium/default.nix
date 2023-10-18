{ pkgs
, lib
, ...
}:
let
  inherit (lib.internal) enabled;
in
{
  imports = [ ./hardware.nix ];

  beansnix = {
    user.extraOptions.shell = pkgs.fish;
    nix = enabled;

    archetypes = {
      personal = enabled;
      workstation = enabled;
    };

    desktop = {
      addons = {
        gtk = enabled;
        qt = enabled;
        wallpapers = enabled;
      };
    };

    display-managers = {
      # gdm = {
      #   monitors = ./monitors.xml;
      # };

      # regreet = {
      #   swayOutput = builtins.readFile ./swayOutput;
      # };
    };

    hardware = {
      audio = enabled;
    };

    services = {
      openssh = {
        enable = true;

        authorizedKeys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF8fPfLrRHGNjPx1mtUZg2yoDOykjazv+M2qEB6llmNG"
        ];
      };
    };

    suites = {
      development = {
        enable = true;
        nixEnable = true;
        nodeEnable = true;
        rustEnable = true;
      };
    };

    system = {
      boot = {
        enable = true;
        plymouth = true;
      };

      fonts = enabled;
      locale = enabled;
      networking = enabled;
      time = enabled;
    };
  };

  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?
}

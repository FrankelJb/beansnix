{ config
, pkgs
, lib
, ...
}:
let
  inherit (lib) getExe;
  inherit (lib.internal) enabled;
in
{
  imports = [ ./hardware.nix ];

  beansnix = {
    nix = enabled;

    suites = {
      vm = enabled;
    };

    archetypes = {
      gaming = enabled;
      personal = enabled;
      workstation = enabled;
    };

    desktop = {
      hyprland = {
        enable = true;

        customConfigFiles = {
          "hypr/displays.conf".source = ./hypr/displays.conf;
        };

        customFiles = {
          ".screenlayout/primary.sh".source = pkgs.writeShellApplication {
            name = "beansnix-xorg-primary.sh";
            checkPhase = "";
            text = ''
              ${getExe pkgs.xorg.xrandr} \
              --output XWAYLAND0 --primary --mode 1920x1080 --pos 1420x0 --rotate normal \
              --output XWAYLAND1 --mode 5120x1440 --pos 0x1080 --rotate normal
            '';
          };
        };
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
      bluetooth = enabled;
      nvidia = enabled;
      opengl = enabled;

      rgb = {
        enable = true;
      };

      # storage = {
      #   enable = true;
      #   btrfs = {
      #     enable = true;
      #     autoScrub = true;
      #     dedupe = true;
      #
      #     dedupeFilesystems = [
      #       "nixos"
      #       "BtrProductive"
      #     ];
      #
      #     scrubMounts = [
      #       "/"
      #       "/mnt/steam"
      #     ];
      #   };
      # };
    };

    services = {
      ios = enabled;

      # TODO: enable snapper maybe
      # snapper = {
      #   enable = true;
      #
      #   configs = {
      #     Documents = {
      #       ALLOW_USERS = [ "beans" ];
      #       SUBVOLUME = "/home/beans/Documents";
      #       TIMELINE_CLEANUP = true;
      #       TIMELINE_CREATE = true;
      #     };
      #   };
      # };

      openssh = {
        enable = true;

        authorizedKeys = [
          # TODO: add my own authorizedKeys
        ];

        # TODO: make part of ssh config proper
        extraConfig = ''
          Host server
          User ${config.beansnix.user.name}
          Hostname helium.localdomain
        '';
      };
    };

    security = {
      mullvad = enabled;
    };
    # sops = {
    #   enable = true;
    #   sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    #   defaultSopsFile = ../../../secrets/beansnix/default.yaml;
    # };
    # };

    suites = {
      development = {
        enable = true;
        kubernetesEnable = true;
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

    #   IOMMU Group 24:
    # 	05:00.0 VGA compatible controller [0300]: NVIDIA Corporation GA102 [GeForce RTX 3080] [10de:2206] (rev a1)
    # 	05:00.1 Audio device [0403]: NVIDIA Corporation GA102 High Definition Audio Controller [10de:1aef] (rev a1)
    virtualisation.kvm = {
      enable = true;
      # machineUnits = [ "machine-qemu\\x2d4\\x2dwin11\\x2dGPU.scope" ];
      # platform = "amd";
      # vfioIds = [ "10de:2206" "10de:1aef" ];
    };
  };

  services.xserver = {
    displayManager.defaultSession = "hyprland";
    enable = true;
    # desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
    videoDrivers = [ "nvidia" ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?
}

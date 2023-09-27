# TODO: replace with my hardware
{ pkgs
, modulesPath
, inputs
, ...
}:
let
  inherit (inputs) nixos-hardware;
in
{
  imports = with nixos-hardware.nixosModules; [
    (modulesPath + "/installer/scan/not-detected.nix")
    # NOTE: actually removes gpu from list of devices now so can't use GPU-passthru
    # common-gpu-nvidia-disable
    # common-pc
    # common-pc-ssd
  ];

  ##
  # Desktop VM config
  ##
  boot = {
    extraModulePackages = [];
    kernelModules = ["kvm-intel"];
    kernelPackages = pkgs.linuxPackages_latest;
    kernel.sysctl."kernel.sysrq" = 1;
    kernelParams = [
      "video=DP-3:1440x2160@240"
    ];

    initrd = {
      availableKernelModules = ["vmd" "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod"];
      kernelModules = [];
      # verbose = false;
      luks.devices."system".device = "/dev/disk/by-uuid/fb0b6038-91e3-4573-b91b-0fb584585145";
    };
  };

  fileSystems = {
    "/home" = {
      device = "/dev/disk/by-uuid/74194a1e-7e23-41e9-9985-d4d94ca199a8";
      fsType = "btrfs";
      options = ["subvol=home" "compress=zstd"];
    };

    "/nix" = {
      device = "/dev/disk/by-uuid/74194a1e-7e23-41e9-9985-d4d94ca199a8";
      fsType = "btrfs";
      options = ["subvol=nix" "noatime" "compress=zstd"];
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/C9CC-13C7";
      fsType = "vfat";
    };

    "/data/nvme1" = {
      device = "/dev/disk/by-uuid/7311782f-8aca-4974-94ea-5d5cf0a742f3";
      fsType = "btrfs";
      options = ["rw" "nosuid" "nodev" "ssd" "space_cache=v2" "subvolid=5" "subvol=/" "relatime" "compress=zstd"];
    };
  };

  swapDevices = [
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp5s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlo1.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}

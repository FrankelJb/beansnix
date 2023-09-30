{
  config,
  lib,
  options,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt;
  cfg = config.beansnix.hardware.nvidia;
in {
  options.beansnix.hardware.nvidia = {
    enable =
      mkBoolOpt false
      "Whether or not to enable support for nvidia.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      nvfancontrol
      nvidia-vaapi-driver
      nvtop
      vulkan-tools
    ];
    hardware = {
      nvidia = {
        modesetting.enable = true;
        nvidiaSettings = true;
        open = true;
        package = config.boot.kernelPackages.nvidiaPackages.stable;
        powerManagement.enable = true;
      };
      opengl = {
        enable = true;
        driSupport32Bit = true;
        extraPackages = with pkgs; [nvidia-vaapi-driver];
      };
    };
  };
}

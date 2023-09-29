{ config
, lib
, options
, pkgs
, ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt;

  cfg = config.beansnix.hardware.amdgpu;
in
{
  options.beansnix.hardware.amdgpu = {
    enable =
      mkBoolOpt false
        "Whether or not to enable support for amdgpu.";
  };

  config = mkIf cfg.enable {
    # hardware.amdgpu.amdvlk = true;

    environment.systemPackages = with pkgs; [
      radeontop
      vulkan-tools
    ];

    environment.variables = {
      # VAAPI and VDPAU config for accelerated video.
      # See https://wiki.archlinux.org/index.php/Hardware_video_acceleration
      "VDPAU_DRIVER" = "radeonsi";
      "LIBVA_DRIVER_NAME" = "radeonsi";
    };
  };
}

{ config
, lib
, options
, pkgs
, ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt;

  cfg = config.beansnix.hardware.opengl;
in
{
  options.beansnix.hardware.opengl = {
    enable =
      mkBoolOpt false
        "Whether or not to enable support for opengl.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      libva-utils
      vdpauinfo
    ];

    hardware.opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        vaapiVdpau
        libvdpau-va-gl
        libva
        libvdpau
        libdrm
      ]; #++ lib.optional config.beansnix.hardware.amdgpu.enable pkgs.mesa-vdpau;
    };
  };
}

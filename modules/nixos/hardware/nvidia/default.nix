{ config
, lib
, options
, pkgs
, ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt;
  cfg = config.beansnix.hardware.nvidia;
in
{
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
  };
}

{ config
, lib
, options
, pkgs
, ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt enabled;

  cfg = config.beansnix.suites.emulation;
in
{
  options.beansnix.suites.emulation = {
    enable =
      mkBoolOpt false "Whether or not to enable emulation configuration.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      cemu
      emulationstation
      mame
      melonDS
      mgba
      mupen64plus
      nestopia
      pcsx2
      pcsxr
      retroarch
      rpcs3
      snes9x
      xemu
      yuzu-early-access
    ];

    beansnix = {
      apps = {
        dolphin = enabled;
        retroarch = enabled;
      };
    };
  };
}

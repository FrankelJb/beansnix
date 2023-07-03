{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.khanelinix.apps.iterm2;
in
{
  options.khanelinix.apps.iterm2 = with types; {
    enable = mkBoolOpt false "Whether or not to enable iTerm2.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      iterm2
    ];
  };
}

{ config
, lib
, options
, inputs
, ...
}:
let
  inherit (lib) mkIf types;
  inherit (lib.internal) mkBoolOpt mkOpt;
  inherit (inputs) sops-nix;

  cfg = config.beansnix.security.sops;
in
{
  # NOTE: Needed to be imported here otherwise wouldn't work
  imports = [
    sops-nix.homeManagerModules.sops
  ];

  options.beansnix.security.sops = with types; {
    enable = mkBoolOpt false "Whether to enable sops.";
    defaultSopsFile = mkOpt path null "Default sops file.";
    sshKeyPaths = mkOpt (listOf path) [ ] "SSH Key paths to use.";
  };

  config = mkIf cfg.enable {
    sops = {
      inherit (cfg) defaultSopsFile;
      defaultSopsFormat = "json";

      age = {
        generateKey = true;
        keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
        sshKeyPaths = [ "${config.home.homeDirectory}/.ssh/id_ed25519" ] ++ cfg.sshKeyPaths;
      };

      secrets = {
        nix = {
          sopsFile = ../../../../secrets/khaneliman/default.json;
          path = "${config.home.homeDirectory}/.config/nix/nix.conf";
        };

        wakatime = {
          sopsFile = ../../../../secrets/khaneliman/default.json;
          path = "${config.home.homeDirectory}/.wakatime.cfg";
        };
      };
    };
  };
}

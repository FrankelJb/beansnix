{ config
, lib
, options
, ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt enabled;

  cfg = config.beansnix.apps._1password;
in
{
  options.beansnix.apps._1password = {
    enable = mkBoolOpt false "Whether or not to enable 1password.";
  };

  config = mkIf cfg.enable {
    programs = {
      _1password = enabled;
      _1password-gui = {
        enable = true;

        polkitPolicyOwners = [ config.beansnix.user.name ];
      };

      ssh.extraConfig = ''
        Host *
          AddKeysToAgent yes
          IdentityAgent ~/.1password/agent.sock
      '';
    };
  };
}

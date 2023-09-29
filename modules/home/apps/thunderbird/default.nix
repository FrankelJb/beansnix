{ config
, lib
, ...
}:
let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.beansnix.apps.thunderbird;
in
{
  options.beansnix.apps.thunderbird = {
    enable = mkEnableOption "thunderbird";
  };

  config = mkIf cfg.enable {
    # TODO: set up accounts
    accounts.email.accounts = {
      "austin.m.horstman@gmail.com" = {
        address = "austin.m.horstman@gmail.com";
        realName = config.beansnix.user.fullName;
        flavor = "gmail.com";
      };
    };
  };
}

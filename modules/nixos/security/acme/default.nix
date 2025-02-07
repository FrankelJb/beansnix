{ config
, lib
, virtual
, ...
}:
let
  inherit (lib) mkIf mkEnableOption optional;
  inherit (lib.internal) mkOpt;

  cfg = config.beansnix.security.acme;
in
{
  options.beansnix.security.acme = with lib.types; {
    enable = mkEnableOption "default ACME configuration";
    email = mkOpt str config.beansnix.user.email "The email to use.";
    staging = mkOpt bool virtual "Whether to use the staging server or not.";
  };

  config = mkIf cfg.enable {
    security.acme = {
      acceptTerms = true;

      defaults = {
        inherit (cfg) email;

        group = mkIf config.services.nginx.enable "nginx";
        # Reload nginx when certs change.
        reloadServices = optional config.services.nginx.enable "nginx.service";
        server = mkIf cfg.staging "https://acme-staging-v02.api.letsencrypt.org/directory";
      };
    };
  };
}

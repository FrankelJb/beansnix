{ config
, lib
, options
, pkgs
, ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt;

  cfg = config.beansnix.tools.git;
in
{
  options.beansnix.tools.git = {
    enable = mkBoolOpt false "Whether or not to install and configure git.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      bfg-repo-cleaner
      gh
      git
      git-crypt
      git-filter-repo
      git-lfs
      gitflow
      gitleaks
      gitlint
    ];
  };
}

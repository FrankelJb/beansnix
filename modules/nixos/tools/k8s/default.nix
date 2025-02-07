{ config
, lib
, options
, pkgs
, ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt;

  cfg = config.beansnix.tools.k8s;
in
{
  options.beansnix.tools.k8s = {
    enable =
      mkBoolOpt false "Whether or not to enable common Kubernetes utilities.";
  };

  config = mkIf cfg.enable {
    programs.zsh.shellAliases = {
      k = "kubecolor";
      kc = "kubectx";
      kn = "kubens";
      ks = "kubeseal";
      kubectl = "kubecolor";
    };

    environment.systemPackages = with pkgs; [
      helmfile
      k9s
      kubecolor
      kubectl
      kubectx
      kubelogin
      kubernetes-helm
      kubeseal
    ];
  };
}

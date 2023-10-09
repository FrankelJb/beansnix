{ config
, lib
, options
, pkgs
, ...
}:
let
  inherit (lib) types mkIf;
  inherit (lib.internal) mkBoolOpt mkOpt;

  cfg = config.beansnix.system.networking;
in
{
  options.beansnix.system.networking = with types; {
    enable = mkBoolOpt false "Whether or not to enable networking support";
    hosts =
      mkOpt attrs { }
        "An attribute set to merge with <option>networking.hosts</option>";
    nameServers = mkOpt (listOf str) [ "192.168.1.200" "9.9.9.9" ] "The nameservers to add.";
  };

  config = mkIf cfg.enable {
    beansnix.user.extraGroups = [ "networkmanager" ];

    networking = {
      hosts =
        {
          "127.0.0.1" = [ "local.test" ] ++ (cfg.hosts."127.0.0.1" or [ ]);
        }
        // cfg.hosts;
      nameservers = cfg.nameServers;

      networkmanager = {
        enable = true;

        connectionConfig = {
          mdns = "yes";
        };

        dhcp = "internal";
        insertNameservers = cfg.nameServers;

        plugins = with pkgs; [
          networkmanager-l2tp
          networkmanager-openvpn
          networkmanager-sstp
          networkmanager-vpnc
        ];
      };

      search = [ ];
    };

    # Fixes an issue that normally causes nixos-rebuild to fail.
    # https://github.com/NixOS/nixpkgs/issues/180175
    systemd.services.NetworkManager-wait-online.enable = false;
  };
}

{ config
, lib
, options
, pkgs
, ...
}:
let
  inherit (lib) types mkAliasDefinitions;
  inherit (lib.internal) mkOpt;
in
{

  options.beansnix.home = with types; {
    configFile =
      mkOpt attrs { }
        "A set of files to be managed by home-manager's <option>xdg.configFile</option>.";
    extraOptions = mkOpt attrs { } "Options to pass directly to home-manager.";
    file =
      mkOpt attrs { }
        "A set of files to be managed by home-manager's <option>home.file</option>.";
  };

  config = {
    environment.systemPackages = [
      pkgs.home-manager
    ];

    beansnix.home.extraOptions = {
      home.file = mkAliasDefinitions options.beansnix.home.file;
      home.stateVersion = config.system.stateVersion;
      xdg.configFile = mkAliasDefinitions options.beansnix.home.configFile;
      xdg.enable = true;
    };

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;

      users.${config.beansnix.user.name} =
        mkAliasDefinitions options.beansnix.home.extraOptions;
    };
  };
}

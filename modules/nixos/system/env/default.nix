{ options
, config
, lib
, ...
}:
with lib;
with lib.internal; let
  cfg = config.khanelinix.system.env;
in
{
  options.khanelinix.system.env = with types;
    mkOption {
      type = attrsOf (oneOf [ str path (listOf (either str path)) ]);
      apply = mapAttrs (_n: v:
        if isList v
        then concatMapStringsSep ":" toString v
        else (toString v));
      default = { };
      description = "A set of environment variables to set.";
    };

  config = {
    environment = {
      sessionVariables = {
        XDG_BIN_HOME = "$HOME/.local/bin";
        XDG_CACHE_HOME = "$HOME/.cache";
        XDG_CONFIG_HOME = "$HOME/.config";
        XDG_DATA_HOME = "$HOME/.local/share";
        XDG_DESKTOP_DIR = "$HOME";
      };
      variables = {
        # Make some programs "XDG" compliant.
        LESSHISTFILE = "$XDG_CACHE_HOME/less.history";
        WGETRC = "$XDG_CONFIG_HOME/wgetrc";
      };
      extraInit =
        concatStringsSep "\n"
          (mapAttrsToList (n: v: ''export ${n}="${v}"'') cfg);
    };
  };
}

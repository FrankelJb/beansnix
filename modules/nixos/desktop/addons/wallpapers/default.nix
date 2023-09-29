{ config
, lib
, options
, pkgs
, ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt;
  inherit (pkgs.beansnix) wallpapers;

  cfg = config.beansnix.desktop.addons.wallpapers;
in
{
  # TODO: shouldn't need to do this this way
  options.beansnix.desktop.addons.wallpapers = {
    enable =
      mkBoolOpt false
        "Whether or not to add wallpapers to ~/.local/share/wallpapers.";
  };

  config = mkIf cfg.enable {
    beansnix.home.file =
      lib.foldl
        (acc: name:
          let
            wallpaper = wallpapers.${name};
          in
          acc
          // {
            ".local/share/wallpapers/catppuccin/${wallpaper.fileName}".source = wallpaper;
          })
        { }
        wallpapers.names;
  };
}

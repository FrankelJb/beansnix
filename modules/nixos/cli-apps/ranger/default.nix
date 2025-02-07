{ config
, lib
, options
, pkgs
, ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt;

  cfg = config.beansnix.cli-apps.ranger;
in
{
  options.beansnix.cli-apps.ranger = {
    enable = mkBoolOpt false "Whether or not to enable ranger.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      ranger

      # scope dependencies
      atool
      bat
      catdoc
      ebook_tools
      elinks
      exiftool
      feh
      ffmpegthumbnailer
      fontforge
      glow
      highlight
      lynx
      mediainfo
      mupdf
      odt2txt
      p7zip
      pandoc
      poppler_utils
      python3Packages.pygments
      transmission
      unrar
      unzip
      w3m
      xclip
      xlsx2csv
    ];
  };
}

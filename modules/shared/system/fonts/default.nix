{ config
, lib
, options
, pkgs
, ...
}:
let
  inherit (lib) types mkIf;
  inherit (lib.internal) mkBoolOpt mkOpt enabled;

  cfg = config.beansnix.system.fonts;
in
{
  options.beansnix.system.fonts = with types; {
    enable = mkBoolOpt false "Whether or not to manage fonts.";
    fonts = with pkgs;
      mkOpt (listOf package) [
        google-fonts
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        noto-fonts-emoji
        roboto
        (nerdfonts.override { fonts = [ "JetBrainsMono" "FiraCode" ]; })
      ] "Custom font packages to install.";
    default = mkOpt types.str "Liga SFMono Nerd Font" "Default font name";
    # user defined fonts
    # the reason there's Noto Color Emoji everywhere is to override DejaVu's
    # B&W emojis that would sometimes show instead of some Color emojis
    # fontconfig.defaultFonts = {
    #   serif = [ "Roboto Serif" "Noto Color Emoji" ];
    #   sansSerif = [ "Roboto" "Noto Color Emoji" ];
    #   monospace = [ "JetBrainsMono Nerd Font" "Noto Color Emoji" ];
    #   emoji = [ "Noto Color Emoji" ];
    # };
  };

  config = mkIf cfg.enable {
    environment.variables = {
      # Enable icons in tooling since we have nerdfonts.
      LOG_ICONS = "true";
    };

    fonts = {
      fontDir = enabled;
    };
  };
}

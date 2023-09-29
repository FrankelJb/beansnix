{ pkgs
, config
, ...
}: {
  # Define an output to generate the final configuration file
  config = {
    beansnix.home.configFile = {
      "hypr/polish.conf".source = pkgs.writeTextFile {
        name = "polish.conf";
        text = ''
          # ░█▀█░█▀█░█░░░▀█▀░█▀▀░█░█
          # ░█▀▀░█░█░█░░░░█░░▀▀█░█▀█
          # ░▀░░░▀▀▀░▀▀▀░▀▀▀░▀▀▀░▀░▀

          # ░▀█▀░█░█░█▀▀░█▄█░█▀▀
          # ░░█░░█▀█░█▀▀░█░█░█▀▀
          # ░░▀░░▀░▀░▀▀▀░▀░▀░▀▀▀

          hyprctl setcursor ${config.beansnix.desktop.addons.gtk.cursor.name} 32
        '';
      };
    };
  };
}

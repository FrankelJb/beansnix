_: final: prev: {
  beansnix =
    (prev.beansnix or { })
    // {
      pocketcasts = prev.makeDesktopItem {
        name = "Pocketcasts";
        desktopName = "Pocketcasts";
        genericName = "It’s smart listening, made simple.";
        exec = ''
          ${prev.lib.getExe final.firefox} "https://play.pocketcasts.com/podcasts?beansnix.app=true"'';
        icon = ./icon.svg;
        type = "Application";
        categories = [ "Network" "Feed" "AudioVideo" "Audio" "Player" ];
        terminal = false;
      };
    };
}

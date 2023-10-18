{ config
, lib
, pkgs
, ...
}:
let
  inherit (lib) mkIf getExe getExe';

  cfg = config.beansnix.desktop.hyprland;

  hypr_socket_watch_dependencies = with pkgs; [
    coreutils
    gnused
  ];
in
{
  config =
    mkIf cfg.enable
      {
        systemd.user.services.hypr_socket_watch = {
          Install.WantedBy = [ "hyprland-session.target" ];

          Unit = {
            Description = "Hypr Socket Watch Service";
            PartOf = [ "graphical-session.target" ];
          };

          Service = {
            Environment = "PATH=/run/wrappers/bin:${lib.makeBinPath hypr_socket_watch_dependencies}";
            ExecStart = "${getExe pkgs.beansnix.hypr_socket_watch}";
            Restart = "on-failure";
          };
        };

        wayland.windowManager.hyprland = {
          settings = {
            exec-once = [
              # ░█▀█░█▀█░█▀█░░░█▀▀░▀█▀░█▀█░█▀▄░▀█▀░█░█░█▀█
              # ░█▀█░█▀▀░█▀▀░░░▀▀█░░█░░█▀█░█▀▄░░█░░█░█░█▀▀
              # ░▀░▀░▀░░░▀░░░░░▀▀▀░░▀░░▀░▀░▀░▀░░▀░░▀▀▀░▀░░

              # Startup background apps
              "${pkgs.libsForQt5.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1 &"
              "${getExe pkgs.hyprpaper}"
              "command -v ${getExe pkgs.cliphist} && wl-paste --type text --watch cliphist store" #Stores only text data
              "command -v ${getExe pkgs.cliphist} && wl-paste --type image --watch cliphist store" #Stores only image data

              # Startup apps that have rules for organizing them
              "[workspace special silent] ${getExe pkgs.kitty} --class scratchpad" # Spawn scratchpad terminal
              "[workspace special silent] ${getExe pkgs.kitty} --class scratchpad" # Spawn scratchpad terminal
              "${getExe pkgs.firefox}"
              "[silent] ${getExe' pkgs.signal-desktop "signal-desktop"}"

              "${getExe pkgs.virt-manager}"
            ];
          };
        };
      };
}

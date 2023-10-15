{ config
, lib
, ...
}:
let
  inherit (lib) mkIf getExe;
  cfg = config.beansnix.desktop.hyprland;
in
{
  config =
    mkIf cfg.enable
      {
        wayland.windowManager.hyprland = {
          settings = {
            bind =
              [
                # ░█▀█░█▀█░█▀█░░░█░░░█▀█░█░█░█▀█░█▀▀░█░█░█▀▀░█▀▄░█▀▀
                # ░█▀█░█▀▀░█▀▀░░░█░░░█▀█░█░█░█░█░█░░░█▀█░█▀▀░█▀▄░▀▀█
                # ░▀░▀░▀░░░▀░░░░░▀▀▀░▀░▀░▀▀▀░▀░▀░▀▀▀░▀░▀░▀▀▀░▀░▀░▀▀▀
                "$mainMod, RETURN, exec, $term"
                "SUPER_SHIFT, RETURN, exec, $term --title floating_term --single-instance"
                "SUPER_ALT, T, exec, alacritty"
                "$mainMod, Q, killactive,"
                "SUPER_SHIFT, P, exec, hyprpicker -a && (convert -size 32x32 xc:$(wl-paste) /tmp/color.png && notify-send \"Color Code:\" \"$(wl-paste)\" -h \"string:bgcolor:$(wl-paste)\" --icon /tmp/color.png -u critical -t 4000)"
                "$mainMod, B, exec, $browser"
                "$mainMod, E, exec, $term ranger"
                "SUPER_SHIFT, E, exec, $explorer"
                "$mainMod, SPACE, exec, $launcher"
                "SUPER_SHIFT, SPACE, exec, $launcher_alt"
                "$mainMod, A, exec, $launchpad"
                "$mainMod, Escape, exec, ${getExe config.programs.wlogout.package} -c 5 -r 5 -p layer-shell"
                # "$mainMod, L, exec, ${getExe config.programs.swaylock.package} --grace 0 --fade-in 0"
                "$mainMod, T, exec, $term btop"
                "$mainMod, N, exec, swaync-client -t -sw"
                # "SUPER, V, clipman pick -t rofi
                "$mainMod, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
                "$mainMod, W, exec, $looking-glass"

                # ░█▀▀░█░█░█▀▀░▀█▀░█▀▀░█▄█
                # ░▀▀█░░█░░▀▀█░░█░░█▀▀░█░█
                # ░▀▀▀░░▀░░▀▀▀░░▀░░▀▀▀░▀░▀
                # "$LHYPER, L, exec, systemctl --user exit"
                # "$LHYPER, L, exit,    "
                # "$RHYPER, R, exec, reboot" # TODO: fix
                # "$RHYPER, P, exec, shutdown" # TODO: fix
                "$LHYPER, T, exec, notify-send 'test left'"
                "$RHYPER, T, exec, notify-send 'test right'"

                # ░█▀▀░█▀▀░█▀▄░█▀▀░█▀▀░█▀█░█▀▀░█░█░█▀█░▀█▀
                # ░▀▀█░█░░░█▀▄░█▀▀░█▀▀░█░█░▀▀█░█▀█░█░█░░█░
                # ░▀▀▀░▀▀▀░▀░▀░▀▀▀░▀▀▀░▀░▀░▀▀▀░▀░▀░▀▀▀░░▀░
                # Pictures
                ", Print, exec, file=\"$(xdg-user-dir PICTURES)/screenshots/$(date +'%Y%m%d_%H%M%S.png')\" && grim \"$file\" && notify-send --icon \"$file\" 'Screenshot Saved'"
                "SHIFT, Print, exec, file=\"$(xdg-user-dir PICTURES)/screenshots/$(date +'%Y%m%d_%H%M%S.png')\" && grim -g \"$(slurp)\" \"$file\" && notify-send --icon \"$file\" 'Screenshot Saved'"
                "SUPER_SHIFT, Print, exec, grim -g \"$(slurp)\" - | swappy -f -"
                "SUPER, Print, exec, grim - | swappy -f -"
                "CONTROL, Print, exec, grimblast copy screen && wl-paste -t image/png | convert png:- /tmp/clipboard.png && notify-send --icon=/tmp/clipboard.png 'Screen copied to clipboard'"
                "SUPER_CTRL, Print, exec, grimblast copy active && wl-paste -t image/png | convert png:- /tmp/clipboard.png && notify-send --icon=/tmp/clipboard.png 'Window copied to clipboard'"
                "SUPER_CTRL_SHIFT, Print, exec, grimblast copy area && wl-paste -t image/png | convert png:- /tmp/clipboard.png && notify-send --icon=/tmp/clipboard.png 'Area copied to clipboard'"
                # Screen recording
                # "SUPER_CTRLALT, Print, exec, record_screen screen"
                # "SUPER_CTRLALTSHIFT, Print, exec, record_screen area"

                # ░█░░░█▀█░█░█░█▀█░█░█░▀█▀
                # ░█░░░█▀█░░█░░█░█░█░█░░█░
                # ░▀▀▀░▀░▀░░▀░░▀▀▀░▀▀▀░░▀░
                "SUPER_ALT, V, togglefloating,"
                "$mainMod, P, pseudo, # dwindle"
                "$mainMod, R, togglesplit, # dwindle"
                "$mainMod, F, fullscreen"
                # "SUPER_SHIFT, V, workspaceopt, allfloat"

                # ░█░█░▀█▀░█▀█░█▀▄░█▀█░█░█
                # ░█▄█░░█░░█░█░█░█░█░█░█▄█
                # ░▀░▀░▀▀▀░▀░▀░▀▀░░▀▀▀░▀░▀
                # move focus
                "$mainMod, H, movefocus, l"
                "$mainMod, J, movefocus, d"
                "$mainMod, K, movefocus, u"
                "$mainMod, L, movefocus, r"

                # Move (vim style)
                "$mainMod CTRL, H, movewindow, l"
                "$mainMod CTRL, L, movewindow, r"
                "$mainMod CTRL, K, movewindow, u"
                "$mainMod CTRL, J, movewindow, d"

                # ░█░█░█▀█░█▀▄░█░█░█▀▀░█▀█░█▀█░█▀▀░█▀▀
                # ░█▄█░█░█░█▀▄░█▀▄░▀▀█░█▀▀░█▀█░█░░░█▀▀
                # ░▀░▀░▀▀▀░▀░▀░▀░▀░▀▀▀░▀░░░▀░▀░▀▀▀░▀▀▀
                # Swipe through existing workspaces with CTRL_ALT + left / right
                # Move to workspace left/right
                "$mainMod, TAB, workspace, m+1"
                "$mainMod SHIFT, TAB, workspace, m-1"

                # Move to workspace left/right
                "CTRL_ALT_SUPER, right, movetoworkspace, +1"
                "CTRL_ALT_SUPER, left, movetoworkspace, -1"

                # Scroll through existing workspaces with CTRL_ALT + scroll
                "CTRL_ALT, mouse_down, workspace, e+1"
                "CTRL_ALT, mouse_up, workspace, e-1"

                # MOVING silently LEFT/RIGHT
                "SUPER_SHIFT, right, movetoworkspacesilent, +1"
                "SUPER_SHIFT, left, movetoworkspacesilent, -1 "

                # Scratchpad
                "SUPER_ALT,grave,movetoworkspace,special"
                "SUPER,grave,togglespecialworkspace,"

                # ░█▄█░█▀█░█▀█░▀█▀░▀█▀░█▀█░█▀▄
                # ░█░█░█░█░█░█░░█░░░█░░█░█░█▀▄
                # ░▀░▀░▀▀▀░▀░▀░▀▀▀░░▀░░▀▀▀░▀░▀
                # simple movement between monitors
                "SUPER_CTRL, up, focusmonitor, u"
                "SUPER_CTRL, down, focusmonitor, d"
                "SUPER_CTRL, left, focusmonitor, l"
                "SUPER_CTRL, right, focusmonitor, r"

                # moving current workspace to monitor
                "SUPER_CTRL_SHIFT,down,movecurrentworkspacetomonitor,d"
                "SUPER_CTRL_SHIFT,up,movecurrentworkspacetomonitor,u"
                "SUPER_CTRL_SHIFT,left,movecurrentworkspacetomonitor,l"
                "SUPER_CTRL_SHIFT,right,movecurrentworkspacetomonitor,r"

                # ░█▄█░█▀▀░█▀▄░▀█▀░█▀█
                # ░█░█░█▀▀░█░█░░█░░█▀█
                # ░▀░▀░▀▀▀░▀▀░░▀▀▀░▀░▀
                ",XF86AudioRaiseVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 2.5%+"
                ",XF86AudioLowerVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 2.5%-"
                ",XF86AudioMute,exec,wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
                ",XF86MonBrightnessUp,exec,light -A 5"
                ",XF86MonBrightnessDown,exec,light -U 5"
                ",XF86AudioMedia,exec,playerctl play-pause"
                ",XF86AudioPlay,exec,playerctl play-pause"
                ",XF86AudioStop,exec,playerctl stop"
                ",XF86AudioPrev,exec,playerctl previous"
                ",XF86AudioNext,exec,playerctl next"
              ]
              # ░█░█░█▀█░█▀▄░█░█░█▀▀░█▀█░█▀█░█▀▀░█▀▀
              # ░█▄█░█░█░█▀▄░█▀▄░▀▀█░█▀▀░█▀█░█░░░█▀▀
              # ░▀░▀░▀▀▀░▀░▀░▀░▀░▀▀▀░▀░░░▀░▀░▀▀▀░▀▀▀
              # Switch workspaces with CTRL_ALT + [0-9]
              ++ (builtins.concatLists (builtins.genList
                (
                  x:
                  let
                    ws =
                      let
                        c = (x + 1) / 10;
                      in
                      builtins.toString (x + 1 - (c * 10));
                  in
                  [
                    "$mainMod, ${ws}, workspace, ${toString (x + 1)}"
                    "$CTRL_ALT_SUPER, ${ws}, movetoworkspace, ${toString (x + 1)}"
                    "$SUPER_SHIFT, ${ws}, movetoworkspacesilent, ${toString (x + 1)}"
                  ]
                )
                10));
            # Move/resize windows with mainMod + LMB/RMB and dragging
            bindm = [
              "$mainMod, mouse:272, movewindow #left click"
              "$mainMod, mouse:273, resizewindow #right click"
            ];
          };
        };
      };
}

# Taken from https://github.com/LunNova/nixos-configs
# 💖 Thank you!
{ writeShellScriptBin
, ...
}:
writeShellScriptBin "volume" ''
  #!/usr/bin/env bash

  # shellcheck source=/dev/null
  source "$(dirname "$0 ")" /utils

  volicons=("" "" "")
  date="$XDG_CACHE_HOME/eww/osd_vol.date"

  vol() {
  wpctl get-volume @DEFAULT_AUDIO_"$1"@ | awk '{print int($2*100)}'
  }
  ismuted() {
  wpctl get-volume @DEFAULT_AUDIO_"$1"@ | rg -qi muted
  echo -n $?
  }
  setvol() {
  wpctl set-volume @DEFAULT_AUDIO_"$1"@ "$(awk -v n="$2" 'BEGIN{print (n / 100)}')"
  }
  setmute() {
  wpctl set-mute @DEFAULT_AUDIO_"$1"@ toggle
  }

  gen_output() {
  if [[ "$event" == *source* ]]; then
  pactl list sources | rg -q
  [ $? -eq 1 ] && in_use=0 || in_use=1
  else
  lvl=$(awk -v n="$(vol "SINK")" 'BEGIN{print int(n/34)}')
  ismuted=$(ismuted "SINK")

  if [ "$ismuted" = 1 ]; then
  icon="\$\{volicons[$lvl]\}"
  else
  icon=""
  fi
  fi
  jaq --null-input -r -c \
  --arg icon "$icon" \
  --arg percent "$(vol "SINK")" \
  --arg mic "$(vol "SOURCE")" \
  --arg in_use "$in_use" \
  '{"icon": $icon, "percent": $percent, "microphone": $mic, "in_use": $in_use}'
  }

  case "$1" in
  "mute")
  if [ "$2" != "SOURCE" ] && [ "$2" != "SINK" ]; then
  echo "Can only mute SINK or SOURCE"
  exit 1
  fi
  setmute "$2"
  ;;

  "setvol")
  if [ "$2" != "SOURCE" ] && [ "$2" != "SINK" ]; then
  echo "Can only set volume for SINK or SOURCE"
  exit 1
  elif [ "$3" -lt 0 ] || [ "$3" -gt 100 ]; then
  echo "Volume must be between 0 and 100"
  exit 1
  fi
  setvol "$2 $3"
  ;;

  "osd")
  osd "$date"
  ;;

  "")
  # initial values
  in_use=0
  last_time=$(get_time_ms)
  gen_output
  osd_handler "osd-volume" &

  # event loop
  pactl subscribe | rg --line-buffered ".*(source|sink).*" | while read -r event; do
  current_time=$(get_time_ms)
  delta=$((current_time - last_time))
  # 50ms debounce
  if [[ $delta -gt 50 ]]; then
  gen_output
  # reset debounce timer
  last_time=$(get_time_ms)
  fi
  done
  ;;

  *) echo "wrong usage" ;;
  esac
''



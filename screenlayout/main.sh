#/bin/bash
# Select the correct screenlayout based on connected outputs and hostname

CONNECTED_OUTPUTS=($(xrandr | grep " connected " | awk '{ print$1 }'))
HOSTNAME=$(hostname)


case $HOSTNAME in
  "Butterfly-2019")
  export MONITOR_1=eDP-1

  DP_1_1_CONNECTED=false
  DP_1_3_CONNECTED=false

    case "${CONNECTED_OUTPUTS[@]}" in *"DP-1-1"*)
        export MONITOR_2=DP-1-1

        DP_1_1_CONNECTED=true
      ;;
    esac

    case "${CONNECTED_OUTPUTS[@]}" in *"DP-1-3"*)
        export MONITOR_3=DP-1-3

        DP_1_3_CONNECTED=true
      ;;
    esac

    if [ $DP_1_1_CONNECTED = true ] && [ $DP_1_3_CONNECTED = true ]; then
      xrandr --output eDP-1 --mode 1920x1080 --pos 3840x0 --rotate normal \
        --output DP-1-1 --primary --mode 1920x1080 --pos 1920x0 --rotate normal \
        --output DP-1-3 --mode 1920x1080 --pos 0x0 --rotate normal
    elif [ $DP_1_1_CONNECTED = true ]
      xrandr --output eDP-1 --mode 1920x1080 --pos 3840x0 --rotate normal \
        --output DP-1-1 --primary --mode 1920x1080 --pos 1920x0 --rotate normal \
    else
      xrandr --output eDP-1 --primary --mode 1920x1080 --pos 3840x0 --rotate normal
    fi
  ;;
esac

#!/bin/bash
# Export all needed variables to environment according to hostname

HOSTNAME=$(hostname)


function set_environment_variables()
{
  case $HOSTNAME in
    "Butterfly-2019")
      export DEFAULT_WALLPAPER_PATH=$HOME/Pictures/Wallpapers/wallpaper_space01.jpg

      ifconfig enxf4a80d17e4fa &> /dev/null
      if [ echo $? > 0 ]; then
        export INTERFACES_MAIN_ETH=enxf4a80d17e4fa
      else
        export INTERFACES_MAIN_ETH=enp4s0
      fi

      export INTERFACES_MAIN_WLAN=wlp5s0
      export HWMON_PATH=/sys/devices/platform/coretemp.0/hwmon/hwmon0/temp1_input
    ;;
  esac
}

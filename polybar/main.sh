#!/bin/bash
# Polybar launch script

HOSTNAME=$(hostname)


killall -q polybar

case $HOSTNAME in
  "Butterfly-2019")
    echo "Lauching polybars" | tee -a /tmp/polybar.log
    polybar top-monitor1 >> /tmp/polybar.log 2>&1 &
    polybar buttom-monitor1 >> /tmp/polybar.log 2>&1 &
    polybar top-monitor2 >> /tmp/polybar.log 2>&1 &
    polybar buttom-monitor2 >> /tmp/polybar.log 2>&1 &
    polybar top-monitor3 >> /tmp/polybar.log 2>&1 &
    polybar buttom-monitor3 >> /tmp/polybar.log 2>&1 &
    echo "Polybars launched"
  ;;
esac

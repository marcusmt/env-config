#!/bin/bash

# github https://github.com/Shringe/dunst-media-control

brightness_step=10
notification_timeout=1000 # in milliseconds

function get_volume {
    pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '[0-9]{1,3}(?=%)' | head -1
}

function get_brightness {
    brightnessctl | grep -oP 'Current brightness: \K\d+'
}

function get_mute {
    pactl get-sink-mute @DEFAULT_SINK@ | grep -Po '(?<=Mute: )(yes|no)'
}

function get_volume_icon {
    volume=$(get_volume)
    mute=$(get_mute)
    if [ "$volume" -eq 0 ] || [ "$mute" == "yes" ] ; then
        volume_icon=" "
    elif [ "$volume" -lt 50 ]; then
        volume_icon=" "
    else
        volume_icon=" "
    fi 
}

function show_volume_notif {
    volume=$(get_volume)
    get_volume_icon

    if [ "$volume" -gt 100 ]; then
        pactl set-sink-volume @DEFAULT_SINK@ 100%
        volume=100
    fi
    
    dunstify -t $notification_timeout -h string:x-dunst-stack-tag:volume_notif -h int:value:$volume "$volume_icon $volume%"
}

function show_brightness_notif {
    brightness=$(get_brightness)
    dunstify -t $notification_timeout -h string:x-dunst-stack-tag:brightness_notif -h int:value:$brightness "󰃟 $brightness%"
}

case $1 in
    volume)
    show_volume_notif
    ;;

    brightness_up)
    upValue=$(($(get_brightness) + $brightness_step))
    brightnessctl -d nvidia_0 set $upValue
    show_brightness_notif
    ;;

    brightness_down)
    downValue=$(($(get_brightness) - $brightness_step))
    brightnessctl -d nvidia_0 set $downValue
    show_brightness_notif
    ;;
esac
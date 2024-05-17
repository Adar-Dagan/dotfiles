#!/bin/sh

while true
do 
    clock=$(date +'%Y-%m-%d %H:%M:%S')

    wifi=$(iwgetid -r | tr -d '\n')
    if [ -z "$wifi" ]; then 
        wifi="Wifi not connected"
    else
        wifi="Wifi: $wifi"
    fi

    volume=$(pamixer --get-volume)
    mute_status=$(pamixer --get-mute)

    if [[ "$mute_status" == "false" ]]; then
        volume="♪: $volume%"
    else
        volume="♪: muted ($volume%)"
    fi

    out=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0)
    battery_info=""
    # Get the battery status
    battery_status=$(echo "$out" | grep 'state:' | awk '{print $2}')

    # Get the battery percentage
    battery_percentage=$(echo "$out" | grep 'percentage:' | awk '{print $2}')

    # Get the remaining time
    remaining_time=$(echo "$out" | grep 'time to empty:' | awk '{print $4, $5}')

    case "$battery_status" in
        "charging")
            battery_info+="⚡ CHR"
            ;;
        "fully-charged")
            battery_info+="☻ FULL"
            ;;
        "pending-charge")
            battery_info+="☻ FULL"
            ;;
        "discharging")
            battery_info+="🔋 BAT"
            ;;
        "unknown")
            battery_info+="? UNK"
            ;;
        *)
            battery_info+="No battery"
            ;;
    esac

    # Build the string
    battery_info+=" $battery_percentage"

    # If the battery is charging or discharging, add the remaining time to the string
    if [[ "$battery_status" == "charging" ]] || [[ "$battery_status" == "discharging" ]]; then
        calculated=$(echo $remaining_time | awk '{print $1}')
        if [[ "$calculated" =~ ^[0-9]{2} ]]; then
            battery_info+=" $remaining_time"
        else
            battery_info+=" Calculating..."
        fi
    fi

    echo -e "$volume | $wifi | $battery_info | $clock"

    # Attempt to sync the updates to full seconds
    # Get the current time and calculate how long until the next full second
    current_time=$(date +%s.%N)
    sleep_time=$(echo "1 - ($current_time - $(date +%s))" | bc)

    # Sleep until the next full second
    sleep $sleep_time
done

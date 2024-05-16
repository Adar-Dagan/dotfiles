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

    out=$(amixer get Master | grep 'Front Left:')
    volume=$(echo $out | awk '{print $5}' | tr -d '[]')
    mute_status=$(echo $out | awk '{print $6}')

    if [[ "$mute_status" == "[on]" ]]; then
        volume="♪: $volume"
    else
        volume="♪: muted ($volume)"
    fi

    out=$(acpi | grep 'Battery 1')
    battery_info=""
    # Get the battery status
    battery_status=$(echo $out | awk -F': ' '{print $2}' | cut -d',' -f1)

    # Get the battery percentage
    battery_percentage=$(echo $out | awk -F', ' '{print $2}')

    # Get the remaining time
    remaining_time=$(echo $out | awk -F', ' '{print $3}')

    case "$battery_status" in
        "Charging")
            battery_info+="⚡ CHR"
            ;;
        "Full")
            battery_info+="☻ FULL"
            ;;
        "Not charging")
            battery_info+="☻ FULL"
            ;;
        "Discharging")
            battery_info+="🔋 BAT"
            ;;
        "Unknown")
            battery_info+="? UNK"
            ;;
        *)
            battery_info+="No battery"
            ;;
    esac

    # Build the string
    battery_info+=" $battery_percentage"

    # If the battery is charging or discharging, add the remaining time to the string
    if [[ "$battery_status" == "Charging" ]] || [[ "$battery_status" == "Discharging" ]]; then
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

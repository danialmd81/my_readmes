#!/bin/bash

# Specify the path to the fan_boost_mode file
fan_boost_mode_file="/sys/devices/platform/asus-nb-wmi/throttle_thermal_policy"

# Variables to store state
previous_mode=""
notification_id_file="/tmp/fan_notification_id"

# Setup cleanup function and trap
cleanup() {
	# Remove notification ID file
	rm -f "$notification_id_file"
	# Kill any remaining inotifywait processes
	pkill -P $$
	exit 0
}

# Set trap for cleanup on SIGTERM and SIGINT
trap cleanup SIGTERM SIGINT

# Function to get the label for a given mode
get_mode_label() {
	case $1 in
	0) echo "Normal Mode" ;;
	1) echo "OverBoost" ;;
	2) echo "Silent Mode" ;;
	*) echo "Unknown Mode" ;;
	esac
}

# Function to check and send a notification if the mode has changed
check_and_send_notification() {
	current_mode=$(cat $fan_boost_mode_file)
	current_label=$(get_mode_label $current_mode)

	if [ "$current_mode" != "$previous_mode" ]; then
		icon_path="$(dirname "$(readlink -f "$0")")/fan"

		# Read the notification ID if it exists
		if [ -f "$notification_id_file" ]; then
			notification_id=$(cat "$notification_id_file")
		else
			notification_id=9876 # Arbitrary unique number
		fi

		# Close the previous notification
		if [ -n "$notification_id" ]; then
			dunstify -C "$notification_id"
		fi
		# Send the notification and save the new ID
		dunstify -p -u normal -i "$icon_path" "Fan Boost Mode Changed" "New mode: $current_label" >"$notification_id_file"

		previous_mode="$current_mode"
	fi
}

# Initial check
check_and_send_notification

# Monitor for changes in the fan_boost_mode file
while true; do
	inotifywait -e modify $fan_boost_mode_file || cleanup
	check_and_send_notification
done

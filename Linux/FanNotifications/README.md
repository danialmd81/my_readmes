# FanNotifications

A simple Bash script to monitor and notify you when your ASUS laptop's fan boost mode changes.  
It uses desktop notifications and plays a system sound when the mode changes.

## Features

- Monitors `/sys/devices/platform/asus-nb-wmi/throttle_thermal_policy` for changes.
- Sends a desktop notification with an icon and the new fan mode.
- Plays the default GNOME notification sound (or fallback sounds).
- Cleans up on exit.

## Requirements

Install the following packages on your Linux system:

- `dunst` (notification daemon)
- `dunstify` (for sending notifications)
- `inotify-tools` (for monitoring file changes)
- `libcanberra-gtk3-module` (for playing GNOME system sounds)  
  **or** `sox` or `alsa-utils` (for `aplay` as a fallback)  
  **or** `pulseaudio-utils` (for `paplay` as a fallback)
- `fan.jpg` icon in the script directory (optional, for notification icon)

## Usage

1. Place `FanNotifications.sh` and `fan.jpg` in the same directory.
2. Make the script executable:

   ```bash
   chmod +x FanNotifications.sh
   ```

3. Run the script with appropriate permissions (may require `sudo` to read the fan mode file):

   ```bash
   ./FanNotifications.sh
   ```

4. **(Optional but recommended)** Add `FanNotifications.sh` to your system's startup applications to run it automatically on login.
   - On most desktop environments, search for "Startup Applications" or "Session and Startup" and add the full to `FanNotifications.sh`.

## Customization

- **Notification Icon:** Replace `fan.jpg` with your preferred icon.
- **Sound:** The script tries to play the default GNOME notification sound. You can change the `sound_path` variable in the script to use a custom sound.

## Notes

- The script is designed for ASUS laptops with the `asus-nb-wmi` kernel module.
- You may need to adjust file paths if your system uses a different location for the fan mode file.

---

#!/bin/bash

wp_dir="/home/user/Pictures/wallpapers"
app_dir="/home/user/Pictures/wp-maker"

# Default value for lockscreen
lockscreen="false"

# Parse command-line options
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --lock) lockscreen="true"; shift ;;  # Set lockscreen to "true" if --lock is present
        *) echo "Unknown option: $1"; exit 1 ;;
    esac
    shift
done

# Use lockscreen variable to change wp_dir if lockscreen is "true"
if [ "$lockscreen" = "true" ]; then
    wp_dir="/home/user/Pictures/wallpapers/lockscreen"
fi

cd $app_dir

# Generate the first wallpaper
"$app_dir/ani-wall.sh"
if [ -f "$app_dir/result.png" ]; then
    source "$app_dir/ani-wall.sh"
    cp "$app_dir/result.png" "$wp_dir/wallpaper_1.png"
    rm "$app_dir/result.png"
    notify-send "Wallpaper 1 set as $image at $random_color" -t 5000
fi

# Generate the second wallpaper
"$app_dir/ani-wall.sh"
if [ -f "$app_dir/result.png" ]; then
    source "$app_dir/ani-wall.sh"
    cp "$app_dir/result.png" "$wp_dir/wallpaper_2.png"
    rm "$app_dir/result.png"
    notify-send "Wallpaper 2 set as $image at $random_color" -t 5000
fi

# Restart the wallpaper service
if [ "$lockscreen" = "true" ]; then
    notify-send "Lockscreen Background has been set." -t 5000
else
    pkill hyprpaper
    notify-send "New wallpapers were set!" -t 5000
    hyprpaper
fi

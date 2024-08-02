#!/bin/bash

# crontab: * * * * * /path/to/autotheme.sha

#https://askubuntu.com/questions/742870/background-not-changing-using-gsettings-from-cron/1437023#1437023
REAL_UID=$(id --real --user)
PID=$(pgrep --euid $REAL_UID gnome-session | head -n 1)
DBUS_SESSION_BUS_ADDRESS=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$PID/environ | cut -d= -f2- | sed -e "s/\x0//g")
export DBUS_SESSION_BUS_ADDRESS

colours=(rosewater flamingo pink mauve red maroon peach yellow green teal sky sapphire blue lavender)
dark=(mocha frappe macchiato)
dim=${dark[$RANDOM % ${#dark[@]}]}
# random colour
colour=${colours[$RANDOM % ${#colours[@]}]}

# from https://sunrisesunset.io/ca/ontario/brampton/
dayTides=$(curl --silent 'https://api.sunrisesunset.io/json?lat=43.68341&lng=-79.76633' | jq -r '.results')

getSunrise() {
    echo "$dayTides" | jq -r .sunrise
}

setTheme() {
    ichooseyou --clear --wallpaper
    if [ "$1" == "day" ] || [ "$1" == "light" ]; then
        echo "Daytime"
        gsettings set org.gnome.desktop.interface color-scheme prefer-light
        gsettings set org.gnome.desktop.interface gtk-theme catppuccin-latte-"$colour"-standard+default
        gsettings set org.gnome.desktop.interface cursor-theme catppuccin-latte-"$colour"-cursors
        ichooseyou --wallpaper --light 0.50
        ichooseyou --slideshow --wallpaper --light 0.50
    elif [ "$1" == "night" ] || [ "$1" == "dark" ]; then
        echo "Nighttime"
        gsettings set org.gnome.desktop.interface color-scheme prefer-dark
        gsettings set org.gnome.desktop.interface gtk-theme "catppuccin-$dim-$colour-standard+default"
        gsettings set org.gnome.desktop.interface cursor-theme "catppuccin-$dim-$colour-cursors"
        ichooseyou --wallpaper --dark 0.50
        ichooseyou --slideshow --wallpaper --dark 0.50
    fi

}

getSunset() {
    echo "$dayTides" | jq -r '.sunset'
}

format="+%T"
sunrise=$(date --date="$(getSunrise)" "$format")
sunset=$(date --date="$(getSunset)" "$format")

time=$(date "$format")

command=$1

if [ "$command" == "day" ] || [ "$command" == "light" ] || [ "$command" == "night" ] || [ "$command" == "dark" ]; then
    setTheme "$command"
elif [ "$time" \> "$sunrise" ] && [ "$time" \< "$sunset" ]; then
    setTheme "day"
else
    setTheme "night"
fi

echo "Current time: $time"
echo "Sunrise: $sunrise"
echo "Sunset: $sunset"

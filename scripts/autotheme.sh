#!/bin/bash
# crontab: s

colours=(rosewater flamingo pink mauve red maroon peach yellow green teal sky sapphire blue lavender)
dark=(mocha frappe macchiato)
dim=${dark[$RANDOM % ${#dark[@]}]}
# random colour
colour=${colours[$RANDOM % ${#colours[@]}]}

# from https://sunrisesunset.io/ca/ontario/brampton/

dayTides=$(curl --silent 'https://api.sunrisesunset.io/json?lat=43.68341&lng=-79.76633' | jq -r '.results')

getSunrise(){
    echo "$dayTides" | jq -r .sunrise
}

getSunset(){
    echo "$dayTides" | jq -r '.sunset'
}

format="+%T"
sunrise=$(date --date="$(getSunrise)" "$format")
sunset=$(date --date="$(getSunset)" "$format")

time=$(date "$format")

if [ "$time" \> "$sunrise" ] && [ "$time" \< "$sunset" ]; then
    echo "Daytime"
    gsettings set org.gnome.desktop.interface color-scheme prefer-light
    gsettings set org.gnome.desktop.interface gtk-theme catppuccin-latte-"$colour"-standard+default
    gsettings set org.gnome.desktop.interface cursor-theme catppuccin-latte-"$colour"-cursors
else
    echo "Nighttime"
    gsettings set org.gnome.desktop.interface color-scheme prefer-dark
    gsettings set org.gnome.desktop.interface gtk-theme "catppuccin-$dim-$colour-standard+default"
    gsettings set org.gnome.desktop.interface cursor-theme "catppuccin-$dim-$colour-cursors"
fi

echo "Current time: $time"
echo "Sunrise: $sunrise"
echo "Sunset: $sunset"

#!/bin/env bash


# https://stackoverflow.com/a/29754866
alias inkcat="deno run --allow-env --allow-read --allow-sys npm:@catppuccin/inkcat"

# https://stackoverflow.com/a/2453056/16929246
# colour=$(inkcat mocha | tail --lines=26 | grep --extended-regexp --invert-match "(text|overlay|surface|base|mantle|crust)" | shuf --head-count=1 | sed -r 's/\<./\U&/g' | tr -d '[:space:]')


themes=("mocha" "frappe" "macchiato" "latte")
colours=(rosewater flamingo pink mauve red maroon peach yellow green teal sky sapphire blue lavender)

# handle non-option arguments
# if [[ $# -ne 2 ]]; then
#     echo "$0: <theme> and <colour> is required."
#     exit 1
# elif [[ $# -eq 1 ]]; then
#     echo "$0: <colour> is required."
#     exit 1
# fi

theme=$1
colour=$2

if [[ -z $theme ]]; then
    darkman=$(darkman get)
    if [[ $darkman == "dark" ]]; then
        theme=$(shuf --echo mocha frappe macchiato --head-count=1)
    else
        theme=latte
    fi
fi

if [[ -z $colour ]]; then
    colour=$(shuf --echo "${colours[@]}" --head-count=1)
fi

for item in "${themes[@]}"; do
    if [[ ${item,,} == "${theme,,}" ]]; then
        echo "$theme theme selected"
        break
    fi
done

for item in "${colours[@]}"; do
    if [[ ${item,,} == "${colour,,}" ]]; then
        echo "with $colour accent colour"
        break
    fi
done

ln -sf "./$theme.gtk.css" ~/.config/palette/style.css

# waybar
pidof waybar && kill -s USR2 $(pidof waybar)

# Capitalized accent colour & theme
colour=$(echo $colour | sed -r 's/\<./\U&/g')


shade=$(if [[ ${theme,,} == "latte" ]]; then echo "light"; else echo "dark"; fi)
theme=$(echo $theme | sed -r 's/\<./\U&/g')


gsettings set org.gnome.desktop.interface color-scheme "prefer-$shade"

shade=$(echo $shade | sed -r 's/\<./\U&/g')

gsettings set org.gnome.desktop.interface gtk-theme "Colloid-$shade-Catppuccin"
gsettings set org.gnome.desktop.interface cursor-theme "$cursorTheme"
gsettings set org.gnome.desktop.interface icon-theme "Colloid-$shade"


ln -sf "/usr/share/themes/Colloid-$shade-Catppuccin/gtk-2.0/gtkrc" "$HOME/.gtkrc-2.0"
ln -sfn "/usr/share/themes/Colloid-$shade-Catppuccin/gtk-3.0/"{assets,gtk.css,gtk-dark.css} "$XDG_CONFIG_HOME/gtk-3.0"
ln -sfn "/usr/share/themes/Colloid-$shade-Catppuccin/gtk-4.0/"{assets,gtk.css,gtk-dark.css} "$XDG_CONFIG_HOME/gtk-4.0"
cp "$XDG_CONFIG_HOME/gtk-3.0/settings.ini" "$XDG_CONFIG_HOME/gtk-3.0/settings.ini.backup"
# awk -v theme="$theme" -v colour="$colour" -f ~/.config/darkman/gtk.awk -- "$XDG_CONFIG_HOME/gtk-3.0/settings.ini" > "$XDG_CONFIG_HOME/gtk-9.0/settings.ini"
awk -Ov theme="$theme" -v colour="$colour" -f ~/.config/darkman/gtk.awk -- "$XDG_CONFIG_HOME/gtk-3.0/settings.ini" > /tmp/gtk.ini
cp /tmp/gtk.ini "$XDG_CONFIG_HOME/gtk-3.0/settings.ini"
cp "$XDG_CONFIG_HOME/gtk-4.0/settings.ini" "$XDG_CONFIG_HOME/gtk-4.0/settings.ini.backup"
awk -Ov theme="$theme" -v colour="$colour" -f ~/.config/darkman/gtk.awk -- "$XDG_CONFIG_HOME/gtk-4.0/settings.ini"  > /tmp/gtk.ini
cp /tmp/gtk.ini "$XDG_CONFIG_HOME/gtk-4.0/settings.ini"

# wofi
ln -sf "./$theme/style.css" ~/.config/wofi/style.css

cursorTheme="Catppuccin $theme $colour"
hyprctl setcursor "$cursorTheme" 24

colour=$(echo $colour | sed -r 's/\<./\L&/g') # lowercase colour variant
theme=$(echo $theme | sed -r 's/\<./\L&/g') # lowercase theme variant
# mako notifications
ln -sf "catppuccin/themes/catppuccin-$theme/catppuccin-$theme-$colour" ~/.config/mako/colours
makoctl reload

# fuzzel
ln -sf "catppuccin/themes/catppuccin-$theme/$colour.ini" ~/.config/fuzzel/colours.ini

# wleave
ln -sfr "$XDG_CONFIG_HOME/wleave/catppuccin/themes/$theme/$colour.css" "$XDG_CONFIG_HOME/wleave/style.css"
ln -sfrn "$XDG_CONFIG_HOME/wleave/catppuccin/icons/wleave/$theme/$colour/" "$XDG_CONFIG_HOME/wleave/icons"

# heroic
# jq ".defaultSettings.customThemesPath = ~/.config/themes/heroic-catppuccin/" ./.config/heroic/config.json

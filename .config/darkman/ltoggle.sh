#!/bin/env sh

ln -sf ./latte.gtk.css  ~/.config/palette/style.css

alias inkcat="deno run --allow-env --allow-read --allow-sys npm:@catppuccin/inkcat"

# https://stackoverflow.com/a/2453056/16929246
colour=$(inkcat mocha | tail --lines=26 | grep --extended-regexp --invert-match "(text|overlay|surface|base|mantle|crust)" | shuf --head-count=1 | sed -r 's/\<./\U&/g' | tr -d '[:space:]')

gsettings set org.gnome.desktop.interface color-scheme prefer-light
gsettings set org.gnome.desktop.interface gtk-theme Pop

ln -sf ./latte/style.css  ~/.config/wofi/style.css

cursorTheme="Catppuccin Latte $colour"
hyprctl setcursor "$cursorTheme" 24
gsettings set org.gnome.desktop.interface cursor-theme "$cursorTheme"
export HYPRCURSOR_THEME="$cursorTheme"
export HYPRCURSOR_SIZE=24

# echo $HYPRLAND_INSTANCE_SIGNATURE

colour=$(echo $colour | sed -r 's/\<./\L&/g') # lowercase colour variant
# mako notifications
ln -sf "catppuccin/themes/catppuccin-latte/catppuccin-latte-$colour" ~/.config/mako/colours
makoctl reload
# fuzzel
ln -sf "catppuccin/themes/catppuccin-latte/catppuccin-latte-$colour" ~/.config/fuzzel/colours

# waybar
pidof waybar && kill -s USR2 $(pidof waybar)

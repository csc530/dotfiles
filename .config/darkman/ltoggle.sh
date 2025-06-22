#!/bin/sh

alias inkcat="deno run --allow-env --allow-read --allow-sys npm:@catppuccin/inkcat"

# https://stackoverflow.com/a/2453056/16929246
colour=$(inkcat latte | tail --lines=26 | grep --extended-regexp --invert-match "(text|overlay|surface|base|mantle|crust)" | shuf --head-count=1 | sed -r 's/\<./\U&/g')

gsettings set org.gnome.desktop.interface color-scheme prefer-light
gsettings set org.gnome.desktop.interface gtk-theme Pop

ln -sf ./latte/style.css  ~/.config/wofi/style.css

cursorTheme="Catppuccin Latte $colour"
hyprctl setcursor $cursortheme 24
gsettings set org.gnome.desktop.interface cursor-theme $cursorTheme
export HYPRCURSOR_THEME=$cursorTheme
export HYPRCURSOR_SIZE=24

echo $HYPRLAND_INSTANCE_SIGNATURE
#! /usr/bin/bash

echo "setting up Arch Linux (BTW)"

echo updating package libraries
sudo pacman -Syu

gum style "setting up ArchLinux User Repository (AUR) helper"
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ../
rm -rf yay

# prettying tui
sudo pacman -S gum git nushell github-cli

# gum style variables
ALIGN=center
WIDTH=$(tput cols)
TERM_HEIGHT=$(tput lines)
gum style "pulling .FILES" --bold --border thick 
# --height $(( $TERM_HEIGHT / 4 ))
# redundant
# gum spin --title "pulling git dotfiles" git clone https://github.com/csc530/.files.git
# mkdir --parents .config
# mv --backup .files .config
# mv .files/.git .config/

gum spin --title "installing terminal decals..." --spinner line -- yay -S zoxide oh-my-posh carapace-bin --noconfirm
nu "$HOME/.config/nushell/setup_nushell.nu"

sudo cp "$HOME/.config/arch/font.conf" /etc/fonts/local.conf
gum spin --spinner moon  --title "Downloading Fonts"  -- yay -S maplemono-nf-cn noto-fonts-emoji noto-fonts ttf-profont-nerd ttf-noto-nerd ttf-ubuntu-nerd --noconfirm

fc-cache


# my packages

gum style "HYPRLAND" --bold --border double

sudo pacman -S hyprland hyprpaper hyprpolkitagent clipse hyprpicker hyprcursor




gum style --bold "Apps and Games time !! :D" --margin "1 2" --padding "2 4" --border rounded
yay -S steam vivaldi micro nano neovim github-cli choose onefetch punfetch-bin yazi timeshift unzip wget curl zip nemo kitty ghostty 7zip 1password jq diff-so-fancy code rofi

echo "all done and enjoy"
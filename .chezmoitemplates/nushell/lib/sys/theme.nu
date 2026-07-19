#!/usr/bin/env nu --login

const NU_SCRIPTS = $"($nu.default-config-dir)/nu_scripts/themes"

use ($NU_SCRIPTS)/nu-themes/catppuccin-latte.nu
# use ($NU_SCRIPTS)/nu-themes/catppuccin-frappe.nu
use ($NU_SCRIPTS)/nu-themes/catppuccin-macchiato.nu
use ($NU_SCRIPTS)/nu-themes/catppuccin-mocha.nu

def --env main [theme?:string@[light dark]] {
    let theme = $theme
	    | default (gsettings get org.gnome.desktop.interface color-scheme | parse "'prefer-{mode}'" | get mode.0)
	    | default (darkman get e>| ignore)
    match $theme {
        "light" => {
            catppuccin-latte set color_config
            catppuccin-latte update terminal
            $env.LS_COLORS = (vivid generate catppuccin-latte)
            $env.theme = "catppuccin-latte"
        }
        "dark" => {
            catppuccin-mocha set color_config
            catppuccin-mocha update terminal
            $env.LS_COLORS = (vivid generate catppuccin-mocha)
            $env.theme = "catppuccin-mocha"
        }
        _ => {
            catppuccin-macchiato set color_config
            catppuccin-macchiato update terminal
            $env.LS_COLORS = (vivid generate catppuccin-macchiato)
            $env.theme = "catppuccin-macchiato"
        }
    }
}

export-env {
    main
}

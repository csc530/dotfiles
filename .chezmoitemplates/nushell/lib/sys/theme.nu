#!/usr/bin/env nu --login

use nu-themes/catppuccin-latte.nu
# use nu-themes/catppuccin-frappe.nu
use nu-themes/catppuccin-macchiato.nu
use nu-themes/catppuccin-mocha.nu

def --env main [theme?:string@[light dark]] {
    let theme = $theme | default (darkman get e>| ignore | default "dark")
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

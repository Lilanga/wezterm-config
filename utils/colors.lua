local wezterm = require 'wezterm'

local color_default_fg_light = wezterm.color.parse("#cacaca") -- 💩
local color_default_fg_dark = wezterm.color.parse("#303030")

return {
    VERIDIAN = {
        bg = wezterm.color.parse("#4D8060"),
        fg = color_default_fg_light
    },
    PAYNE = {
        bg = wezterm.color.parse("#385F71"),
        fg = color_default_fg_light
    },
    INDIGO = {
        bg = wezterm.color.parse("#7C77B9"),
        fg = color_default_fg_light
    },
    CAROLINA = {
        bg = wezterm.color.parse("#8FBFE0"),
        fg = color_default_fg_dark
    },
    FLAME = {
        bg = wezterm.color.parse("#D36135"),
        fg = color_default_fg_dark
    },
    JET = {
        bg = wezterm.color.parse("#282B28"),
        fg = color_default_fg_light
    },
    TAUPE = {
        bg = wezterm.color.parse("#785964"),
        fg = color_default_fg_light
    },
    ECRU = {
        bg = wezterm.color.parse("#C6AE82"),
        fg = color_default_fg_dark
    },
    VIOLET = {
        bg = wezterm.color.parse("#685F74"),
        fg = color_default_fg_light
    },
    VERDIGRIS = {
        bg = wezterm.color.parse("#28AFB0"),
        fg = color_default_fg_light
    },
    MOCHA = {
        rosewater = '#f5e0dc',
        flamingo = '#f2cdcd',
        pink = '#f5c2e7',
        mauve = '#cba6f7',
        red = '#f38ba8',
        maroon = '#eba0ac',
        peach = '#fab387',
        yellow = '#f9e2af',
        green = '#a6e3a1',
        teal = '#94e2d5',
        sky = '#89dceb',
        sapphire = '#74c7ec',
        blue = '#89b4fa',
        lavender = '#b4befe',
        text = '#cdd6f4',
        subtext1 = '#bac2de',
        subtext0 = '#a6adc8',
        overlay2 = '#9399b2',
        overlay1 = '#7f849c',
        overlay0 = '#6c7086',
        surface2 = '#585b70',
        surface1 = '#45475a',
        surface0 = '#313244',
        surface0_trnsp = 'rgba(49, 50, 68, 0.4)',
        base = '#1f1f28',
        mantle = '#181825',
        crust = '#11111b',
    },
    ANSI = {
        '#0C0C0C', -- black
        '#C50F1F', -- red
        '#13A10E', -- green
        '#C19C00', -- yellow
        '#0037DA', -- blue
        '#881798', -- magenta/purple
        '#3A96DD', -- cyan
        '#CCCCCC', -- white
    },
    BRIGHTS = {
        '#767676', -- black
        '#E74856', -- red
        '#16C60C', -- green
        '#F9F1A5', -- yellow
        '#3B78FF', -- blue
        '#B4009E', -- magenta/purple
        '#61D6D6', -- cyan
        '#F2F2F2', -- white
    },
    RIGHT_STATUS = {
        date_fg = '#fab387',
        date_bg = 'rgba(49, 50, 68, 0.4)',
        battery_fg = '#f9e2af',
        battery_bg = 'rgba(49, 50, 68, 0.4)',
        separator_fg = '#74c7ec',
        separator_bg = 'rgba(49, 50, 68, 0.4)',
        domain_fg = '#FBB829',
        domain_bg = 'rgba(49, 50, 68, 0.4)',
        weather_fg = '#13A10E',
        weather_bg = 'rgba(49, 50, 68, 0.4)',
    }
}
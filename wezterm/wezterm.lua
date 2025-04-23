local wezterm = require 'wezterm';
local act = wezterm.action

return {
    -- Font configuration with fallbacks
    font = wezterm.font_with_fallback({
        "Hack Nerd Font",        -- Your preferred main font (must be Nerd Font variant)
        "Symbols Nerd Font",     -- For missing icons/symbols
        "Noto Color Emoji",      -- For emoji support
    }),
    font_size = 14.0,
    warn_about_missing_glyphs = false,  -- Temporarily suppress warnings

    window_background_opacity = 0.86,
    color_scheme = "Catppuccin Mocha",

    keys = {
        { key = "PageUp",  mods = "NONE", action = act.ScrollByPage(-1) },
        { key = "PageDown", mods = "NONE", action = act.ScrollByPage(1) },
        { key = "PageUp", mods = "SHIFT", action = act.ScrollByLine(-3) },
        { key = "PageDown", mods = "SHIFT", action = act.ScrollByLine(3) },
    },
}

local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.color_scheme = "Catppuccin Mocha"

config.font = wezterm.font({
	family = "FiraCode Nerd Font Mono",
	weight = "Regular",
})
config.font_size = 14.0
config.foreground_text_hsb = {
	hue = 1.0,
	saturation = 1.0,
	brightness = 1.0,
}
config.freetype_load_target = "Normal"
config.freetype_load_flags = "FORCE_AUTOHINT"

config.use_fancy_tab_bar = false
config.enable_tab_bar = true
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true
config.custom_block_glyphs = true
-- config.line_height = 1.0
-- config.default_ssh_auth_sock = "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"

config.window_padding = {
	left = 6,
	right = 6,
	top = 10,
	bottom = 10,
}

return config

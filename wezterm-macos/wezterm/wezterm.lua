local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.color_scheme = "Kanagawa (Gogh)"

-- local function scheme_for_appearance(appearance)
-- 	if appearance:find("Dark") then
-- 		return "Tokyo Night"
-- 	else
-- 		return "Github"
-- 	end
-- end
-- wezterm.on("window-config-reloaded", function(window, _)
-- 	local overrides = window:get_config_overrides() or {}
-- 	local appearance = window:get_appearance()
-- 	local scheme = scheme_for_appearance(appearance)
-- 	if overrides.color_scheme ~= scheme then
-- 		overrides.color_scheme = scheme
-- 		window:set_config_overrides(overrides)
-- 	end
-- end)

config.font = wezterm.font("Iosevka Nerd Font Mono", { weight = "Regular" })
config.font_size = 12
config.hide_tab_bar_if_only_one_tab = true
-- config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.window_close_confirmation = "NeverPrompt"
config.default_cursor_style = "BlinkingBar"

return config

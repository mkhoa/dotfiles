-- Hyprbars (window title bars)
-- Build it once with hyprpm:
--   hyprpm update
--   hyprpm add https://github.com/hyprwm/hyprland-plugins
--   hyprpm enable hyprbars
-- then `hyprctl reload`. Don't also autostart `hyprpm reload`, this file loads the plugin.

local plugin_path = "/var/cache/hyprpm/" .. os.getenv("USER") .. "/hyprland-plugins/hyprbars.so"

local f = io.open(plugin_path, "r")
if not f then
	return -- not built yet
end
f:close()

hl.plugin.load(plugin_path)

-- hyprland evaluates the config, loads plugins, then evaluates it again,
-- so the plugin's functions only exist on the second pass
if not hl.plugin.hyprbars then
	return
end

local colors = require("noctalia").colors

hl.config({
	plugin = {
		hyprbars = {
			bar_height = 22,
			bar_color = colors.surface,
			col = { text = colors.on_surface },
			bar_text_font = "JetBrainsMono Nerd Font",
			bar_text_size = 10,
			bar_text_weight = "semibold",
			bar_padding = 10,
			bar_button_padding = 6,
			bar_buttons_alignment = "right",
			bar_precedence_over_border = true,
			icon_on_hover = true,
			on_double_click = [[hyprctl dispatch 'hl.dsp.window.float({ action = "toggle" })']],
		},
	},
})

-- With right alignment the first button is the rightmost one,
-- so the bar reads: [move left] [move right] [close]
-- Colors come from the Noctalia theme, reloaded by its colors_changed hook
local function button(bg, icon, action)
	hl.plugin.hyprbars.add_button({
		bg_color = bg,
		fg_color = colors.surface,
		size = 13,
		icon = icon,
		action = action,
	})
end

button(colors.error, "󰖭", [[hyprctl dispatch 'hl.dsp.window.close()']]) -- close
button(colors.primary, "󰁔", [[hyprctl dispatch 'hl.dsp.window.move({ workspace = "r+1" })']]) -- move to right workspace
button(colors.on_surface, "󰁍", [[hyprctl dispatch 'hl.dsp.window.move({ workspace = "r-1" })']]) -- move to left workspace

local mainMod = "SUPER"
local ipc = "noctalia msg "
local launchPrefix = "uwsm app -- " -- if you are not using UWSM, make this empty (e.g. "")

local function layout_bind(bind_table)
	return function()
		local workspace = hl.get_active_special_workspace() or hl.get_active_workspace()

		if not workspace then
			return
		end

		local layout = workspace.tiled_layout

		if bind_table[layout] then
			hl.dispatch(bind_table[layout])
		end
	end
end
---------------------------
---- window management ----
---------------------------

hl.bind(mainMod .. " + Escape", hl.dsp.exec_cmd("hyprctl kill"))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + ALT + Space", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = 1 }))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + ALT + Left", hl.dsp.layout("swapcol l"))
hl.bind(mainMod .. " + ALT + Right", hl.dsp.layout("swapcol r"))

hl.bind(mainMod .. " + R", function()
	hl.dispatch(hl.dsp.layout("colresize +conf"))
end)

-- Change focus

hl.bind(
	"SUPER + Left",
	layout_bind({
		monocle = hl.dsp.layout("cycleprev"),
	})
)

hl.bind(
	"SUPER + Right",
	layout_bind({
		monocle = hl.dsp.layout("cyclenext"),
	})
)

hl.bind(mainMod .. " + Left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + Right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + Up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + Down", hl.dsp.focus({ direction = "down" }))
hl.bind("ALT + Tab", hl.dsp.window.cycle_next())

-- move active window around workspaces & monitors

hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + Right", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + Up", hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + Down", hl.dsp.window.move({ direction = "d" }))
hl.bind(mainMod .. " + SHIFT + 1", hl.dsp.window.move({ monitor = MONITOR1 }))
hl.bind(mainMod .. " + SHIFT + 2", hl.dsp.window.move({ monitor = MONITOR2 }))
hl.bind(mainMod .. " + SHIFT + 3", hl.dsp.window.move({ monitor = MONITOR3 }))
hl.bind(mainMod .. " + SHIFT + mouse_up", hl.dsp.window.move({ monitor = "+1" }))
hl.bind(mainMod .. " + SHIFT + mouse_down", hl.dsp.window.move({ monitor = "-1" }))
hl.bind(mainMod .. " + CONTROL + SHIFT + Right", hl.dsp.window.move({ workspace = "r+1" }))
hl.bind(mainMod .. " + CONTROL + SHIFT + Left", hl.dsp.window.move({ workspace = "r-1" }))
hl.bind(mainMod .. " + CONTROL + SHIFT + mouse_up", hl.dsp.window.move({ workspace = "r+1" }))
hl.bind(mainMod .. " + CONTROL + SHIFT + mouse_down", hl.dsp.window.move({ workspace = "r-1" }))
for i = 1, NUM_WPM do
	local key = i % 10
	hl.bind(mainMod .. " + SHIFT + CONTROL + " .. key, hl.dsp.window.move({ workspace = "m~" .. i }))
end

-- move to adjacent workspaces and next empty on a given monitor
hl.bind(mainMod .. " + CONTROL + Right", hl.dsp.focus({ workspace = "m+1" }))
hl.bind(mainMod .. " + CONTROL + Left", hl.dsp.focus({ workspace = "m-1" }))
hl.bind(mainMod .. " + CONTROL + Down", hl.dsp.focus({ workspace = "emptym" }))

-- scroll through existing workspaces & monitors
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "m+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "m-1" }))
hl.bind(mainMod .. " + CONTROL + mouse_up", hl.dsp.focus({ workspace = "m+1" }))
hl.bind(mainMod .. " + CONTROL + mouse_down", hl.dsp.focus({ workspace = "m-1" }))

-- move & Resize with mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag())
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize())

hl.bind(mainMod .. " + SHIFT + equal", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + minus", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + equal", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })
hl.bind(mainMod .. " + minus", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })

------------------
---- launcher ---
------------------

hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(launchPrefix .. TERMINAL))
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(launchPrefix .. TERMINAL))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(launchPrefix .. TERMINAL .. " -e yazi"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(launchPrefix .. EDITOR))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(launchPrefix .. BROWSER))
hl.bind("CONTROL + SHIFT + Escape", hl.dsp.exec_cmd(launchPrefix .. TERMINAL .. " -e btop"))
hl.bind(mainMod .. "+Space", hl.dsp.exec_cmd(ipc .. "panel-toggle launcher"))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd(ipc .. "session lock"))
hl.bind(mainMod .. " + ALT + L", hl.dsp.exec_cmd(ipc .. "session lock"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(ipc .. "bar-toggle"))
hl.bind(mainMod .. " + X", hl.dsp.exec_cmd(ipc .. "panel-toggle control-center"))
hl.bind(mainMod .. " + comma", hl.dsp.exec_cmd(ipc .. "settings-toggle"))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd(ipc .. "panel-toggle control-center notifications"))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd(ipc .. "panel-toggle control-center audio"))
hl.bind(mainMod .. " + ALT + C", hl.dsp.exec_cmd(ipc .. "panel-toggle session"))
hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd(ipc .. "settings-toggle"))
hl.bind("ALT + Tab", hl.dsp.exec_cmd(ipc .. "window-switcher"))

---------------------------
---- hardware controls ----
---------------------------

-- audio

-- Media
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd(ipc .. "media toggle"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd(ipc .. "media toggle"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd(ipc .. "media toggle"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd(ipc .. "media next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd(ipc .. "media previous"), { locked = true })

-- Brightness
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(ipc .. "brightness-up"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(ipc .. "brightness-down"), { locked = true, repeating = true })
hl.bind(mainMod .. " + CONTROL + equal", hl.dsp.exec_cmd(ipc .. "brightness-up"), { locked = true, repeating = true })
hl.bind(mainMod .. " + CONTROL + minus", hl.dsp.exec_cmd(ipc .. "brightness-down"), { locked = true, repeating = true })

-- Power button (logind ignores it, see /etc/systemd/logind.conf.d/power-key.conf)
hl.bind("XF86PowerOff", hl.dsp.exec_cmd(ipc .. "session lock"))

-------------------
---- UTILITIES ----
-------------------

-- Screen Capture
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd(ipc .. " screenshot-region"))
hl.bind("Print", hl.dsp.exec_cmd(ipc .. " screenshot-region"))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd(ipc .. " screenshot-fullscreen"))
hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd(ipc .. " screenshot-annotate"))

-- Theming and Wallpaper
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd(ipc .. " panel-toggle launcher /wall "))
hl.bind(mainMod .. " + SHIFT + X", hl.dsp.exec_cmd(ipc .. " wallpaper-random"))

-- Clipboard
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd(ipc .. " panel-toggle clipboard"))

-- Zoom
local MAX_ZOOM = 3
local MIN_ZOOM = 1
local ZOOM_TOGGLE_FACTOR = 1.7

---@param offset number
---@return nil
local function zoom(offset)
	local current = hl.get_config("cursor.zoom_factor")
	if offset ~= nil then
		current = current + offset
	elseif current ~= MIN_ZOOM then
		current = MIN_ZOOM
	else
		current = ZOOM_TOGGLE_FACTOR
	end
	current = math.max(MIN_ZOOM, math.min(MAX_ZOOM, current))
	hl.config({ cursor = { zoom_factor = current } })
end

hl.bind("SUPER + SHIFT + Z", zoom)

--------------------
---- WORKSPACES ----
--------------------

--Change layouts per workspace

hl.bind("SUPER + Tab", function()
	local layouts = { "scrolling", "dwindle", "master", "monocle" }
	local workspace = hl.get_active_workspace()
	if hl.get_active_special_workspace() then
		workspace = hl.get_active_special_workspace()
	end

	local next_layout = "dwindle"

	if not workspace then
		return
	end

	for i = 1, #layouts do
		if layouts[i] == workspace.tiled_layout then
			local next_layout_idx = (i % #layouts) + 1
			next_layout = layouts[next_layout_idx]
			break
		end
	end

	if workspace.special then
		hl.workspace_rule({ workspace = tostring(workspace.name), layout = next_layout })
	else
		hl.workspace_rule({ workspace = tostring(workspace.id), layout = next_layout })
	end
end)

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("scratchpad"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:scratchpad" }))

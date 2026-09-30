-- Picture-in-Picture
hl.window_rule({
    match = { title = "^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$" },
    float = true,
    keep_aspect_ratio = true,
    move = "73% 72%",
    size = "25% 25%",
    pin = true,
})

-- Gaming
local gamingApps = "^(steam_app.*|gamescope|Minecraft .*)$"
local gamingWorkspace = "name:game"

hl.window_rule({ match = { content = "game" }, workspace = gamingWorkspace })
hl.window_rule({
    match = { xdg_tag = "^(.*game.*)$" },
    workspace = gamingWorkspace,
    fullscreen_state = 2,
    content = "game",
    sync_fullscreen = true,
})
hl.window_rule({ match = { class = gamingApps }, workspace = gamingWorkspace })
hl.window_rule({ match = { class = "^(steam)$", title = "^(Friends List)$" }, float = true })
hl.window_rule({
    match = { class = "^(steam)$", title = "^(Launching\\.{3})$" },
    float = true,
    center = true,
    workspace = gamingWorkspace,
})
hl.window_rule({
    match = {
        class = gamingApps,
        title = "^(.+)$",
        initial_title = "negative:^(.*\\\\home\\\\.*)$",
    },
    content = "game",
    decorate = false,
    fullscreen_state = 2,
    size = { "monitor_w", "monitor_h" },
    sync_fullscreen = true,
})
hl.window_rule({
    match = {
        class = "^(steam_app.*)$",
        initial_title = "^$",
    },
    center = true,
    float = true,
    fullscreen = false,
    fullscreen_state = 0,
    workspace = gamingWorkspace,
})
hl.window_rule({
    match = {
        class = "^(steam_app.*)$",
        initial_title = "^$",
    },
    float = true,
    center = true,
    fullscreen = false,
    fullscreen_state = 0,
})

-- Apps
local primaryWorkspace = 1

hl.window_rule({ match = { class = "^(.*\\.exe)$", float = true }, center = true, fullscreen_state = 0 })
hl.window_rule({ match = { class = "^(.*[Cc]alculator.*)$" }, float = true, size = "380 616" })
hl.window_rule({ match = { class = "^(org.kde.keditfiletype)$" }, float = true })
hl.window_rule({ match = { class = "^(org.kde.ark)$" }, size = "(monitor_w*0.30) (monitor_h*0.30)" })

-- Opacity Overrides
local terminals = "^(foot|ghostty|[Kk]onsole|Alacritty|gnome-terminal|xfce[0-9]?-terminal)$"

hl.window_rule({ match = { class = terminals }, opacity = "1.0 override" }) -- override opacity in favor of terminal settings for opacity
hl.window_rule({
    match = { class = "^(mpv|org.kde.haruna|.*plex.*|org\\.kde\\.gwenview|.*vlc.*)$" },
    opacity = "1.0 override",
})

-- Float Utility Windows
local floatApps = {
    { class = "^(kvantummanager|qt[56]ct|nwg-look)$" },
    { class = "^(org.pulseaudio.pavucontrol|blueman-manager|nm-applet|nm-connection-editor|goverlay)$" },
    { title = "^(Winetricks.*|Protontricks.*)$" },
}
for _, m in ipairs(floatApps) do
    hl.window_rule({ match = m, float = true })
end

hl.window_rule({ match = { float = true }, move = "50% 50%" })

-- Float Common Modals
local modalMatches = {
    {
        title =
        "^(Open|Authentication Required|Add Folder to Workspace|Choose Files|Save As|Confirm to replace files|File Operation Progress)$",
    },
    { initial_title = "^(Open File)$" },
    { class = "^([Xx]dg-desktop-portal-gtk)$" },
    { title = "^(File Upload|Choose wallpaper|Library)(.*)$" },
    { class = "^(.*dialog.*)$" },
    { title = "^(.*dialog.*)$" },
    { class = "^(hyprland-share-picker)$" },
}
for _, m in ipairs(modalMatches) do
    hl.window_rule({ match = m, float = true })
end

-- Ignore maximize requests from all apps. You'll probably like this.
local suppressMaximizeRule = hl.window_rule({
    name = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

-- Fix some dragging issues with XWayland
hl.window_rule({
    name = "fix-xwayland-drags",
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },

    no_focus = true,
})

hl.layer_rule({
    name = "noctalia",
    match = {
        namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd|window-switcher)$",
    },
    no_anim = true,
    ignore_alpha = 0.3,
    blur = true,
    blur_popups = true,
})

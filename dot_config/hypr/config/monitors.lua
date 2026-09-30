-- Montior wiki https://wiki.hypr.land/Configuring/Basics/Monitors/
-- @*** is the refresh rate for the monitor,
-- do not set it over the value that your monitor uses

hl.monitor({
    output   = "eDP-1",
    mode     = "2880x1800@60",
    position = "auto",
    scale    = 1.8,
})

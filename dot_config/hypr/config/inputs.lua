-- Input configuration

hl.config({
    input = {
      --  sensitivity = -0.25,
        accel_profile = "flat",
        kb_layout = "us",
        touchpad = {
            natural_scroll = true,
        },
    },
    -- Uncomment the section below to enable software cursors; this can help with cursor display or behavior issues
    -- cursor = {
    --     no_hardware_cursors = 1,
    -- },
})

hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

hl.gesture({ fingers = 3, direction = "down", action = "close" })
-- mode "float" only floats; the default toggles, which would re-tile an already-floating window.
hl.gesture({ fingers = 3, direction = "up", action = "float", mode = "float" })

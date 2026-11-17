-- Input configuration

hl.config({
    input = {
        sensitivity = 1.0,
        accel_profile = "flat",
        kb_layout = "us",
        touchpad = {
            natural_scroll = true,
            scroll_factor = 0.5,
        },
    },
    gestures = {
        workspace_swipe_touch = true,
    },
    -- Uncomment the section below to enable software cursors; this can help with cursor display or behavior issues
    -- cursor = {
    --     no_hardware_cursors = 1,
    -- },
})

hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

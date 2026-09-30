-- Environmental variables
-- if you don't use UWSM, define your variables here (e.g. hl.env("QT_QPA_PLATFORM", "wayland"))

-- if you have an NVIDIA GPU uncomment the following lines:

-- hl.env("GBM_BACKEND", "nvidia-drm") -- force GBM as a backend
-- hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia") -- force GBM as a backend
-- hl.env("LIBVA_DRIVER_NAME", "nvidia") -- Hardware acceleration on NVIDIA GPUs
-- hl.env("__GL_GSYNC_ALLOWED", "1") -- Controls if G-Sync capable monitors should use Variable Refresh Rate (VRR)

hl.env("XCURSOR_SIZE", "20")
hl.env("XCURSOR_THEME", "Bibata-Modern-Ice")

hl.env("HYPRCURSOR_SIZE", "18")
hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Ice")

-- Input method (fcitx5, for Vietnamese typing)
-- Wayland-native apps use text-input; these cover Qt, XWayland and SDL apps
hl.env("QT_IM_MODULE", "fcitx")
hl.env("XMODIFIERS", "@im=fcitx")
hl.env("SDL_IM_MODULE", "fcitx")

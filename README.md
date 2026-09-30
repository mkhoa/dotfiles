# dotfiles

My Hyprland + [Noctalia](https://github.com/noctalia-dev/noctalia) setup on CachyOS, managed with [chezmoi](https://www.chezmoi.io/).

Hyprland is configured in **Lua** (`~/.config/hypr/hyprland.lua` and the modules in `config/`), not `hyprland.conf`. Noctalia provides the bar, launcher, control center, lock screen and notifications, and generates a color palette from the wallpaper that it pushes to every themed app.

## What's included

| Area | Config |
|---|---|
| Window manager | Hyprland (Lua config), optional [hyprbars](https://github.com/hyprwm/hyprland-plugins) title bars with theme-colored buttons |
| Shell / bar | Noctalia: bar, launcher (with emoji search), control center, desktop widgets, light/dark theme toggle on the bar |
| Terminal | kitty, foot, fish, tmux, fastfetch (random Pokémon logo in kitty) |
| Apps | Zed, Neovim, yazi, btop, Vesktop, MangoHud |
| Theming | GTK 3/4, Qt5/Qt6 (qt5ct/qt6ct), Papirus icons, JetBrains Mono Nerd Font, all recolored by Noctalia templates |

Wallpapers are not included. Noctalia looks for them in `~/Pictures/Wallpapers`, so drop your own there.

## Requirements

- [Hyprland 0.55+](https://github.com/hyprwm/Hyprland) (Lua config support)
- [Noctalia v5+](https://github.com/noctalia-dev/noctalia)
- [JetBrains Mono Nerd Font](https://www.nerdfonts.com/font-downloads) (`ttf-jetbrains-mono-nerd`)

The package list assumes a CachyOS base; drop anything you don't use:

```bash
sudo pacman -S chezmoi kitty foot fish tmux fastfetch btop yazi zed zen-browser-bin neovim vesktop-bin papirus-icon-theme ttf-jetbrains-mono-nerd
```

Optional:

```bash
yay -S pokemon-colorscripts-git
```

```bash
hyprpm update && hyprpm add https://github.com/hyprwm/hyprland-plugins && hyprpm enable hyprbars
```

## Install

```bash
chezmoi init --apply https://github.com/mkhoa/dotfiles.git
```

Then adjust the machine-specific bits:

- `~/.config/hypr/config/variables.lua`: default apps (`TERMINAL`, `BROWSER`, `EDITOR`, ...) and monitor names (`MONITOR1`...)
- `~/.config/hypr/config/monitors.lua`: resolution, scale and position
- `~/.config/hypr/config/inputs.lua`: keyboard layout, touchpad and gestures

To have the power button lock the screen instead of shutting down, stop logind from handling it:

```ini
# /etc/systemd/logind.conf.d/power-key.conf
[Login]
HandlePowerKey=ignore
HandlePowerKeyLongPress=ignore
```

### Keeping it in sync

Noctalia rewrites its color template files (`hypr/noctalia.lua`, `foot/themes/noctalia`, `zed/themes/noctalia.json`, ...) whenever the wallpaper or theme changes. After the first install, apply changes **one file at a time** so a blanket apply doesn't revert the live palette:

```bash
chezmoi diff -- ~/.config/hypr/config/keybinds.lua
chezmoi apply ~/.config/hypr/config/keybinds.lua
```

## Keybinds

`SUPER` is the main modifier. Highlights:

| Keys | Action |
|---|---|
| `SUPER + Space` | Launcher |
| `SUPER + T` / `SUPER + Return` | Terminal |
| `SUPER + W` / `E` / `D` | Browser / editor / yazi |
| `SUPER + Q` | Close window |
| `SUPER + F` / `SUPER + SHIFT + F` | Maximize / fullscreen |
| `SUPER + ALT + Space` | Toggle floating |
| `SUPER + Arrows` | Move focus |
| `SUPER + SHIFT + Arrows` | Move window |
| `SUPER + CTRL + Left/Right` | Previous / next workspace |
| `SUPER + S` / `SUPER + SHIFT + S` | Toggle scratchpad / send window to it |
| `SUPER + X` / `N` / `V` | Control center / notifications / audio |
| `SUPER + C` | Clipboard history |
| `SUPER + B` | Toggle bar |
| `SUPER + L`, power button | Lock screen |
| `SUPER + ALT + C` | Session menu |
| `SUPER + SHIFT + W` / `SUPER + SHIFT + X` | Pick wallpaper / random wallpaper |
| `Print` / `SHIFT + Print` / `SUPER + Print` | Screenshot region / full screen / annotate |
| `SUPER + SHIFT + Z` | Zoom |
| `SUPER + ,` | Noctalia settings |

Touchpad: three-finger swipe left/right switches workspace, down closes the window, up floats it.

The full list lives in [`dot_config/hypr/config/keybinds.lua`](dot_config/hypr/config/keybinds.lua).

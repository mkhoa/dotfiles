# dotfiles (Ryoku)

My personal layer on top of [Ryoku](https://ryoku.dev), managed with [chezmoi](https://www.chezmoi.io/).

Ryoku ships the desktop itself (Hyprland in Lua, the Quickshell bar, dock, launcher and Hub, the palette) as packages and re-lays those files on every `ryoku update`. This repo only holds what Ryoku leaves to the user, so the two never fight over a file.

> The previous CachyOS + Noctalia setup lives on the `main` branch.

## What's included

| Area | Files |
|---|---|
| Hyprland overrides | `hypr/user.lua`, `hypr/monitors_user.lua` (Ryoku loads these last; updates never touch them) |
| Ryoku Settings | `ryoku/user_edits/hypr/{settings,settings_window,rebinds}.lua`, written by Ryoku Hub (Super+comma). Tracked as a backup so a new install gets the same gaps, input, animations and rebinds |
| Overlay forks | `ryoku/user_edits/matugen/apps.toml` |
| Shell | fish universal variables, tmux, fastfetch |
| Apps | Neovim, Zed, yazi keymap, Vesktop settings, MangoHud, Millennium, Dolphin, fontconfig, a Zalo desktop entry |

Not tracked on purpose:

- **Files Ryoku ships** (`hypr/hyprland.lua`, `kitty/kitty.conf`, `fish/config.fish`, GTK settings, `yazi/yazi.toml`, ...). Updates overwrite them. To own one, fork it into `~/.config/ryoku/user_edits/` at the same path and track the fork.
- **Generated files** (`hypr/monitors.lua`, `hypr/settings.lua`, the `*ryoku-colors*` palette outputs, `yazi/theme.toml`). The Hub or the theme daemon owns these.
- **Ryoku tool stores** (`~/.config/ryoku/*.json`). Each has one writer; change them through the Hub or `ryoku-shell`.

Run `ryoku owner <path>` before adding anything new. It says whether the file is Ryoku's, generated, or yours.

## Install

On a fresh Ryoku install:

```bash
chezmoi init --apply --branch ryoku https://github.com/mkhoa/dotfiles.git
```

Then reload Hyprland with `ryoku wm act config.reload`.

Displays are set in Ryoku Hub > Displays. Pin anything the Hub can't express in `~/.config/hypr/monitors_user.lua`.

### Keeping it in sync

After a change made in the Hub or an app, pull it into the repo:

```bash
chezmoi re-add
```

Apply one file at a time when going the other way:

```bash
chezmoi diff -- ~/.config/hypr/user.lua
```

```bash
chezmoi apply ~/.config/hypr/user.lua
```

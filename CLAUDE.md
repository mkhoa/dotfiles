# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

A **chezmoi source directory** for a Hyprland + Noctalia rice on CachyOS. It is not an application — there is nothing to build, lint, or test. "Correct" means the live desktop looks and behaves as intended, so changes are verified by applying them and inspecting runtime state, not by a test suite.

Published as `mkhoa/dotfiles` on GitHub (`origin`). See `README.md` for the install steps and dependency list.

## The core workflow: source → target

The repo *is* `~/.local/share/chezmoi`, and it maps to `~` via chezmoi's naming (`dot_config/foo` → `~/.config/foo`). Editing a file here changes nothing until it is applied.

```bash
chezmoi diff -- ~/.config/hypr/config/keybinds.lua   # preview one file
chezmoi apply ~/.config/hypr/config/keybinds.lua     # apply one file
chezmoi status                                       # what has drifted, both directions
```

**Always scope `apply` to the specific file you changed.** A blanket `chezmoi apply` will stomp live theme state — see "Generated files" below.

Two directions of drift, and `chezmoi status` shows both in its two columns: first column = source is ahead (apply needed), second = target is ahead (`chezmoi re-add` needed).

Reloading after a change:

| Changed | Reload with |
|---|---|
| `dot_config/hypr/**` | `hyprctl reload` |
| `dot_config/noctalia/config.toml` | `noctalia msg config-reload` |

## Hyprland: Lua config, not hyprland.conf

This setup uses Hyprland's **Lua** configuration. `~/.config/hypr/hyprland.conf` still exists on disk but is **dead** — nothing loads it. The entry point is `dot_config/hypr/hyprland.lua`, which `require`s each module in `dot_config/hypr/config/`.

Consequences that bite:

- **A module not `require`d in `hyprland.lua` is inert.** `~/.config/hypr/config/binds.lua` is a leftover stock CachyOS file that nothing loads and chezmoi does not track. `keybinds.lua` is the real one. Do not edit `binds.lua`.
- **`hyprctl dispatch` takes Lua**, not the classic dispatcher syntax. `hyprctl dispatch togglespecialworkspace` silently fails; the working form is `hyprctl dispatch 'hl.dsp.workspace.toggle_special("scratchpad")'`.
- The API stubs are the authoritative reference: `/usr/share/hypr/stubs/hl.meta.lua`. Upstream's annotated default config at `/usr/share/hypr/hyprland.lua` is the best source of working call syntax — check it before guessing at an `hl.dsp.*` signature.

Module roles worth knowing before editing: `variables.lua` holds the `TERMINAL`/`BROWSER`/`MONITOR1` globals other modules read; `monitors.lua` and `inputs.lua` are the machine-specific ones a new machine must edit; `windowrules.lua` routes games to a `name:game` workspace by class/xdg_tag.

### Verifying a keybind actually registered

A reload printing `ok` means the config was accepted, not that your bind exists — a typo'd module can leave you with a silently missing bind (Hyprland surfaces genuine Lua errors in its error overlay and log). Confirm by bind count and presence:

```bash
hyprctl binds -j | python3 -c "import json,sys; b=json.load(sys.stdin); print(len(b))"
```

Lua-defined binds show `dispatcher: __lua`, so the dispatcher name is not visible — match on `modmask` + `key` instead (SUPER = 64, SUPER+SHIFT = 65).

## Noctalia: three files, only one of which you edit

Noctalia (the bar/shell) splits its state across three places, and conflating them wastes time:

| File | Owner | Tracked | Role |
|---|---|---|---|
| `dot_config/noctalia/config.toml` | you | yes | Base config. **Bar layout lives here** (`start`/`center`/`end` arrays). |
| `~/.local/state/noctalia/settings.toml` | Noctalia | no | Runtime overlay: enabled plugins, `plugin_settings`, UI-set prefs. |
| `noctalia config export` | — | — | The merged effective config. Diagnostic only; do not write it back. |

Edit `config.toml` through chezmoi. Do **not** hand-edit `settings.toml` while Noctalia is running — it holds that state in memory and will flush over your edit.

Plugin management is CLI-driven, and the state it writes lands in `settings.toml`, not the repo:

```bash
noctalia msg plugins list                      # id, source, version, enabled/disabled
noctalia msg plugins enable noctalia/bongocat
noctalia msg plugins disable noctalia/bongocat
```

Enabling only installs it. A plugin that provides a bar widget also needs its `author/plugin:widget` id added to a bar array in `config.toml` — e.g. `"noctalia/bongocat:cat"`, `"jamesfeeder/special-workspaces:special-workspaces"`. Two steps, two files, two different mechanisms.

Plugin *settings* may hang off the widget rather than the plugin. If `settings-open-plugin <id>` returns "not enabled or has no settings", the manifest declares them under `[[widget.setting]]` and the command is:

```bash
noctalia msg settings-open-widget default "noctalia/bongocat:cat"
```

Downloaded plugins materialize to `~/.local/state/noctalia/plugins/materialized/<source>/<name>/`; reading the `plugin.toml` there is the fastest way to learn a plugin's widget id, settings keys and runtime dependencies. Disabling does not delete these files.

Plugins outside the official/community catalogs get pinned via `.chezmoiexternal.toml` as a tarball `type = "archive"`.

## Generated files: the main hazard

Noctalia owns a set of **color template** files that it rewrites on every theme or wallpaper change. Many are tracked by chezmoi, so they drift constantly and show up in `chezmoi status` as noise:

`dot_config/hypr/noctalia.lua`, `hypr/hyprtoolkit.conf`, `foot/themes/noctalia`, `qt5ct|qt6ct/colors/noctalia.conf`, `vesktop/themes/*`, `yazi/flavors/noctalia.yazi/*`, `zed/themes/noctalia.json`.

Which files these are is driven by `[theme.templates]` `builtin_ids` / `community_ids` in `config.toml` — and note that list differs between the tracked `config.toml` and live `settings.toml`, so the live set is larger than the repo suggests.

Two rules follow:

1. **Never hand-edit a theme-template output.** Change the palette in Noctalia and let it regenerate. Only some carry a `Generated by Noctalia` header (`hypr/noctalia.lua`, `zed/themes/noctalia.json`, `vesktop/themes/*`); the rest are equally generated but unmarked, so go by the `[theme.templates]` lists and the `noctalia` filename rather than looking for a header.
2. **Never run a bare `chezmoi apply`.** It reverts the live theme to whatever palette was last committed. Always name the file.

Not every drifting file is theme-related — `nvim/init.lua` and `fish/fish_variables` drift for their own reasons (the former over a `matugen` require block present only in the live file). Check `chezmoi diff` on a file before assuming it is generated.

`dot_config/hypr/noctalia.lua` is the bridge between the two systems: it exports a `colors` table that `hyprbars.lua` imports for button colors, and an `apply_theme()` that `hyprland.lua` calls last. The `colors_changed = [ "sleep 1 && hyprctl reload" ]` hook in `config.toml` is what makes Hyprland pick up a new palette immediately.

## hyprbars

`dot_config/hypr/config/hyprbars.lua` is an optional plugin, built out-of-tree and guarded twice: it returns early if the `.so` is missing, and again on the first config pass because Hyprland evaluates the config, loads plugins, then re-evaluates. Both guards are load-bearing — keep them if you restructure the file.

Buttons run **shell** commands, not Lua, so they shell out through `hyprctl dispatch '<lua>'`. With right alignment the first `add_button` call is the rightmost.

Build it once:

```bash
hyprpm update && hyprpm add https://github.com/hyprwm/hyprland-plugins && hyprpm enable hyprbars
```

## Verifying desktop changes

Inspect real runtime state rather than assuming the config took:

```bash
hyprctl clients -j     # per-window: workspace, geometry, class, floating, tags
hyprctl workspaces -j  # ids and window counts; special workspaces are negative
hyprctl monitors -j    # scale, reserved area, and the active special workspace
```

Gotchas found the hard way:

- An **empty special workspace does not render**. Toggling one with no windows in it looks like a broken bind. Test with a window in it.
- Special workspaces are created on demand by name and are unlimited, but **only one can be displayed per monitor at a time**.
- Moving a window to a special workspace and then changing the bind's name **strands that window invisibly**. Check for orphans in `hyprctl clients -j` after renaming one.
- Spawn throwaway test windows with `setsid kitty --title TESTNAME -e sleep 60` and close them by address afterwards. `hyprctl dispatch exec` is unreliable here.

## Conventions

Commits are **one concern each**, subject-only unless the reasoning is non-obvious, written in plain-English imperative describing the visible outcome — "Make unfocused windows 90% opaque", "Show CPU temp, RAM and network speed on the bar". No conventional-commit prefixes, no scopes.

Comments in the Lua configs explain *why* a line exists or what breaks without it, and stay sparse. Match that.

Several files are `.tmpl` (`qt5ct`, `qt6ct`) and go through chezmoi's templating — edit the `.tmpl`, not the rendered target.

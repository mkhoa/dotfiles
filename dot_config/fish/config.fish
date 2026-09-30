source /usr/share/cachyos-fish-config/cachyos-config.fish

# fastfetch on new kitty windows only, not in other terminals or editors,
# with a random Pokemon as the logo when pokemon-colorscripts is installed
function fish_greeting
    set -q KITTY_WINDOW_ID; or return
    type -q fastfetch; or return

    if type -q pokemon-colorscripts
        pokemon-colorscripts --no-title -r | fastfetch --logo-type file-raw --logo -
    else
        fastfetch
    end
end

if test -x /home/linuxbrew/.linuxbrew/bin/brew
    /home/linuxbrew/.linuxbrew/bin/brew shellenv fish | source
end

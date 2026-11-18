# .bashrc.d/functions.sh

# Create and jump to directory
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Update-all (system + flatpak)
update() {
    sudo dnf upgrade --refresh "$@" || return $?

    printf '────────────────────\n'

    flatpak update -y || return $?

    printf '────────────────────\n'

    if ! sudo dnf needs-restarting; then
        printf '\n'
        read -r -p 'Reboot now? [Y/n] ' answer
        case "$answer" in
            ""|[yY]|[yY][eE][sS]) systemctl reboot ;;
        esac
    fi
}

# Readline Vi-mode clipboard integration
_rl_copy() {
    printf "%s" "$READLINE_LINE" | wl-copy
}

_rl_paste() {
    local clip pos=$(( READLINE_POINT + $1 ))
    clip=$(wl-paste -n 2>/dev/null) || return
    (( pos > ${#READLINE_LINE} )) && pos=${#READLINE_LINE}
    READLINE_LINE="${READLINE_LINE:0:$pos}${clip}${READLINE_LINE:$pos}"
    READLINE_POINT=$(( pos + ${#clip} - 1 ))
}

bind -m vi-command -x '" y": _rl_copy'
bind -m vi-command -x '" p": _rl_paste 1'
bind -m vi-command -x '" P": _rl_paste 0'


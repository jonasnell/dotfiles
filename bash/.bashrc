# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Modular loading of settings
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

# Set nvim as default text editor
export EDITOR=/usr/bin/nvim

# Navigation & listing
alias ..='cd ..'
alias ...='cd ../..'
alias l='ls -CF'
alias la='ls -Ah'
alias lla='ls -Alh'

# Vim & Git
alias v='nvim'
alias vi='nvim'
alias sv='sudo nvim'
alias g='git'
alias gs='git status'
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit -m'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'
alias gb='git branch'
alias glog="git log --graph --oneline --decorate --all"

# Update-all (system + flatpak)
alias up='sudo dnf upgrade --refresh && flatpak update -y && sudo dnf needs-restarting'

# Mount/unmount Windows drive
alias mntwin='sudo mount -o uid=1000,gid=1000,umask=022,windows_names UUID=D27EA6587EA6355F /mnt/windows'
alias umntwin='sudo umount /mnt/windows'

# Create and jump to directory
mkcd() {
    mkdir -p "$1" && cd "$1"
}

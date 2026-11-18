# .bashrc.d/aliases.sh

# Navigation & listing
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'
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

# Mount/unmount Windows drive
alias mntwin='sudo mount -o uid=1000,gid=1000,umask=022,windows_names UUID=D27EA6587EA6355F /mnt/windows'
alias umntwin='sudo umount /mnt/windows'

